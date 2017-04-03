/*
  David Shull
  Operating Systems
  Dr. Sejong Yoon
  The College of New Jersey
  September 30th, 2016
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <sys/stat.h>

#define MAX_LINE 80 /* The maximum length command */
#define DELIM " \t\r\n\a" /* Characters at which to split the input */

/*
  Declare all non-command functions.
 */
int execute(char **args);
char* read_line(void);
char** parse(char *line);
int launch(char **args);
int history_insert(int count, char** cmd);
int delete_last_node();

/*
  Function Declarations for builtin shell commands.
 */
int ocd(char **args);
int oexit();
int omd(char **args);
int orm(char **args);
int ord(char **args);
int ocf(char **args);
int ohistory();
int previous_command();
int n_command(char **args);

/*
  List of builtin commands corresponding to the builtin functions.
 */
char *builtin_str[] = {
  "ocd",
  "oexit",
  "omd",
  "orm",
  "ord",
  "ocf",
  "ohistory",
  "!!",
  "!"
};

/*
  List of builtin functions corresponding to the builtin commands.
 */
int (*builtin_func[]) (char **) = {
  &ocd,
  &oexit,
  &omd,
  &orm,
  &ord,
  &ocf,
  &ohistory,
  &previous_command,
  &n_command
};

int should_run = 1; /* flag to determine when to exit program */
int command_count = 0; /* running tally of total commands input */

/*
  Nodes in which to store the commands, to be used as history.
 */
struct node {
  char** full_cmd;
  char* cmd;
  char* cmd_argument;
  int count;
  struct node *next;
};

struct node *head = NULL;

/*
  Specific node to keep track of where the first item in history is, used to
  keep the linkedlist of command history capped at 10 nodes
*/
struct node *first_in_history;

/*
  As long as "oexit" command hasn't been entered, continue to read input, parse
  the input for specific tokens, and execute those commands. Always clears the
  parsed input but saves the address of the command for use in history.
 */
int main(int argc, char **argv) {
  char **args; /* command line arguments */
  char *command;
  int status;

  while (should_run) {
    printf("osh> ");

    command = read_line();
    args = parse(command);
    status = execute(args);

    free(args);
  }
  return 0;
}

/*
  Reads and returns whatever has been input at the command line, limited to 80
  characters.
 */
char* read_line(void) {
  size_t length = MAX_LINE;
  char* line = NULL;
  getline(&line, &length, stdin);
  return line;
}

/*
  Takes a command line (passed from read_line, see main function) and splits it
  around spaces, newlines, tabs, etc. These new tokens are placed into an array,
  which will allow them to be used by the execute function. If the line starts
  with a single !, then it is treated slightly differently: the rest of the
  input is treated as an argument.
 */
char **parse(char *line) {
  int bufsize = MAX_LINE, position = 0;
  char **tokens = malloc(bufsize * sizeof(char*));
  char *token;

  if (!tokens) {
    fprintf(stderr, "osh: allocation error\n");
    exit(EXIT_FAILURE);
  }

  if(line[0] == '!' && line[1] != '!') {
    token = strtok(line, "!");
    tokens[0] = "!";
    tokens[1] = token;
    return tokens;
  }

  token = strtok(line, DELIM);
  while (token != NULL) {
    tokens[position] = token;
    position++;

    if (position >= bufsize) {
      bufsize += MAX_LINE;
      tokens = realloc(tokens, bufsize * sizeof(char*));
      if (!tokens) {
        fprintf(stderr, "osh: allocation error\n");
        exit(EXIT_FAILURE);
      }
    }

    token = strtok(NULL, DELIM);
  }
  tokens[position] = NULL;
  return tokens;
}

/*
  Forks a child process in which the function is executed. The parent process
  waits for the child process to complete, then ends once the child process is
  done.
 */
int launch(char **args) {
  pid_t pid, wpid;
  int status;

  pid = fork();
  if (pid == 0) {
    // Child process
    if (execvp(args[0], args) == -1) {
      perror("osh");
    }
    exit(EXIT_FAILURE);
  } else if (pid < 0) {
    // Error forking
    perror("osh");
  } else {
    // Parent process
    do {
      wpid = waitpid(pid, &status, WUNTRACED);
    } while (!WIFEXITED(status) && !WIFSIGNALED(status));
  }
  return 1;
}

/*
  Searches the builtin command strings to match the input, then executes the
  function associated with that string. Unless the input is to repeat a
  previous command, the input command is added to history and the number of
  commands is incremented.
 */
int execute(char **args) {
  int i;

  if (args[0] == NULL) {
    // An empty command was entered.
    return 1;
  }

  int len = sizeof(builtin_str) / sizeof(builtin_str[0]);

  for (i = 0; i < len; i++) {
    if (strcmp(args[0], builtin_str[i]) == 0) {
      if (strcmp(args[0], "!!") ==  0 || strcmp(args[0], "!") ==  0) {
        return (*builtin_func[i])(args);
      }
      command_count++;
      history_insert(command_count, args);
      return (*builtin_func[i])(args);
    }
  }
  return launch(args);
}

/*
  Changes the directory to the specified directory. An argument of ".." changes
  the directory to the preceding directory in the current directory's path.
 */
int ocd(char **args) {
  if (args[1] == NULL) {
    fprintf(stderr, "osh: expected argument to ocd\n");
  }
  else if (strncmp("..", args[1], MAX_LINE) == 0) {
    chdir("..");
  }
  else if (chdir(args[1]) != 0) {
      perror("osh");
  }
  char cwd[1024];
  if (getcwd(cwd, sizeof(cwd)) != NULL)
    printf("%s\n", cwd);
  return 1;
}

/*
  Creates a new directory with full permissions.
 */
int omd(char **args) {
  if (args[1] == NULL) {
    fprintf(stderr, "osh: expected argument to omd\n");
  } else {
    if (mkdir(args[1], 0777) != 0) {
      perror("osh");
    }
  }
  return 1;
}

/*
  Removes the specified file.
 */
int orm(char **args) {
  if (args[1] == NULL) {
    fprintf(stderr, "osh: expected argument to orm\n");
  } else {
    if (remove(args[1]) != 0) {
      perror("osh");
    }
  }
  return 1;
}

/*
  Removes the specified directory (if the directory is empty).
 */
int ord(char **args) {
  if (args[1] == NULL) {
    fprintf(stderr, "osh: expected argument to ord\n");
  } else {
    if (remove(args[1]) != 0) {
      perror("osh");
    }
  }
  return 1;
}

/*
  Creates the specified file with full permissions.
 */
int ocf(char **args) {
  if (args[1] == NULL) {
    fprintf(stderr, "osh: expected argument to ocf\n");
  }
  else if (access(args[1], F_OK) != -1) {
    printf("osh: File already exists.\n");
  }
  else if (fopen(args[1], "w+") == NULL) {
    perror("osh");
  }
  return 1;
}

/*
  Prints up to the most recent 10 commands and their command number to the
  console.
 */
int ohistory() {
  struct node *ptr = head;
  while(ptr != NULL) {
    printf("  %d\t%s ", ptr->count, ptr->cmd);
    if(ptr->cmd_argument != NULL) {
      printf("%s", ptr->cmd_argument);
    }
    printf("\n");
    ptr = ptr->next;
  }
  return 1;
}

/*
  Removes the oldest entry from the linkedlist of commands in history.
 */
int delete_last_node()
{
  struct node *temp1 = head;
  struct node *temp2;
  while(temp1->next != NULL)
  {
    temp2 = temp1;
    temp1 = temp1->next;
  }
  free(temp2->next);
  temp2->next = NULL;
  return 1;
}

/*
  Adds the newly input command into the history linkedlist. If there are more
  than ten items in history after this happens, the oldest entry is removed.
 */
int history_insert(int count, char** cmd) {
  struct node *link = (struct node*) malloc(sizeof(struct node));

  if(link == NULL){
    fprintf(stderr, "Unable to allocate memory for new node\n");
    exit(-1);
  }

  link->full_cmd = cmd;
  link->cmd = cmd[0];
  link->cmd_argument = cmd[1];
  link->count = count;
  link->next = head;
  head = link;

  if(count > 10) delete_last_node();

  return 1;
}

/*
  Performs the most recently entered command.
 */
int previous_command() {
  if(head == NULL) {
    printf("No commands in history.\n");
    return 0;
  }
  execute(&head->cmd);
  return 1;
}

/*
  Performs the n-th command entered, as long as the n-th command is in history.
 */
int n_command(char **args) {
  struct node *temp1 = head;
  while(temp1 != NULL) {
    int i = atoi(args[1]);
    if(temp1->count == i) {
      execute(&temp1->cmd);
      return 1;
    }
    temp1 = temp1->next;
  }
  printf("No such command in history.\n");
  return 0;
}

/*
  Exits the shell.
 */
int oexit() {
  should_run = 0;
  return 0;
}
