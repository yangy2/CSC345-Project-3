
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 dd 12 00 00       	call   12ee <exit>

  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 50 18 00 00 	mov    0x1850(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 24 18 00 00       	push   $0x1824
      2c:	e8 84 07 00 00       	call   7b5 <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 a5 12 00 00       	call   12ee <exit>

    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 c7 12 00 00       	call   1326 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 2b 18 00 00       	push   $0x182b
      71:	6a 02                	push   $0x2
      73:	e8 f5 13 00 00       	call   146d <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 81 12 00 00       	call   1316 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 80 12 00 00       	call   132e <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 3b 18 00 00       	push   $0x183b
      c4:	6a 02                	push   $0x2
      c6:	e8 a2 13 00 00       	call   146d <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 1b 12 00 00       	call   12ee <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 e0 06 00 00       	call   7d5 <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 e6 11 00 00       	call   12f6 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 c5 11 00 00       	call   12fe <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 4b 18 00 00       	push   $0x184b
     148:	e8 68 06 00 00       	call   7b5 <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 80 06 00 00       	call   7d5 <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 b3 11 00 00       	call   1316 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 f4 11 00 00       	call   1366 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 95 11 00 00       	call   1316 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 86 11 00 00       	call   1316 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 2b 06 00 00       	call   7d5 <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 5e 11 00 00       	call   1316 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 9f 11 00 00       	call   1366 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 40 11 00 00       	call   1316 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 31 11 00 00       	call   1316 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 10 11 00 00       	call   1316 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 01 11 00 00       	call   1316 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 d9 10 00 00       	call   12f6 <wait>
    wait();
     21d:	e8 d4 10 00 00       	call   12f6 <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 a6 05 00 00       	call   7d5 <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 a3 10 00 00       	call   12ee <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s ", path);
     251:	83 ec 04             	sub    $0x4,%esp
     254:	68 60 1e 00 00       	push   $0x1e60
     259:	68 68 18 00 00       	push   $0x1868
     25e:	6a 02                	push   $0x2
     260:	e8 08 12 00 00       	call   146d <printf>
     265:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     268:	8b 45 0c             	mov    0xc(%ebp),%eax
     26b:	83 ec 04             	sub    $0x4,%esp
     26e:	50                   	push   %eax
     26f:	6a 00                	push   $0x0
     271:	ff 75 08             	pushl  0x8(%ebp)
     274:	e8 da 0e 00 00       	call   1153 <memset>
     279:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     27c:	83 ec 08             	sub    $0x8,%esp
     27f:	ff 75 0c             	pushl  0xc(%ebp)
     282:	ff 75 08             	pushl  0x8(%ebp)
     285:	e8 16 0f 00 00       	call   11a0 <gets>
     28a:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     28d:	8b 45 08             	mov    0x8(%ebp),%eax
     290:	0f b6 00             	movzbl (%eax),%eax
     293:	84 c0                	test   %al,%al
     295:	75 07                	jne    29e <getcmd+0x53>
    return -1;
     297:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     29c:	eb 05                	jmp    2a3 <getcmd+0x58>
  return 0;
     29e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2a3:	c9                   	leave  
     2a4:	c3                   	ret    

000002a5 <print_history>:

void print_history(int arr_len) {
     2a5:	55                   	push   %ebp
     2a6:	89 e5                	mov    %esp,%ebp
     2a8:	83 ec 18             	sub    $0x18,%esp
  printf(2, "output: \n");
     2ab:	83 ec 08             	sub    $0x8,%esp
     2ae:	68 6c 18 00 00       	push   $0x186c
     2b3:	6a 02                	push   $0x2
     2b5:	e8 b3 11 00 00       	call   146d <printf>
     2ba:	83 c4 10             	add    $0x10,%esp
  int i = 0;
     2bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for(; i < arr_len; i++) {
     2c4:	eb 12                	jmp    2d8 <print_history+0x33>
    if(history[i] == NULL)
     2c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2c9:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     2d0:	85 c0                	test   %eax,%eax
     2d2:	74 0e                	je     2e2 <print_history+0x3d>
}

void print_history(int arr_len) {
  printf(2, "output: \n");
  int i = 0;
  for(; i < arr_len; i++) {
     2d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     2d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2db:	3b 45 08             	cmp    0x8(%ebp),%eax
     2de:	7c e6                	jl     2c6 <print_history+0x21>
     2e0:	eb 01                	jmp    2e3 <print_history+0x3e>
    if(history[i] == NULL)
      break;
     2e2:	90                   	nop
  }
  if(i <= 10)
     2e3:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
     2e7:	7f 09                	jg     2f2 <print_history+0x4d>
    i = 0;
     2e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2f0:	eb 4e                	jmp    340 <print_history+0x9b>
  else
    i -= 10;
     2f2:	83 6d f4 0a          	subl   $0xa,-0xc(%ebp)
  for(; i < arr_len; i++) {
     2f6:	eb 48                	jmp    340 <print_history+0x9b>
    if(history[i] != NULL) {
     2f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2fb:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     302:	85 c0                	test   %eax,%eax
     304:	74 44                	je     34a <print_history+0xa5>
      printf(2, "  %d\t", i+1);
     306:	8b 45 f4             	mov    -0xc(%ebp),%eax
     309:	83 c0 01             	add    $0x1,%eax
     30c:	83 ec 04             	sub    $0x4,%esp
     30f:	50                   	push   %eax
     310:	68 76 18 00 00       	push   $0x1876
     315:	6a 02                	push   $0x2
     317:	e8 51 11 00 00       	call   146d <printf>
     31c:	83 c4 10             	add    $0x10,%esp
      printf(2, history[i], "\n");
     31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     322:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     329:	83 ec 04             	sub    $0x4,%esp
     32c:	68 7c 18 00 00       	push   $0x187c
     331:	50                   	push   %eax
     332:	6a 02                	push   $0x2
     334:	e8 34 11 00 00       	call   146d <printf>
     339:	83 c4 10             	add    $0x10,%esp
  }
  if(i <= 10)
    i = 0;
  else
    i -= 10;
  for(; i < arr_len; i++) {
     33c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     340:	8b 45 f4             	mov    -0xc(%ebp),%eax
     343:	3b 45 08             	cmp    0x8(%ebp),%eax
     346:	7c b0                	jl     2f8 <print_history+0x53>
      printf(2, history[i], "\n");
    }
    else
      break;
  }
}
     348:	eb 01                	jmp    34b <print_history+0xa6>
    if(history[i] != NULL) {
      printf(2, "  %d\t", i+1);
      printf(2, history[i], "\n");
    }
    else
      break;
     34a:	90                   	nop
  }
}
     34b:	90                   	nop
     34c:	c9                   	leave  
     34d:	c3                   	ret    

0000034e <execute_prev>:

int execute_prev(int index, int arr_len, int should_wait) {
     34e:	55                   	push   %ebp
     34f:	89 e5                	mov    %esp,%ebp
     351:	83 ec 08             	sub    $0x8,%esp
  if(fork1() == 0) {
     354:	e8 7c 04 00 00       	call   7d5 <fork1>
     359:	85 c0                	test   %eax,%eax
     35b:	75 56                	jne    3b3 <execute_prev+0x65>
    if(strcmp(history[index], "history\n") == 0) {
     35d:	8b 45 08             	mov    0x8(%ebp),%eax
     360:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     367:	83 ec 08             	sub    $0x8,%esp
     36a:	68 7e 18 00 00       	push   $0x187e
     36f:	50                   	push   %eax
     370:	e8 78 0d 00 00       	call   10ed <strcmp>
     375:	83 c4 10             	add    $0x10,%esp
     378:	85 c0                	test   %eax,%eax
     37a:	75 15                	jne    391 <execute_prev+0x43>
      print_history(arr_len);
     37c:	83 ec 0c             	sub    $0xc,%esp
     37f:	ff 75 0c             	pushl  0xc(%ebp)
     382:	e8 1e ff ff ff       	call   2a5 <print_history>
     387:	83 c4 10             	add    $0x10,%esp
      return 1;
     38a:	b8 01 00 00 00       	mov    $0x1,%eax
     38f:	eb 32                	jmp    3c3 <execute_prev+0x75>
    }
    runcmd(parsecmd(history[index]));
     391:	8b 45 08             	mov    0x8(%ebp),%eax
     394:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     39b:	83 ec 0c             	sub    $0xc,%esp
     39e:	50                   	push   %eax
     39f:	e8 89 07 00 00       	call   b2d <parsecmd>
     3a4:	83 c4 10             	add    $0x10,%esp
     3a7:	83 ec 0c             	sub    $0xc,%esp
     3aa:	50                   	push   %eax
     3ab:	e8 50 fc ff ff       	call   0 <runcmd>
     3b0:	83 c4 10             	add    $0x10,%esp
  }
  if(should_wait)
     3b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     3b7:	74 05                	je     3be <execute_prev+0x70>
    wait();
     3b9:	e8 38 0f 00 00       	call   12f6 <wait>
  return 1;
     3be:	b8 01 00 00 00       	mov    $0x1,%eax
}
     3c3:	c9                   	leave  
     3c4:	c3                   	ret    

000003c5 <execute_last>:

/*
  Performs the last command in the history buffer.
*/
void execute_last(int arr_len, int should_wait) {
     3c5:	55                   	push   %ebp
     3c6:	89 e5                	mov    %esp,%ebp
     3c8:	83 ec 18             	sub    $0x18,%esp
  int i = 0;
     3cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for(; i < arr_len; i++) {
     3d2:	eb 18                	jmp    3ec <execute_last+0x27>
    if(history[i] == NULL) {
     3d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3d7:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     3de:	85 c0                	test   %eax,%eax
     3e0:	75 06                	jne    3e8 <execute_last+0x23>
      i--;
     3e2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      break;
     3e6:	eb 0c                	jmp    3f4 <execute_last+0x2f>
/*
  Performs the last command in the history buffer.
*/
void execute_last(int arr_len, int should_wait) {
  int i = 0;
  for(; i < arr_len; i++) {
     3e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     3ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ef:	3b 45 08             	cmp    0x8(%ebp),%eax
     3f2:	7c e0                	jl     3d4 <execute_last+0xf>
    if(history[i] == NULL) {
      i--;
      break;
    }
  }
  execute_prev(i, arr_len, should_wait);
     3f4:	83 ec 04             	sub    $0x4,%esp
     3f7:	ff 75 0c             	pushl  0xc(%ebp)
     3fa:	ff 75 08             	pushl  0x8(%ebp)
     3fd:	ff 75 f4             	pushl  -0xc(%ebp)
     400:	e8 49 ff ff ff       	call   34e <execute_prev>
     405:	83 c4 10             	add    $0x10,%esp
}
     408:	90                   	nop
     409:	c9                   	leave  
     40a:	c3                   	ret    

0000040b <should_wait>:

/*
  Determines whether the process will be a background process, based on
  whether the user input "&" after the command.
*/
int should_wait(char buf[], int buf_len) {
     40b:	55                   	push   %ebp
     40c:	89 e5                	mov    %esp,%ebp
     40e:	83 ec 10             	sub    $0x10,%esp
  int i = 0;
     411:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  for(; i < buf_len; i++) {
     418:	eb 13                	jmp    42d <should_wait+0x22>
    if(buf[i] == '\0') {
     41a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
     420:	01 d0                	add    %edx,%eax
     422:	0f b6 00             	movzbl (%eax),%eax
     425:	84 c0                	test   %al,%al
     427:	74 0e                	je     437 <should_wait+0x2c>
  Determines whether the process will be a background process, based on
  whether the user input "&" after the command.
*/
int should_wait(char buf[], int buf_len) {
  int i = 0;
  for(; i < buf_len; i++) {
     429:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     42d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     430:	3b 45 0c             	cmp    0xc(%ebp),%eax
     433:	7c e5                	jl     41a <should_wait+0xf>
     435:	eb 01                	jmp    438 <should_wait+0x2d>
    if(buf[i] == '\0') {
      break;
     437:	90                   	nop
    }
  }
  if(buf[i-1] == '&')
     438:	8b 45 fc             	mov    -0x4(%ebp),%eax
     43b:	8d 50 ff             	lea    -0x1(%eax),%edx
     43e:	8b 45 08             	mov    0x8(%ebp),%eax
     441:	01 d0                	add    %edx,%eax
     443:	0f b6 00             	movzbl (%eax),%eax
     446:	3c 26                	cmp    $0x26,%al
     448:	75 07                	jne    451 <should_wait+0x46>
    return 0;
     44a:	b8 00 00 00 00       	mov    $0x0,%eax
     44f:	eb 05                	jmp    456 <should_wait+0x4b>
  return 1;
     451:	b8 01 00 00 00       	mov    $0x1,%eax
}
     456:	c9                   	leave  
     457:	c3                   	ret    

00000458 <main>:

int
main(void)
{
     458:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     45c:	83 e4 f0             	and    $0xfffffff0,%esp
     45f:	ff 71 fc             	pushl  -0x4(%ecx)
     462:	55                   	push   %ebp
     463:	89 e5                	mov    %esp,%ebp
     465:	51                   	push   %ecx
     466:	83 ec 34             	sub    $0x34,%esp
  static char buf[100];
  int fd;
  int command_count; // tracks number of commands entered at console

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     469:	eb 16                	jmp    481 <main+0x29>
    if(fd >= 3){
     46b:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
     46f:	7e 10                	jle    481 <main+0x29>
      close(fd);
     471:	83 ec 0c             	sub    $0xc,%esp
     474:	ff 75 e0             	pushl  -0x20(%ebp)
     477:	e8 9a 0e 00 00       	call   1316 <close>
     47c:	83 c4 10             	add    $0x10,%esp
      break;
     47f:	eb 1b                	jmp    49c <main+0x44>
  static char buf[100];
  int fd;
  int command_count; // tracks number of commands entered at console

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     481:	83 ec 08             	sub    $0x8,%esp
     484:	6a 02                	push   $0x2
     486:	68 87 18 00 00       	push   $0x1887
     48b:	e8 9e 0e 00 00       	call   132e <open>
     490:	83 c4 10             	add    $0x10,%esp
     493:	89 45 e0             	mov    %eax,-0x20(%ebp)
     496:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     49a:	79 cf                	jns    46b <main+0x13>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     49c:	e9 f5 02 00 00       	jmp    796 <main+0x33e>
    int buf_len = strlen(buf);
     4a1:	83 ec 0c             	sub    $0xc,%esp
     4a4:	68 00 1f 00 00       	push   $0x1f00
     4a9:	e8 7e 0c 00 00       	call   112c <strlen>
     4ae:	83 c4 10             	add    $0x10,%esp
     4b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int waiter = should_wait(buf, buf_len);
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	ff 75 dc             	pushl  -0x24(%ebp)
     4ba:	68 00 1f 00 00       	push   $0x1f00
     4bf:	e8 47 ff ff ff       	call   40b <should_wait>
     4c4:	83 c4 10             	add    $0x10,%esp
     4c7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int arr_len = sizeof(history)/sizeof(history[0]);
     4ca:	c7 45 d4 64 00 00 00 	movl   $0x64,-0x2c(%ebp)

    if(buf[0] == '!') {
     4d1:	0f b6 05 00 1f 00 00 	movzbl 0x1f00,%eax
     4d8:	3c 21                	cmp    $0x21,%al
     4da:	75 52                	jne    52e <main+0xd6>
      if(buf[1] == '!') {
     4dc:	0f b6 05 01 1f 00 00 	movzbl 0x1f01,%eax
     4e3:	3c 21                	cmp    $0x21,%al
     4e5:	75 16                	jne    4fd <main+0xa5>
        execute_last(arr_len, waiter);
     4e7:	83 ec 08             	sub    $0x8,%esp
     4ea:	ff 75 d8             	pushl  -0x28(%ebp)
     4ed:	ff 75 d4             	pushl  -0x2c(%ebp)
     4f0:	e8 d0 fe ff ff       	call   3c5 <execute_last>
     4f5:	83 c4 10             	add    $0x10,%esp
        continue;
     4f8:	e9 99 02 00 00       	jmp    796 <main+0x33e>
      }
      else {
        int num = atoi(buf+1);
     4fd:	b8 01 1f 00 00       	mov    $0x1f01,%eax
     502:	83 ec 0c             	sub    $0xc,%esp
     505:	50                   	push   %eax
     506:	e8 51 0d 00 00       	call   125c <atoi>
     50b:	83 c4 10             	add    $0x10,%esp
     50e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        execute_prev(num-1, arr_len, waiter);
     511:	8b 45 d0             	mov    -0x30(%ebp),%eax
     514:	83 e8 01             	sub    $0x1,%eax
     517:	83 ec 04             	sub    $0x4,%esp
     51a:	ff 75 d8             	pushl  -0x28(%ebp)
     51d:	ff 75 d4             	pushl  -0x2c(%ebp)
     520:	50                   	push   %eax
     521:	e8 28 fe ff ff       	call   34e <execute_prev>
     526:	83 c4 10             	add    $0x10,%esp
        continue;
     529:	e9 68 02 00 00       	jmp    796 <main+0x33e>
      }
    }

    history[command_count] = malloc(sizeof(char)*(buf_len+1));
     52e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     531:	83 c0 01             	add    $0x1,%eax
     534:	83 ec 0c             	sub    $0xc,%esp
     537:	50                   	push   %eax
     538:	e8 03 12 00 00       	call   1740 <malloc>
     53d:	83 c4 10             	add    $0x10,%esp
     540:	89 c2                	mov    %eax,%edx
     542:	8b 45 f4             	mov    -0xc(%ebp),%eax
     545:	89 14 85 80 1f 00 00 	mov    %edx,0x1f80(,%eax,4)
    strcpy(history[command_count], buf);
     54c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     54f:	8b 04 85 80 1f 00 00 	mov    0x1f80(,%eax,4),%eax
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 00 1f 00 00       	push   $0x1f00
     55e:	50                   	push   %eax
     55f:	e8 59 0b 00 00       	call   10bd <strcpy>
     564:	83 c4 10             	add    $0x10,%esp
    command_count++;
     567:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    if(buf[0] == 'p' && buf[1] == 's') {
     56b:	0f b6 05 00 1f 00 00 	movzbl 0x1f00,%eax
     572:	3c 70                	cmp    $0x70,%al
     574:	75 49                	jne    5bf <main+0x167>
     576:	0f b6 05 01 1f 00 00 	movzbl 0x1f01,%eax
     57d:	3c 73                	cmp    $0x73,%al
     57f:	75 3e                	jne    5bf <main+0x167>
      buf[strlen(buf)-1] = 0;
     581:	83 ec 0c             	sub    $0xc,%esp
     584:	68 00 1f 00 00       	push   $0x1f00
     589:	e8 9e 0b 00 00       	call   112c <strlen>
     58e:	83 c4 10             	add    $0x10,%esp
     591:	83 e8 01             	sub    $0x1,%eax
     594:	c6 80 00 1f 00 00 00 	movb   $0x0,0x1f00(%eax)
      if(ps() < 0)
     59b:	e8 ee 0d 00 00       	call   138e <ps>
     5a0:	85 c0                	test   %eax,%eax
     5a2:	0f 89 ee 01 00 00    	jns    796 <main+0x33e>
        printf(2, "Did not work.");
     5a8:	83 ec 08             	sub    $0x8,%esp
     5ab:	68 8f 18 00 00       	push   $0x188f
     5b0:	6a 02                	push   $0x2
     5b2:	e8 b6 0e 00 00       	call   146d <printf>
     5b7:	83 c4 10             	add    $0x10,%esp
      continue;
     5ba:	e9 d7 01 00 00       	jmp    796 <main+0x33e>
    }

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     5bf:	0f b6 05 00 1f 00 00 	movzbl 0x1f00,%eax
     5c6:	3c 63                	cmp    $0x63,%al
     5c8:	0f 85 6f 01 00 00    	jne    73d <main+0x2e5>
     5ce:	0f b6 05 01 1f 00 00 	movzbl 0x1f01,%eax
     5d5:	3c 64                	cmp    $0x64,%al
     5d7:	0f 85 60 01 00 00    	jne    73d <main+0x2e5>
     5dd:	0f b6 05 02 1f 00 00 	movzbl 0x1f02,%eax
     5e4:	3c 20                	cmp    $0x20,%al
     5e6:	0f 85 51 01 00 00    	jne    73d <main+0x2e5>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      int path_len = sizeof(path)/sizeof(path[0]);
     5ec:	c7 45 cc 64 00 00 00 	movl   $0x64,-0x34(%ebp)
      buf[strlen(buf)-1] = 0;  // chop \n
     5f3:	83 ec 0c             	sub    $0xc,%esp
     5f6:	68 00 1f 00 00       	push   $0x1f00
     5fb:	e8 2c 0b 00 00       	call   112c <strlen>
     600:	83 c4 10             	add    $0x10,%esp
     603:	83 e8 01             	sub    $0x1,%eax
     606:	c6 80 00 1f 00 00 00 	movb   $0x0,0x1f00(%eax)
      if(chdir(buf+3) < 0)
     60d:	b8 03 1f 00 00       	mov    $0x1f03,%eax
     612:	83 ec 0c             	sub    $0xc,%esp
     615:	50                   	push   %eax
     616:	e8 43 0d 00 00       	call   135e <chdir>
     61b:	83 c4 10             	add    $0x10,%esp
     61e:	85 c0                	test   %eax,%eax
     620:	79 1d                	jns    63f <main+0x1e7>
        printf(2, "cannot cd %s\n", buf+3);
     622:	b8 03 1f 00 00       	mov    $0x1f03,%eax
     627:	83 ec 04             	sub    $0x4,%esp
     62a:	50                   	push   %eax
     62b:	68 9d 18 00 00       	push   $0x189d
     630:	6a 02                	push   $0x2
     632:	e8 36 0e 00 00       	call   146d <printf>
     637:	83 c4 10             	add    $0x10,%esp
     63a:	e9 57 01 00 00       	jmp    796 <main+0x33e>

      else if (buf[3] == '.' && buf[4] == '.') {
     63f:	0f b6 05 03 1f 00 00 	movzbl 0x1f03,%eax
     646:	3c 2e                	cmp    $0x2e,%al
     648:	0f 85 97 00 00 00    	jne    6e5 <main+0x28d>
     64e:	0f b6 05 04 1f 00 00 	movzbl 0x1f04,%eax
     655:	3c 2e                	cmp    $0x2e,%al
     657:	0f 85 88 00 00 00    	jne    6e5 <main+0x28d>
        int last_slash_idx = 1;
     65d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        int i = 1;
     664:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
        int true_path_len = 0;
     66b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
        for(; true_path_len < path_len; true_path_len++) {
     672:	eb 19                	jmp    68d <main+0x235>
          if(path[true_path_len] == '\0') {
     674:	8b 45 e8             	mov    -0x18(%ebp),%eax
     677:	05 60 1e 00 00       	add    $0x1e60,%eax
     67c:	0f b6 00             	movzbl (%eax),%eax
     67f:	84 c0                	test   %al,%al
     681:	75 06                	jne    689 <main+0x231>
            true_path_len--;
     683:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
            break;
     687:	eb 0c                	jmp    695 <main+0x23d>

      else if (buf[3] == '.' && buf[4] == '.') {
        int last_slash_idx = 1;
        int i = 1;
        int true_path_len = 0;
        for(; true_path_len < path_len; true_path_len++) {
     689:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
     68d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     690:	3b 45 cc             	cmp    -0x34(%ebp),%eax
     693:	7c df                	jl     674 <main+0x21c>
          if(path[true_path_len] == '\0') {
            true_path_len--;
            break;
          }
        }
        for(; i < true_path_len-1; i++) {
     695:	eb 19                	jmp    6b0 <main+0x258>
          if(path[i] == '/')
     697:	8b 45 ec             	mov    -0x14(%ebp),%eax
     69a:	05 60 1e 00 00       	add    $0x1e60,%eax
     69f:	0f b6 00             	movzbl (%eax),%eax
     6a2:	3c 2f                	cmp    $0x2f,%al
     6a4:	75 06                	jne    6ac <main+0x254>
            last_slash_idx = i;
     6a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
          if(path[true_path_len] == '\0') {
            true_path_len--;
            break;
          }
        }
        for(; i < true_path_len-1; i++) {
     6ac:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     6b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6b3:	83 e8 01             	sub    $0x1,%eax
     6b6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     6b9:	7f dc                	jg     697 <main+0x23f>
          if(path[i] == '/')
            last_slash_idx = i;
        }
        //printf(2, "%d\n", last_slash_idx);
        path[last_slash_idx+1] = '\0';
     6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6be:	83 c0 01             	add    $0x1,%eax
     6c1:	c6 80 60 1e 00 00 00 	movb   $0x0,0x1e60(%eax)
        for(; last_slash_idx < true_path_len; last_slash_idx++)
     6c8:	eb 11                	jmp    6db <main+0x283>
          current_path_idx--;
     6ca:	a1 c4 1e 00 00       	mov    0x1ec4,%eax
     6cf:	83 e8 01             	sub    $0x1,%eax
     6d2:	a3 c4 1e 00 00       	mov    %eax,0x1ec4
          if(path[i] == '/')
            last_slash_idx = i;
        }
        //printf(2, "%d\n", last_slash_idx);
        path[last_slash_idx+1] = '\0';
        for(; last_slash_idx < true_path_len; last_slash_idx++)
     6d7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6de:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     6e1:	7c e7                	jl     6ca <main+0x272>
      int path_len = sizeof(path)/sizeof(path[0]);
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);

      else if (buf[3] == '.' && buf[4] == '.') {
     6e3:	eb 56                	jmp    73b <main+0x2e3>
        path[last_slash_idx+1] = '\0';
        for(; last_slash_idx < true_path_len; last_slash_idx++)
          current_path_idx--;
      }
      else {
        for(int i = 3; i < path_len; i++) {
     6e5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
     6ec:	eb 45                	jmp    733 <main+0x2db>
          current_path_idx++;
     6ee:	a1 c4 1e 00 00       	mov    0x1ec4,%eax
     6f3:	83 c0 01             	add    $0x1,%eax
     6f6:	a3 c4 1e 00 00       	mov    %eax,0x1ec4
          if(buf[i] == '\0') {
     6fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6fe:	05 00 1f 00 00       	add    $0x1f00,%eax
     703:	0f b6 00             	movzbl (%eax),%eax
     706:	84 c0                	test   %al,%al
     708:	75 0e                	jne    718 <main+0x2c0>
            path[current_path_idx] = '/';
     70a:	a1 c4 1e 00 00       	mov    0x1ec4,%eax
     70f:	c6 80 60 1e 00 00 2f 	movb   $0x2f,0x1e60(%eax)
            break;
     716:	eb 23                	jmp    73b <main+0x2e3>
          }
          path[current_path_idx] = buf[i];
     718:	a1 c4 1e 00 00       	mov    0x1ec4,%eax
     71d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     720:	81 c2 00 1f 00 00    	add    $0x1f00,%edx
     726:	0f b6 12             	movzbl (%edx),%edx
     729:	88 90 60 1e 00 00    	mov    %dl,0x1e60(%eax)
        path[last_slash_idx+1] = '\0';
        for(; last_slash_idx < true_path_len; last_slash_idx++)
          current_path_idx--;
      }
      else {
        for(int i = 3; i < path_len; i++) {
     72f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     733:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     736:	3b 45 cc             	cmp    -0x34(%ebp),%eax
     739:	7c b3                	jl     6ee <main+0x296>
            break;
          }
          path[current_path_idx] = buf[i];
        }
      }
      continue;
     73b:	eb 59                	jmp    796 <main+0x33e>
    }

    if(strcmp(buf, "history\n") == 0) {
     73d:	83 ec 08             	sub    $0x8,%esp
     740:	68 7e 18 00 00       	push   $0x187e
     745:	68 00 1f 00 00       	push   $0x1f00
     74a:	e8 9e 09 00 00       	call   10ed <strcmp>
     74f:	83 c4 10             	add    $0x10,%esp
     752:	85 c0                	test   %eax,%eax
     754:	75 10                	jne    766 <main+0x30e>
      print_history(arr_len);
     756:	83 ec 0c             	sub    $0xc,%esp
     759:	ff 75 d4             	pushl  -0x2c(%ebp)
     75c:	e8 44 fb ff ff       	call   2a5 <print_history>
     761:	83 c4 10             	add    $0x10,%esp
      continue;
     764:	eb 30                	jmp    796 <main+0x33e>
    }
    if(fork1() == 0)
     766:	e8 6a 00 00 00       	call   7d5 <fork1>
     76b:	85 c0                	test   %eax,%eax
     76d:	75 1c                	jne    78b <main+0x333>
      runcmd(parsecmd(buf));
     76f:	83 ec 0c             	sub    $0xc,%esp
     772:	68 00 1f 00 00       	push   $0x1f00
     777:	e8 b1 03 00 00       	call   b2d <parsecmd>
     77c:	83 c4 10             	add    $0x10,%esp
     77f:	83 ec 0c             	sub    $0xc,%esp
     782:	50                   	push   %eax
     783:	e8 78 f8 ff ff       	call   0 <runcmd>
     788:	83 c4 10             	add    $0x10,%esp
    if(waiter)
     78b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
     78f:	74 05                	je     796 <main+0x33e>
      wait();
     791:	e8 60 0b 00 00       	call   12f6 <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     796:	83 ec 08             	sub    $0x8,%esp
     799:	6a 64                	push   $0x64
     79b:	68 00 1f 00 00       	push   $0x1f00
     7a0:	e8 a6 fa ff ff       	call   24b <getcmd>
     7a5:	83 c4 10             	add    $0x10,%esp
     7a8:	85 c0                	test   %eax,%eax
     7aa:	0f 89 f1 fc ff ff    	jns    4a1 <main+0x49>
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    if(waiter)
      wait();
  }
  exit();
     7b0:	e8 39 0b 00 00       	call   12ee <exit>

000007b5 <panic>:
}

void
panic(char *s)
{
     7b5:	55                   	push   %ebp
     7b6:	89 e5                	mov    %esp,%ebp
     7b8:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     7bb:	83 ec 04             	sub    $0x4,%esp
     7be:	ff 75 08             	pushl  0x8(%ebp)
     7c1:	68 ab 18 00 00       	push   $0x18ab
     7c6:	6a 02                	push   $0x2
     7c8:	e8 a0 0c 00 00       	call   146d <printf>
     7cd:	83 c4 10             	add    $0x10,%esp
  exit();
     7d0:	e8 19 0b 00 00       	call   12ee <exit>

000007d5 <fork1>:
}

int
fork1(void)
{
     7d5:	55                   	push   %ebp
     7d6:	89 e5                	mov    %esp,%ebp
     7d8:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     7db:	e8 06 0b 00 00       	call   12e6 <fork>
     7e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     7e3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7e7:	75 10                	jne    7f9 <fork1+0x24>
    panic("fork");
     7e9:	83 ec 0c             	sub    $0xc,%esp
     7ec:	68 af 18 00 00       	push   $0x18af
     7f1:	e8 bf ff ff ff       	call   7b5 <panic>
     7f6:	83 c4 10             	add    $0x10,%esp
  return pid;
     7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     7fc:	c9                   	leave  
     7fd:	c3                   	ret    

000007fe <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     7fe:	55                   	push   %ebp
     7ff:	89 e5                	mov    %esp,%ebp
     801:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     804:	83 ec 0c             	sub    $0xc,%esp
     807:	6a 54                	push   $0x54
     809:	e8 32 0f 00 00       	call   1740 <malloc>
     80e:	83 c4 10             	add    $0x10,%esp
     811:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     814:	83 ec 04             	sub    $0x4,%esp
     817:	6a 54                	push   $0x54
     819:	6a 00                	push   $0x0
     81b:	ff 75 f4             	pushl  -0xc(%ebp)
     81e:	e8 30 09 00 00       	call   1153 <memset>
     823:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     826:	8b 45 f4             	mov    -0xc(%ebp),%eax
     829:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     832:	c9                   	leave  
     833:	c3                   	ret    

00000834 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     834:	55                   	push   %ebp
     835:	89 e5                	mov    %esp,%ebp
     837:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     83a:	83 ec 0c             	sub    $0xc,%esp
     83d:	6a 18                	push   $0x18
     83f:	e8 fc 0e 00 00       	call   1740 <malloc>
     844:	83 c4 10             	add    $0x10,%esp
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     84a:	83 ec 04             	sub    $0x4,%esp
     84d:	6a 18                	push   $0x18
     84f:	6a 00                	push   $0x0
     851:	ff 75 f4             	pushl  -0xc(%ebp)
     854:	e8 fa 08 00 00       	call   1153 <memset>
     859:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85f:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     865:	8b 45 f4             	mov    -0xc(%ebp),%eax
     868:	8b 55 08             	mov    0x8(%ebp),%edx
     86b:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     871:	8b 55 0c             	mov    0xc(%ebp),%edx
     874:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	8b 55 10             	mov    0x10(%ebp),%edx
     87d:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     880:	8b 45 f4             	mov    -0xc(%ebp),%eax
     883:	8b 55 14             	mov    0x14(%ebp),%edx
     886:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     889:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88c:	8b 55 18             	mov    0x18(%ebp),%edx
     88f:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     892:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     895:	c9                   	leave  
     896:	c3                   	ret    

00000897 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     897:	55                   	push   %ebp
     898:	89 e5                	mov    %esp,%ebp
     89a:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     89d:	83 ec 0c             	sub    $0xc,%esp
     8a0:	6a 0c                	push   $0xc
     8a2:	e8 99 0e 00 00       	call   1740 <malloc>
     8a7:	83 c4 10             	add    $0x10,%esp
     8aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     8ad:	83 ec 04             	sub    $0x4,%esp
     8b0:	6a 0c                	push   $0xc
     8b2:	6a 00                	push   $0x0
     8b4:	ff 75 f4             	pushl  -0xc(%ebp)
     8b7:	e8 97 08 00 00       	call   1153 <memset>
     8bc:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     8bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c2:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cb:	8b 55 08             	mov    0x8(%ebp),%edx
     8ce:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     8d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d4:	8b 55 0c             	mov    0xc(%ebp),%edx
     8d7:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     8da:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8dd:	c9                   	leave  
     8de:	c3                   	ret    

000008df <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     8df:	55                   	push   %ebp
     8e0:	89 e5                	mov    %esp,%ebp
     8e2:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     8e5:	83 ec 0c             	sub    $0xc,%esp
     8e8:	6a 0c                	push   $0xc
     8ea:	e8 51 0e 00 00       	call   1740 <malloc>
     8ef:	83 c4 10             	add    $0x10,%esp
     8f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     8f5:	83 ec 04             	sub    $0x4,%esp
     8f8:	6a 0c                	push   $0xc
     8fa:	6a 00                	push   $0x0
     8fc:	ff 75 f4             	pushl  -0xc(%ebp)
     8ff:	e8 4f 08 00 00       	call   1153 <memset>
     904:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     907:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90a:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     910:	8b 45 f4             	mov    -0xc(%ebp),%eax
     913:	8b 55 08             	mov    0x8(%ebp),%edx
     916:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     919:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91c:	8b 55 0c             	mov    0xc(%ebp),%edx
     91f:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     922:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     925:	c9                   	leave  
     926:	c3                   	ret    

00000927 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     927:	55                   	push   %ebp
     928:	89 e5                	mov    %esp,%ebp
     92a:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     92d:	83 ec 0c             	sub    $0xc,%esp
     930:	6a 08                	push   $0x8
     932:	e8 09 0e 00 00       	call   1740 <malloc>
     937:	83 c4 10             	add    $0x10,%esp
     93a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     93d:	83 ec 04             	sub    $0x4,%esp
     940:	6a 08                	push   $0x8
     942:	6a 00                	push   $0x0
     944:	ff 75 f4             	pushl  -0xc(%ebp)
     947:	e8 07 08 00 00       	call   1153 <memset>
     94c:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     952:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     958:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95b:	8b 55 08             	mov    0x8(%ebp),%edx
     95e:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     964:	c9                   	leave  
     965:	c3                   	ret    

00000966 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     966:	55                   	push   %ebp
     967:	89 e5                	mov    %esp,%ebp
     969:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;

  s = *ps;
     96c:	8b 45 08             	mov    0x8(%ebp),%eax
     96f:	8b 00                	mov    (%eax),%eax
     971:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     974:	eb 04                	jmp    97a <gettoken+0x14>
    s++;
     976:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     980:	73 1e                	jae    9a0 <gettoken+0x3a>
     982:	8b 45 f4             	mov    -0xc(%ebp),%eax
     985:	0f b6 00             	movzbl (%eax),%eax
     988:	0f be c0             	movsbl %al,%eax
     98b:	83 ec 08             	sub    $0x8,%esp
     98e:	50                   	push   %eax
     98f:	68 c8 1e 00 00       	push   $0x1ec8
     994:	e8 d4 07 00 00       	call   116d <strchr>
     999:	83 c4 10             	add    $0x10,%esp
     99c:	85 c0                	test   %eax,%eax
     99e:	75 d6                	jne    976 <gettoken+0x10>
    s++;
  if(q)
     9a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9a4:	74 08                	je     9ae <gettoken+0x48>
    *q = s;
     9a6:	8b 45 10             	mov    0x10(%ebp),%eax
     9a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9ac:	89 10                	mov    %edx,(%eax)
  ret = *s;
     9ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b1:	0f b6 00             	movzbl (%eax),%eax
     9b4:	0f be c0             	movsbl %al,%eax
     9b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9bd:	0f b6 00             	movzbl (%eax),%eax
     9c0:	0f be c0             	movsbl %al,%eax
     9c3:	83 f8 29             	cmp    $0x29,%eax
     9c6:	7f 14                	jg     9dc <gettoken+0x76>
     9c8:	83 f8 28             	cmp    $0x28,%eax
     9cb:	7d 28                	jge    9f5 <gettoken+0x8f>
     9cd:	85 c0                	test   %eax,%eax
     9cf:	0f 84 94 00 00 00    	je     a69 <gettoken+0x103>
     9d5:	83 f8 26             	cmp    $0x26,%eax
     9d8:	74 1b                	je     9f5 <gettoken+0x8f>
     9da:	eb 3a                	jmp    a16 <gettoken+0xb0>
     9dc:	83 f8 3e             	cmp    $0x3e,%eax
     9df:	74 1a                	je     9fb <gettoken+0x95>
     9e1:	83 f8 3e             	cmp    $0x3e,%eax
     9e4:	7f 0a                	jg     9f0 <gettoken+0x8a>
     9e6:	83 e8 3b             	sub    $0x3b,%eax
     9e9:	83 f8 01             	cmp    $0x1,%eax
     9ec:	77 28                	ja     a16 <gettoken+0xb0>
     9ee:	eb 05                	jmp    9f5 <gettoken+0x8f>
     9f0:	83 f8 7c             	cmp    $0x7c,%eax
     9f3:	75 21                	jne    a16 <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     9f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     9f9:	eb 75                	jmp    a70 <gettoken+0x10a>
  case '>':
    s++;
     9fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a02:	0f b6 00             	movzbl (%eax),%eax
     a05:	3c 3e                	cmp    $0x3e,%al
     a07:	75 63                	jne    a6c <gettoken+0x106>
      ret = '+';
     a09:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     a10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     a14:	eb 56                	jmp    a6c <gettoken+0x106>
  default:
    ret = 'a';
     a16:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a1d:	eb 04                	jmp    a23 <gettoken+0xbd>
      s++;
     a1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a26:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a29:	73 44                	jae    a6f <gettoken+0x109>
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	0f b6 00             	movzbl (%eax),%eax
     a31:	0f be c0             	movsbl %al,%eax
     a34:	83 ec 08             	sub    $0x8,%esp
     a37:	50                   	push   %eax
     a38:	68 c8 1e 00 00       	push   $0x1ec8
     a3d:	e8 2b 07 00 00       	call   116d <strchr>
     a42:	83 c4 10             	add    $0x10,%esp
     a45:	85 c0                	test   %eax,%eax
     a47:	75 26                	jne    a6f <gettoken+0x109>
     a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4c:	0f b6 00             	movzbl (%eax),%eax
     a4f:	0f be c0             	movsbl %al,%eax
     a52:	83 ec 08             	sub    $0x8,%esp
     a55:	50                   	push   %eax
     a56:	68 d0 1e 00 00       	push   $0x1ed0
     a5b:	e8 0d 07 00 00       	call   116d <strchr>
     a60:	83 c4 10             	add    $0x10,%esp
     a63:	85 c0                	test   %eax,%eax
     a65:	74 b8                	je     a1f <gettoken+0xb9>
      s++;
    break;
     a67:	eb 06                	jmp    a6f <gettoken+0x109>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     a69:	90                   	nop
     a6a:	eb 04                	jmp    a70 <gettoken+0x10a>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     a6c:	90                   	nop
     a6d:	eb 01                	jmp    a70 <gettoken+0x10a>
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
     a6f:	90                   	nop
  }
  if(eq)
     a70:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     a74:	74 0e                	je     a84 <gettoken+0x11e>
    *eq = s;
     a76:	8b 45 14             	mov    0x14(%ebp),%eax
     a79:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a7c:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     a7e:	eb 04                	jmp    a84 <gettoken+0x11e>
    s++;
     a80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a87:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a8a:	73 1e                	jae    aaa <gettoken+0x144>
     a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8f:	0f b6 00             	movzbl (%eax),%eax
     a92:	0f be c0             	movsbl %al,%eax
     a95:	83 ec 08             	sub    $0x8,%esp
     a98:	50                   	push   %eax
     a99:	68 c8 1e 00 00       	push   $0x1ec8
     a9e:	e8 ca 06 00 00       	call   116d <strchr>
     aa3:	83 c4 10             	add    $0x10,%esp
     aa6:	85 c0                	test   %eax,%eax
     aa8:	75 d6                	jne    a80 <gettoken+0x11a>
    s++;
  *ps = s;
     aaa:	8b 45 08             	mov    0x8(%ebp),%eax
     aad:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ab0:	89 10                	mov    %edx,(%eax)
  return ret;
     ab2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ab5:	c9                   	leave  
     ab6:	c3                   	ret    

00000ab7 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     ab7:	55                   	push   %ebp
     ab8:	89 e5                	mov    %esp,%ebp
     aba:	83 ec 18             	sub    $0x18,%esp
  char *s;

  s = *ps;
     abd:	8b 45 08             	mov    0x8(%ebp),%eax
     ac0:	8b 00                	mov    (%eax),%eax
     ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     ac5:	eb 04                	jmp    acb <peek+0x14>
    s++;
     ac7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ace:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ad1:	73 1e                	jae    af1 <peek+0x3a>
     ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad6:	0f b6 00             	movzbl (%eax),%eax
     ad9:	0f be c0             	movsbl %al,%eax
     adc:	83 ec 08             	sub    $0x8,%esp
     adf:	50                   	push   %eax
     ae0:	68 c8 1e 00 00       	push   $0x1ec8
     ae5:	e8 83 06 00 00       	call   116d <strchr>
     aea:	83 c4 10             	add    $0x10,%esp
     aed:	85 c0                	test   %eax,%eax
     aef:	75 d6                	jne    ac7 <peek+0x10>
    s++;
  *ps = s;
     af1:	8b 45 08             	mov    0x8(%ebp),%eax
     af4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     af7:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     af9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afc:	0f b6 00             	movzbl (%eax),%eax
     aff:	84 c0                	test   %al,%al
     b01:	74 23                	je     b26 <peek+0x6f>
     b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b06:	0f b6 00             	movzbl (%eax),%eax
     b09:	0f be c0             	movsbl %al,%eax
     b0c:	83 ec 08             	sub    $0x8,%esp
     b0f:	50                   	push   %eax
     b10:	ff 75 10             	pushl  0x10(%ebp)
     b13:	e8 55 06 00 00       	call   116d <strchr>
     b18:	83 c4 10             	add    $0x10,%esp
     b1b:	85 c0                	test   %eax,%eax
     b1d:	74 07                	je     b26 <peek+0x6f>
     b1f:	b8 01 00 00 00       	mov    $0x1,%eax
     b24:	eb 05                	jmp    b2b <peek+0x74>
     b26:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b2b:	c9                   	leave  
     b2c:	c3                   	ret    

00000b2d <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     b2d:	55                   	push   %ebp
     b2e:	89 e5                	mov    %esp,%ebp
     b30:	53                   	push   %ebx
     b31:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     b34:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b37:	8b 45 08             	mov    0x8(%ebp),%eax
     b3a:	83 ec 0c             	sub    $0xc,%esp
     b3d:	50                   	push   %eax
     b3e:	e8 e9 05 00 00       	call   112c <strlen>
     b43:	83 c4 10             	add    $0x10,%esp
     b46:	01 d8                	add    %ebx,%eax
     b48:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     b4b:	83 ec 08             	sub    $0x8,%esp
     b4e:	ff 75 f4             	pushl  -0xc(%ebp)
     b51:	8d 45 08             	lea    0x8(%ebp),%eax
     b54:	50                   	push   %eax
     b55:	e8 61 00 00 00       	call   bbb <parseline>
     b5a:	83 c4 10             	add    $0x10,%esp
     b5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     b60:	83 ec 04             	sub    $0x4,%esp
     b63:	68 b4 18 00 00       	push   $0x18b4
     b68:	ff 75 f4             	pushl  -0xc(%ebp)
     b6b:	8d 45 08             	lea    0x8(%ebp),%eax
     b6e:	50                   	push   %eax
     b6f:	e8 43 ff ff ff       	call   ab7 <peek>
     b74:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     b77:	8b 45 08             	mov    0x8(%ebp),%eax
     b7a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     b7d:	74 26                	je     ba5 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     b7f:	8b 45 08             	mov    0x8(%ebp),%eax
     b82:	83 ec 04             	sub    $0x4,%esp
     b85:	50                   	push   %eax
     b86:	68 b5 18 00 00       	push   $0x18b5
     b8b:	6a 02                	push   $0x2
     b8d:	e8 db 08 00 00       	call   146d <printf>
     b92:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     b95:	83 ec 0c             	sub    $0xc,%esp
     b98:	68 c4 18 00 00       	push   $0x18c4
     b9d:	e8 13 fc ff ff       	call   7b5 <panic>
     ba2:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     ba5:	83 ec 0c             	sub    $0xc,%esp
     ba8:	ff 75 f0             	pushl  -0x10(%ebp)
     bab:	e8 eb 03 00 00       	call   f9b <nulterminate>
     bb0:	83 c4 10             	add    $0x10,%esp
  return cmd;
     bb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     bb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bb9:	c9                   	leave  
     bba:	c3                   	ret    

00000bbb <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     bbb:	55                   	push   %ebp
     bbc:	89 e5                	mov    %esp,%ebp
     bbe:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     bc1:	83 ec 08             	sub    $0x8,%esp
     bc4:	ff 75 0c             	pushl  0xc(%ebp)
     bc7:	ff 75 08             	pushl  0x8(%ebp)
     bca:	e8 99 00 00 00       	call   c68 <parsepipe>
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     bd5:	eb 23                	jmp    bfa <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     bd7:	6a 00                	push   $0x0
     bd9:	6a 00                	push   $0x0
     bdb:	ff 75 0c             	pushl  0xc(%ebp)
     bde:	ff 75 08             	pushl  0x8(%ebp)
     be1:	e8 80 fd ff ff       	call   966 <gettoken>
     be6:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     be9:	83 ec 0c             	sub    $0xc,%esp
     bec:	ff 75 f4             	pushl  -0xc(%ebp)
     bef:	e8 33 fd ff ff       	call   927 <backcmd>
     bf4:	83 c4 10             	add    $0x10,%esp
     bf7:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     bfa:	83 ec 04             	sub    $0x4,%esp
     bfd:	68 cb 18 00 00       	push   $0x18cb
     c02:	ff 75 0c             	pushl  0xc(%ebp)
     c05:	ff 75 08             	pushl  0x8(%ebp)
     c08:	e8 aa fe ff ff       	call   ab7 <peek>
     c0d:	83 c4 10             	add    $0x10,%esp
     c10:	85 c0                	test   %eax,%eax
     c12:	75 c3                	jne    bd7 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     c14:	83 ec 04             	sub    $0x4,%esp
     c17:	68 cd 18 00 00       	push   $0x18cd
     c1c:	ff 75 0c             	pushl  0xc(%ebp)
     c1f:	ff 75 08             	pushl  0x8(%ebp)
     c22:	e8 90 fe ff ff       	call   ab7 <peek>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	85 c0                	test   %eax,%eax
     c2c:	74 35                	je     c63 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     c2e:	6a 00                	push   $0x0
     c30:	6a 00                	push   $0x0
     c32:	ff 75 0c             	pushl  0xc(%ebp)
     c35:	ff 75 08             	pushl  0x8(%ebp)
     c38:	e8 29 fd ff ff       	call   966 <gettoken>
     c3d:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     c40:	83 ec 08             	sub    $0x8,%esp
     c43:	ff 75 0c             	pushl  0xc(%ebp)
     c46:	ff 75 08             	pushl  0x8(%ebp)
     c49:	e8 6d ff ff ff       	call   bbb <parseline>
     c4e:	83 c4 10             	add    $0x10,%esp
     c51:	83 ec 08             	sub    $0x8,%esp
     c54:	50                   	push   %eax
     c55:	ff 75 f4             	pushl  -0xc(%ebp)
     c58:	e8 82 fc ff ff       	call   8df <listcmd>
     c5d:	83 c4 10             	add    $0x10,%esp
     c60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     c63:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c66:	c9                   	leave  
     c67:	c3                   	ret    

00000c68 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     c68:	55                   	push   %ebp
     c69:	89 e5                	mov    %esp,%ebp
     c6b:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     c6e:	83 ec 08             	sub    $0x8,%esp
     c71:	ff 75 0c             	pushl  0xc(%ebp)
     c74:	ff 75 08             	pushl  0x8(%ebp)
     c77:	e8 ec 01 00 00       	call   e68 <parseexec>
     c7c:	83 c4 10             	add    $0x10,%esp
     c7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     c82:	83 ec 04             	sub    $0x4,%esp
     c85:	68 cf 18 00 00       	push   $0x18cf
     c8a:	ff 75 0c             	pushl  0xc(%ebp)
     c8d:	ff 75 08             	pushl  0x8(%ebp)
     c90:	e8 22 fe ff ff       	call   ab7 <peek>
     c95:	83 c4 10             	add    $0x10,%esp
     c98:	85 c0                	test   %eax,%eax
     c9a:	74 35                	je     cd1 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     c9c:	6a 00                	push   $0x0
     c9e:	6a 00                	push   $0x0
     ca0:	ff 75 0c             	pushl  0xc(%ebp)
     ca3:	ff 75 08             	pushl  0x8(%ebp)
     ca6:	e8 bb fc ff ff       	call   966 <gettoken>
     cab:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     cae:	83 ec 08             	sub    $0x8,%esp
     cb1:	ff 75 0c             	pushl  0xc(%ebp)
     cb4:	ff 75 08             	pushl  0x8(%ebp)
     cb7:	e8 ac ff ff ff       	call   c68 <parsepipe>
     cbc:	83 c4 10             	add    $0x10,%esp
     cbf:	83 ec 08             	sub    $0x8,%esp
     cc2:	50                   	push   %eax
     cc3:	ff 75 f4             	pushl  -0xc(%ebp)
     cc6:	e8 cc fb ff ff       	call   897 <pipecmd>
     ccb:	83 c4 10             	add    $0x10,%esp
     cce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cd4:	c9                   	leave  
     cd5:	c3                   	ret    

00000cd6 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     cd6:	55                   	push   %ebp
     cd7:	89 e5                	mov    %esp,%ebp
     cd9:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     cdc:	e9 b6 00 00 00       	jmp    d97 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     ce1:	6a 00                	push   $0x0
     ce3:	6a 00                	push   $0x0
     ce5:	ff 75 10             	pushl  0x10(%ebp)
     ce8:	ff 75 0c             	pushl  0xc(%ebp)
     ceb:	e8 76 fc ff ff       	call   966 <gettoken>
     cf0:	83 c4 10             	add    $0x10,%esp
     cf3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     cf6:	8d 45 ec             	lea    -0x14(%ebp),%eax
     cf9:	50                   	push   %eax
     cfa:	8d 45 f0             	lea    -0x10(%ebp),%eax
     cfd:	50                   	push   %eax
     cfe:	ff 75 10             	pushl  0x10(%ebp)
     d01:	ff 75 0c             	pushl  0xc(%ebp)
     d04:	e8 5d fc ff ff       	call   966 <gettoken>
     d09:	83 c4 10             	add    $0x10,%esp
     d0c:	83 f8 61             	cmp    $0x61,%eax
     d0f:	74 10                	je     d21 <parseredirs+0x4b>
      panic("missing file for redirection");
     d11:	83 ec 0c             	sub    $0xc,%esp
     d14:	68 d1 18 00 00       	push   $0x18d1
     d19:	e8 97 fa ff ff       	call   7b5 <panic>
     d1e:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d24:	83 f8 3c             	cmp    $0x3c,%eax
     d27:	74 0c                	je     d35 <parseredirs+0x5f>
     d29:	83 f8 3e             	cmp    $0x3e,%eax
     d2c:	74 26                	je     d54 <parseredirs+0x7e>
     d2e:	83 f8 2b             	cmp    $0x2b,%eax
     d31:	74 43                	je     d76 <parseredirs+0xa0>
     d33:	eb 62                	jmp    d97 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     d35:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d3b:	83 ec 0c             	sub    $0xc,%esp
     d3e:	6a 00                	push   $0x0
     d40:	6a 00                	push   $0x0
     d42:	52                   	push   %edx
     d43:	50                   	push   %eax
     d44:	ff 75 08             	pushl  0x8(%ebp)
     d47:	e8 e8 fa ff ff       	call   834 <redircmd>
     d4c:	83 c4 20             	add    $0x20,%esp
     d4f:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     d52:	eb 43                	jmp    d97 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     d54:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d5a:	83 ec 0c             	sub    $0xc,%esp
     d5d:	6a 01                	push   $0x1
     d5f:	68 01 02 00 00       	push   $0x201
     d64:	52                   	push   %edx
     d65:	50                   	push   %eax
     d66:	ff 75 08             	pushl  0x8(%ebp)
     d69:	e8 c6 fa ff ff       	call   834 <redircmd>
     d6e:	83 c4 20             	add    $0x20,%esp
     d71:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     d74:	eb 21                	jmp    d97 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     d76:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d7c:	83 ec 0c             	sub    $0xc,%esp
     d7f:	6a 01                	push   $0x1
     d81:	68 01 02 00 00       	push   $0x201
     d86:	52                   	push   %edx
     d87:	50                   	push   %eax
     d88:	ff 75 08             	pushl  0x8(%ebp)
     d8b:	e8 a4 fa ff ff       	call   834 <redircmd>
     d90:	83 c4 20             	add    $0x20,%esp
     d93:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     d96:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     d97:	83 ec 04             	sub    $0x4,%esp
     d9a:	68 ee 18 00 00       	push   $0x18ee
     d9f:	ff 75 10             	pushl  0x10(%ebp)
     da2:	ff 75 0c             	pushl  0xc(%ebp)
     da5:	e8 0d fd ff ff       	call   ab7 <peek>
     daa:	83 c4 10             	add    $0x10,%esp
     dad:	85 c0                	test   %eax,%eax
     daf:	0f 85 2c ff ff ff    	jne    ce1 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     db5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     db8:	c9                   	leave  
     db9:	c3                   	ret    

00000dba <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     dba:	55                   	push   %ebp
     dbb:	89 e5                	mov    %esp,%ebp
     dbd:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     dc0:	83 ec 04             	sub    $0x4,%esp
     dc3:	68 f1 18 00 00       	push   $0x18f1
     dc8:	ff 75 0c             	pushl  0xc(%ebp)
     dcb:	ff 75 08             	pushl  0x8(%ebp)
     dce:	e8 e4 fc ff ff       	call   ab7 <peek>
     dd3:	83 c4 10             	add    $0x10,%esp
     dd6:	85 c0                	test   %eax,%eax
     dd8:	75 10                	jne    dea <parseblock+0x30>
    panic("parseblock");
     dda:	83 ec 0c             	sub    $0xc,%esp
     ddd:	68 f3 18 00 00       	push   $0x18f3
     de2:	e8 ce f9 ff ff       	call   7b5 <panic>
     de7:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     dea:	6a 00                	push   $0x0
     dec:	6a 00                	push   $0x0
     dee:	ff 75 0c             	pushl  0xc(%ebp)
     df1:	ff 75 08             	pushl  0x8(%ebp)
     df4:	e8 6d fb ff ff       	call   966 <gettoken>
     df9:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     dfc:	83 ec 08             	sub    $0x8,%esp
     dff:	ff 75 0c             	pushl  0xc(%ebp)
     e02:	ff 75 08             	pushl  0x8(%ebp)
     e05:	e8 b1 fd ff ff       	call   bbb <parseline>
     e0a:	83 c4 10             	add    $0x10,%esp
     e0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     e10:	83 ec 04             	sub    $0x4,%esp
     e13:	68 fe 18 00 00       	push   $0x18fe
     e18:	ff 75 0c             	pushl  0xc(%ebp)
     e1b:	ff 75 08             	pushl  0x8(%ebp)
     e1e:	e8 94 fc ff ff       	call   ab7 <peek>
     e23:	83 c4 10             	add    $0x10,%esp
     e26:	85 c0                	test   %eax,%eax
     e28:	75 10                	jne    e3a <parseblock+0x80>
    panic("syntax - missing )");
     e2a:	83 ec 0c             	sub    $0xc,%esp
     e2d:	68 00 19 00 00       	push   $0x1900
     e32:	e8 7e f9 ff ff       	call   7b5 <panic>
     e37:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     e3a:	6a 00                	push   $0x0
     e3c:	6a 00                	push   $0x0
     e3e:	ff 75 0c             	pushl  0xc(%ebp)
     e41:	ff 75 08             	pushl  0x8(%ebp)
     e44:	e8 1d fb ff ff       	call   966 <gettoken>
     e49:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     e4c:	83 ec 04             	sub    $0x4,%esp
     e4f:	ff 75 0c             	pushl  0xc(%ebp)
     e52:	ff 75 08             	pushl  0x8(%ebp)
     e55:	ff 75 f4             	pushl  -0xc(%ebp)
     e58:	e8 79 fe ff ff       	call   cd6 <parseredirs>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e66:	c9                   	leave  
     e67:	c3                   	ret    

00000e68 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     e68:	55                   	push   %ebp
     e69:	89 e5                	mov    %esp,%ebp
     e6b:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     e6e:	83 ec 04             	sub    $0x4,%esp
     e71:	68 f1 18 00 00       	push   $0x18f1
     e76:	ff 75 0c             	pushl  0xc(%ebp)
     e79:	ff 75 08             	pushl  0x8(%ebp)
     e7c:	e8 36 fc ff ff       	call   ab7 <peek>
     e81:	83 c4 10             	add    $0x10,%esp
     e84:	85 c0                	test   %eax,%eax
     e86:	74 16                	je     e9e <parseexec+0x36>
    return parseblock(ps, es);
     e88:	83 ec 08             	sub    $0x8,%esp
     e8b:	ff 75 0c             	pushl  0xc(%ebp)
     e8e:	ff 75 08             	pushl  0x8(%ebp)
     e91:	e8 24 ff ff ff       	call   dba <parseblock>
     e96:	83 c4 10             	add    $0x10,%esp
     e99:	e9 fb 00 00 00       	jmp    f99 <parseexec+0x131>

  ret = execcmd();
     e9e:	e8 5b f9 ff ff       	call   7fe <execcmd>
     ea3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     ea6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ea9:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     eac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     eb3:	83 ec 04             	sub    $0x4,%esp
     eb6:	ff 75 0c             	pushl  0xc(%ebp)
     eb9:	ff 75 08             	pushl  0x8(%ebp)
     ebc:	ff 75 f0             	pushl  -0x10(%ebp)
     ebf:	e8 12 fe ff ff       	call   cd6 <parseredirs>
     ec4:	83 c4 10             	add    $0x10,%esp
     ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     eca:	e9 87 00 00 00       	jmp    f56 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ecf:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ed2:	50                   	push   %eax
     ed3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     ed6:	50                   	push   %eax
     ed7:	ff 75 0c             	pushl  0xc(%ebp)
     eda:	ff 75 08             	pushl  0x8(%ebp)
     edd:	e8 84 fa ff ff       	call   966 <gettoken>
     ee2:	83 c4 10             	add    $0x10,%esp
     ee5:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ee8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eec:	0f 84 84 00 00 00    	je     f76 <parseexec+0x10e>
      break;
    if(tok != 'a')
     ef2:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ef6:	74 10                	je     f08 <parseexec+0xa0>
      panic("syntax");
     ef8:	83 ec 0c             	sub    $0xc,%esp
     efb:	68 c4 18 00 00       	push   $0x18c4
     f00:	e8 b0 f8 ff ff       	call   7b5 <panic>
     f05:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     f08:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     f0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f11:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     f15:	8b 55 e0             	mov    -0x20(%ebp),%edx
     f18:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f1b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     f1e:	83 c1 08             	add    $0x8,%ecx
     f21:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     f25:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     f29:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     f2d:	7e 10                	jle    f3f <parseexec+0xd7>
      panic("too many args");
     f2f:	83 ec 0c             	sub    $0xc,%esp
     f32:	68 13 19 00 00       	push   $0x1913
     f37:	e8 79 f8 ff ff       	call   7b5 <panic>
     f3c:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     f3f:	83 ec 04             	sub    $0x4,%esp
     f42:	ff 75 0c             	pushl  0xc(%ebp)
     f45:	ff 75 08             	pushl  0x8(%ebp)
     f48:	ff 75 f0             	pushl  -0x10(%ebp)
     f4b:	e8 86 fd ff ff       	call   cd6 <parseredirs>
     f50:	83 c4 10             	add    $0x10,%esp
     f53:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     f56:	83 ec 04             	sub    $0x4,%esp
     f59:	68 21 19 00 00       	push   $0x1921
     f5e:	ff 75 0c             	pushl  0xc(%ebp)
     f61:	ff 75 08             	pushl  0x8(%ebp)
     f64:	e8 4e fb ff ff       	call   ab7 <peek>
     f69:	83 c4 10             	add    $0x10,%esp
     f6c:	85 c0                	test   %eax,%eax
     f6e:	0f 84 5b ff ff ff    	je     ecf <parseexec+0x67>
     f74:	eb 01                	jmp    f77 <parseexec+0x10f>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     f76:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     f77:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f7d:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     f84:	00 
  cmd->eargv[argc] = 0;
     f85:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f88:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f8b:	83 c2 08             	add    $0x8,%edx
     f8e:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     f95:	00 
  return ret;
     f96:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f99:	c9                   	leave  
     f9a:	c3                   	ret    

00000f9b <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     f9b:	55                   	push   %ebp
     f9c:	89 e5                	mov    %esp,%ebp
     f9e:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     fa1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     fa5:	75 0a                	jne    fb1 <nulterminate+0x16>
    return 0;
     fa7:	b8 00 00 00 00       	mov    $0x0,%eax
     fac:	e9 e4 00 00 00       	jmp    1095 <nulterminate+0xfa>

  switch(cmd->type){
     fb1:	8b 45 08             	mov    0x8(%ebp),%eax
     fb4:	8b 00                	mov    (%eax),%eax
     fb6:	83 f8 05             	cmp    $0x5,%eax
     fb9:	0f 87 d3 00 00 00    	ja     1092 <nulterminate+0xf7>
     fbf:	8b 04 85 28 19 00 00 	mov    0x1928(,%eax,4),%eax
     fc6:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     fc8:	8b 45 08             	mov    0x8(%ebp),%eax
     fcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     fce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fd5:	eb 14                	jmp    feb <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     fd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fda:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fdd:	83 c2 08             	add    $0x8,%edx
     fe0:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     fe4:	c6 00 00             	movb   $0x0,(%eax)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     fe7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     feb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fee:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ff1:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     ff5:	85 c0                	test   %eax,%eax
     ff7:	75 de                	jne    fd7 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     ff9:	e9 94 00 00 00       	jmp    1092 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     ffe:	8b 45 08             	mov    0x8(%ebp),%eax
    1001:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1004:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1007:	8b 40 04             	mov    0x4(%eax),%eax
    100a:	83 ec 0c             	sub    $0xc,%esp
    100d:	50                   	push   %eax
    100e:	e8 88 ff ff ff       	call   f9b <nulterminate>
    1013:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1016:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1019:	8b 40 0c             	mov    0xc(%eax),%eax
    101c:	c6 00 00             	movb   $0x0,(%eax)
    break;
    101f:	eb 71                	jmp    1092 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    1021:	8b 45 08             	mov    0x8(%ebp),%eax
    1024:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    1027:	8b 45 e8             	mov    -0x18(%ebp),%eax
    102a:	8b 40 04             	mov    0x4(%eax),%eax
    102d:	83 ec 0c             	sub    $0xc,%esp
    1030:	50                   	push   %eax
    1031:	e8 65 ff ff ff       	call   f9b <nulterminate>
    1036:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    1039:	8b 45 e8             	mov    -0x18(%ebp),%eax
    103c:	8b 40 08             	mov    0x8(%eax),%eax
    103f:	83 ec 0c             	sub    $0xc,%esp
    1042:	50                   	push   %eax
    1043:	e8 53 ff ff ff       	call   f9b <nulterminate>
    1048:	83 c4 10             	add    $0x10,%esp
    break;
    104b:	eb 45                	jmp    1092 <nulterminate+0xf7>

  case LIST:
    lcmd = (struct listcmd*)cmd;
    104d:	8b 45 08             	mov    0x8(%ebp),%eax
    1050:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    1053:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1056:	8b 40 04             	mov    0x4(%eax),%eax
    1059:	83 ec 0c             	sub    $0xc,%esp
    105c:	50                   	push   %eax
    105d:	e8 39 ff ff ff       	call   f9b <nulterminate>
    1062:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    1065:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1068:	8b 40 08             	mov    0x8(%eax),%eax
    106b:	83 ec 0c             	sub    $0xc,%esp
    106e:	50                   	push   %eax
    106f:	e8 27 ff ff ff       	call   f9b <nulterminate>
    1074:	83 c4 10             	add    $0x10,%esp
    break;
    1077:	eb 19                	jmp    1092 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    1079:	8b 45 08             	mov    0x8(%ebp),%eax
    107c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    107f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1082:	8b 40 04             	mov    0x4(%eax),%eax
    1085:	83 ec 0c             	sub    $0xc,%esp
    1088:	50                   	push   %eax
    1089:	e8 0d ff ff ff       	call   f9b <nulterminate>
    108e:	83 c4 10             	add    $0x10,%esp
    break;
    1091:	90                   	nop
  }
  return cmd;
    1092:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1095:	c9                   	leave  
    1096:	c3                   	ret    

00001097 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1097:	55                   	push   %ebp
    1098:	89 e5                	mov    %esp,%ebp
    109a:	57                   	push   %edi
    109b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    109c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    109f:	8b 55 10             	mov    0x10(%ebp),%edx
    10a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a5:	89 cb                	mov    %ecx,%ebx
    10a7:	89 df                	mov    %ebx,%edi
    10a9:	89 d1                	mov    %edx,%ecx
    10ab:	fc                   	cld    
    10ac:	f3 aa                	rep stos %al,%es:(%edi)
    10ae:	89 ca                	mov    %ecx,%edx
    10b0:	89 fb                	mov    %edi,%ebx
    10b2:	89 5d 08             	mov    %ebx,0x8(%ebp)
    10b5:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10b8:	90                   	nop
    10b9:	5b                   	pop    %ebx
    10ba:	5f                   	pop    %edi
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    

000010bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10bd:	55                   	push   %ebp
    10be:	89 e5                	mov    %esp,%ebp
    10c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    10c3:	8b 45 08             	mov    0x8(%ebp),%eax
    10c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    10c9:	90                   	nop
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	8d 50 01             	lea    0x1(%eax),%edx
    10d0:	89 55 08             	mov    %edx,0x8(%ebp)
    10d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d6:	8d 4a 01             	lea    0x1(%edx),%ecx
    10d9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    10dc:	0f b6 12             	movzbl (%edx),%edx
    10df:	88 10                	mov    %dl,(%eax)
    10e1:	0f b6 00             	movzbl (%eax),%eax
    10e4:	84 c0                	test   %al,%al
    10e6:	75 e2                	jne    10ca <strcpy+0xd>
    ;
  return os;
    10e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10eb:	c9                   	leave  
    10ec:	c3                   	ret    

000010ed <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10ed:	55                   	push   %ebp
    10ee:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    10f0:	eb 08                	jmp    10fa <strcmp+0xd>
    p++, q++;
    10f2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10f6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10fa:	8b 45 08             	mov    0x8(%ebp),%eax
    10fd:	0f b6 00             	movzbl (%eax),%eax
    1100:	84 c0                	test   %al,%al
    1102:	74 10                	je     1114 <strcmp+0x27>
    1104:	8b 45 08             	mov    0x8(%ebp),%eax
    1107:	0f b6 10             	movzbl (%eax),%edx
    110a:	8b 45 0c             	mov    0xc(%ebp),%eax
    110d:	0f b6 00             	movzbl (%eax),%eax
    1110:	38 c2                	cmp    %al,%dl
    1112:	74 de                	je     10f2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1114:	8b 45 08             	mov    0x8(%ebp),%eax
    1117:	0f b6 00             	movzbl (%eax),%eax
    111a:	0f b6 d0             	movzbl %al,%edx
    111d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1120:	0f b6 00             	movzbl (%eax),%eax
    1123:	0f b6 c0             	movzbl %al,%eax
    1126:	29 c2                	sub    %eax,%edx
    1128:	89 d0                	mov    %edx,%eax
}
    112a:	5d                   	pop    %ebp
    112b:	c3                   	ret    

0000112c <strlen>:

uint
strlen(char *s)
{
    112c:	55                   	push   %ebp
    112d:	89 e5                	mov    %esp,%ebp
    112f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1132:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1139:	eb 04                	jmp    113f <strlen+0x13>
    113b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    113f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1142:	8b 45 08             	mov    0x8(%ebp),%eax
    1145:	01 d0                	add    %edx,%eax
    1147:	0f b6 00             	movzbl (%eax),%eax
    114a:	84 c0                	test   %al,%al
    114c:	75 ed                	jne    113b <strlen+0xf>
    ;
  return n;
    114e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1151:	c9                   	leave  
    1152:	c3                   	ret    

00001153 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1153:	55                   	push   %ebp
    1154:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1156:	8b 45 10             	mov    0x10(%ebp),%eax
    1159:	50                   	push   %eax
    115a:	ff 75 0c             	pushl  0xc(%ebp)
    115d:	ff 75 08             	pushl  0x8(%ebp)
    1160:	e8 32 ff ff ff       	call   1097 <stosb>
    1165:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1168:	8b 45 08             	mov    0x8(%ebp),%eax
}
    116b:	c9                   	leave  
    116c:	c3                   	ret    

0000116d <strchr>:

char*
strchr(const char *s, char c)
{
    116d:	55                   	push   %ebp
    116e:	89 e5                	mov    %esp,%ebp
    1170:	83 ec 04             	sub    $0x4,%esp
    1173:	8b 45 0c             	mov    0xc(%ebp),%eax
    1176:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1179:	eb 14                	jmp    118f <strchr+0x22>
    if(*s == c)
    117b:	8b 45 08             	mov    0x8(%ebp),%eax
    117e:	0f b6 00             	movzbl (%eax),%eax
    1181:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1184:	75 05                	jne    118b <strchr+0x1e>
      return (char*)s;
    1186:	8b 45 08             	mov    0x8(%ebp),%eax
    1189:	eb 13                	jmp    119e <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    118b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    118f:	8b 45 08             	mov    0x8(%ebp),%eax
    1192:	0f b6 00             	movzbl (%eax),%eax
    1195:	84 c0                	test   %al,%al
    1197:	75 e2                	jne    117b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1199:	b8 00 00 00 00       	mov    $0x0,%eax
}
    119e:	c9                   	leave  
    119f:	c3                   	ret    

000011a0 <gets>:

char*
gets(char *buf, int max)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11ad:	eb 42                	jmp    11f1 <gets+0x51>
    cc = read(0, &c, 1);
    11af:	83 ec 04             	sub    $0x4,%esp
    11b2:	6a 01                	push   $0x1
    11b4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11b7:	50                   	push   %eax
    11b8:	6a 00                	push   $0x0
    11ba:	e8 47 01 00 00       	call   1306 <read>
    11bf:	83 c4 10             	add    $0x10,%esp
    11c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11c9:	7e 33                	jle    11fe <gets+0x5e>
      break;
    buf[i++] = c;
    11cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ce:	8d 50 01             	lea    0x1(%eax),%edx
    11d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11d4:	89 c2                	mov    %eax,%edx
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	01 c2                	add    %eax,%edx
    11db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11df:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11e5:	3c 0a                	cmp    $0xa,%al
    11e7:	74 16                	je     11ff <gets+0x5f>
    11e9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ed:	3c 0d                	cmp    $0xd,%al
    11ef:	74 0e                	je     11ff <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11f4:	83 c0 01             	add    $0x1,%eax
    11f7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11fa:	7c b3                	jl     11af <gets+0xf>
    11fc:	eb 01                	jmp    11ff <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    11fe:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1202:	8b 45 08             	mov    0x8(%ebp),%eax
    1205:	01 d0                	add    %edx,%eax
    1207:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    120a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    120d:	c9                   	leave  
    120e:	c3                   	ret    

0000120f <stat>:

int
stat(char *n, struct stat *st)
{
    120f:	55                   	push   %ebp
    1210:	89 e5                	mov    %esp,%ebp
    1212:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1215:	83 ec 08             	sub    $0x8,%esp
    1218:	6a 00                	push   $0x0
    121a:	ff 75 08             	pushl  0x8(%ebp)
    121d:	e8 0c 01 00 00       	call   132e <open>
    1222:	83 c4 10             	add    $0x10,%esp
    1225:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1228:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    122c:	79 07                	jns    1235 <stat+0x26>
    return -1;
    122e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1233:	eb 25                	jmp    125a <stat+0x4b>
  r = fstat(fd, st);
    1235:	83 ec 08             	sub    $0x8,%esp
    1238:	ff 75 0c             	pushl  0xc(%ebp)
    123b:	ff 75 f4             	pushl  -0xc(%ebp)
    123e:	e8 03 01 00 00       	call   1346 <fstat>
    1243:	83 c4 10             	add    $0x10,%esp
    1246:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1249:	83 ec 0c             	sub    $0xc,%esp
    124c:	ff 75 f4             	pushl  -0xc(%ebp)
    124f:	e8 c2 00 00 00       	call   1316 <close>
    1254:	83 c4 10             	add    $0x10,%esp
  return r;
    1257:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    125a:	c9                   	leave  
    125b:	c3                   	ret    

0000125c <atoi>:

int
atoi(const char *s)
{
    125c:	55                   	push   %ebp
    125d:	89 e5                	mov    %esp,%ebp
    125f:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1262:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1269:	eb 25                	jmp    1290 <atoi+0x34>
    n = n*10 + *s++ - '0';
    126b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    126e:	89 d0                	mov    %edx,%eax
    1270:	c1 e0 02             	shl    $0x2,%eax
    1273:	01 d0                	add    %edx,%eax
    1275:	01 c0                	add    %eax,%eax
    1277:	89 c1                	mov    %eax,%ecx
    1279:	8b 45 08             	mov    0x8(%ebp),%eax
    127c:	8d 50 01             	lea    0x1(%eax),%edx
    127f:	89 55 08             	mov    %edx,0x8(%ebp)
    1282:	0f b6 00             	movzbl (%eax),%eax
    1285:	0f be c0             	movsbl %al,%eax
    1288:	01 c8                	add    %ecx,%eax
    128a:	83 e8 30             	sub    $0x30,%eax
    128d:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	0f b6 00             	movzbl (%eax),%eax
    1296:	3c 2f                	cmp    $0x2f,%al
    1298:	7e 0a                	jle    12a4 <atoi+0x48>
    129a:	8b 45 08             	mov    0x8(%ebp),%eax
    129d:	0f b6 00             	movzbl (%eax),%eax
    12a0:	3c 39                	cmp    $0x39,%al
    12a2:	7e c7                	jle    126b <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    12a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12a7:	c9                   	leave  
    12a8:	c3                   	ret    

000012a9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12a9:	55                   	push   %ebp
    12aa:	89 e5                	mov    %esp,%ebp
    12ac:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    12af:	8b 45 08             	mov    0x8(%ebp),%eax
    12b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    12b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    12bb:	eb 17                	jmp    12d4 <memmove+0x2b>
    *dst++ = *src++;
    12bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c0:	8d 50 01             	lea    0x1(%eax),%edx
    12c3:	89 55 fc             	mov    %edx,-0x4(%ebp)
    12c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12c9:	8d 4a 01             	lea    0x1(%edx),%ecx
    12cc:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    12cf:	0f b6 12             	movzbl (%edx),%edx
    12d2:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12d4:	8b 45 10             	mov    0x10(%ebp),%eax
    12d7:	8d 50 ff             	lea    -0x1(%eax),%edx
    12da:	89 55 10             	mov    %edx,0x10(%ebp)
    12dd:	85 c0                	test   %eax,%eax
    12df:	7f dc                	jg     12bd <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    12e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12e4:	c9                   	leave  
    12e5:	c3                   	ret    

000012e6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12e6:	b8 01 00 00 00       	mov    $0x1,%eax
    12eb:	cd 40                	int    $0x40
    12ed:	c3                   	ret    

000012ee <exit>:
SYSCALL(exit)
    12ee:	b8 02 00 00 00       	mov    $0x2,%eax
    12f3:	cd 40                	int    $0x40
    12f5:	c3                   	ret    

000012f6 <wait>:
SYSCALL(wait)
    12f6:	b8 03 00 00 00       	mov    $0x3,%eax
    12fb:	cd 40                	int    $0x40
    12fd:	c3                   	ret    

000012fe <pipe>:
SYSCALL(pipe)
    12fe:	b8 04 00 00 00       	mov    $0x4,%eax
    1303:	cd 40                	int    $0x40
    1305:	c3                   	ret    

00001306 <read>:
SYSCALL(read)
    1306:	b8 05 00 00 00       	mov    $0x5,%eax
    130b:	cd 40                	int    $0x40
    130d:	c3                   	ret    

0000130e <write>:
SYSCALL(write)
    130e:	b8 10 00 00 00       	mov    $0x10,%eax
    1313:	cd 40                	int    $0x40
    1315:	c3                   	ret    

00001316 <close>:
SYSCALL(close)
    1316:	b8 15 00 00 00       	mov    $0x15,%eax
    131b:	cd 40                	int    $0x40
    131d:	c3                   	ret    

0000131e <kill>:
SYSCALL(kill)
    131e:	b8 06 00 00 00       	mov    $0x6,%eax
    1323:	cd 40                	int    $0x40
    1325:	c3                   	ret    

00001326 <exec>:
SYSCALL(exec)
    1326:	b8 07 00 00 00       	mov    $0x7,%eax
    132b:	cd 40                	int    $0x40
    132d:	c3                   	ret    

0000132e <open>:
SYSCALL(open)
    132e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1333:	cd 40                	int    $0x40
    1335:	c3                   	ret    

00001336 <mknod>:
SYSCALL(mknod)
    1336:	b8 11 00 00 00       	mov    $0x11,%eax
    133b:	cd 40                	int    $0x40
    133d:	c3                   	ret    

0000133e <unlink>:
SYSCALL(unlink)
    133e:	b8 12 00 00 00       	mov    $0x12,%eax
    1343:	cd 40                	int    $0x40
    1345:	c3                   	ret    

00001346 <fstat>:
SYSCALL(fstat)
    1346:	b8 08 00 00 00       	mov    $0x8,%eax
    134b:	cd 40                	int    $0x40
    134d:	c3                   	ret    

0000134e <link>:
SYSCALL(link)
    134e:	b8 13 00 00 00       	mov    $0x13,%eax
    1353:	cd 40                	int    $0x40
    1355:	c3                   	ret    

00001356 <mkdir>:
SYSCALL(mkdir)
    1356:	b8 14 00 00 00       	mov    $0x14,%eax
    135b:	cd 40                	int    $0x40
    135d:	c3                   	ret    

0000135e <chdir>:
SYSCALL(chdir)
    135e:	b8 09 00 00 00       	mov    $0x9,%eax
    1363:	cd 40                	int    $0x40
    1365:	c3                   	ret    

00001366 <dup>:
SYSCALL(dup)
    1366:	b8 0a 00 00 00       	mov    $0xa,%eax
    136b:	cd 40                	int    $0x40
    136d:	c3                   	ret    

0000136e <getpid>:
SYSCALL(getpid)
    136e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1373:	cd 40                	int    $0x40
    1375:	c3                   	ret    

00001376 <sbrk>:
SYSCALL(sbrk)
    1376:	b8 0c 00 00 00       	mov    $0xc,%eax
    137b:	cd 40                	int    $0x40
    137d:	c3                   	ret    

0000137e <sleep>:
SYSCALL(sleep)
    137e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1383:	cd 40                	int    $0x40
    1385:	c3                   	ret    

00001386 <uptime>:
SYSCALL(uptime)
    1386:	b8 0e 00 00 00       	mov    $0xe,%eax
    138b:	cd 40                	int    $0x40
    138d:	c3                   	ret    

0000138e <ps>:
SYSCALL(ps)
    138e:	b8 16 00 00 00       	mov    $0x16,%eax
    1393:	cd 40                	int    $0x40
    1395:	c3                   	ret    

00001396 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1396:	55                   	push   %ebp
    1397:	89 e5                	mov    %esp,%ebp
    1399:	83 ec 18             	sub    $0x18,%esp
    139c:	8b 45 0c             	mov    0xc(%ebp),%eax
    139f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    13a2:	83 ec 04             	sub    $0x4,%esp
    13a5:	6a 01                	push   $0x1
    13a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
    13aa:	50                   	push   %eax
    13ab:	ff 75 08             	pushl  0x8(%ebp)
    13ae:	e8 5b ff ff ff       	call   130e <write>
    13b3:	83 c4 10             	add    $0x10,%esp
}
    13b6:	90                   	nop
    13b7:	c9                   	leave  
    13b8:	c3                   	ret    

000013b9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    13b9:	55                   	push   %ebp
    13ba:	89 e5                	mov    %esp,%ebp
    13bc:	53                   	push   %ebx
    13bd:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    13c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    13c7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13cb:	74 17                	je     13e4 <printint+0x2b>
    13cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13d1:	79 11                	jns    13e4 <printint+0x2b>
    neg = 1;
    13d3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13da:	8b 45 0c             	mov    0xc(%ebp),%eax
    13dd:	f7 d8                	neg    %eax
    13df:	89 45 ec             	mov    %eax,-0x14(%ebp)
    13e2:	eb 06                	jmp    13ea <printint+0x31>
  } else {
    x = xx;
    13e4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    13ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    13f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13f4:	8d 41 01             	lea    0x1(%ecx),%eax
    13f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1400:	ba 00 00 00 00       	mov    $0x0,%edx
    1405:	f7 f3                	div    %ebx
    1407:	89 d0                	mov    %edx,%eax
    1409:	0f b6 80 d8 1e 00 00 	movzbl 0x1ed8(%eax),%eax
    1410:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1414:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1417:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141a:	ba 00 00 00 00       	mov    $0x0,%edx
    141f:	f7 f3                	div    %ebx
    1421:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1424:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1428:	75 c7                	jne    13f1 <printint+0x38>
  if(neg)
    142a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    142e:	74 2d                	je     145d <printint+0xa4>
    buf[i++] = '-';
    1430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1433:	8d 50 01             	lea    0x1(%eax),%edx
    1436:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1439:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    143e:	eb 1d                	jmp    145d <printint+0xa4>
    putc(fd, buf[i]);
    1440:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1443:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1446:	01 d0                	add    %edx,%eax
    1448:	0f b6 00             	movzbl (%eax),%eax
    144b:	0f be c0             	movsbl %al,%eax
    144e:	83 ec 08             	sub    $0x8,%esp
    1451:	50                   	push   %eax
    1452:	ff 75 08             	pushl  0x8(%ebp)
    1455:	e8 3c ff ff ff       	call   1396 <putc>
    145a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    145d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1461:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1465:	79 d9                	jns    1440 <printint+0x87>
    putc(fd, buf[i]);
}
    1467:	90                   	nop
    1468:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    146b:	c9                   	leave  
    146c:	c3                   	ret    

0000146d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    146d:	55                   	push   %ebp
    146e:	89 e5                	mov    %esp,%ebp
    1470:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1473:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    147a:	8d 45 0c             	lea    0xc(%ebp),%eax
    147d:	83 c0 04             	add    $0x4,%eax
    1480:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1483:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    148a:	e9 59 01 00 00       	jmp    15e8 <printf+0x17b>
    c = fmt[i] & 0xff;
    148f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1492:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1495:	01 d0                	add    %edx,%eax
    1497:	0f b6 00             	movzbl (%eax),%eax
    149a:	0f be c0             	movsbl %al,%eax
    149d:	25 ff 00 00 00       	and    $0xff,%eax
    14a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    14a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14a9:	75 2c                	jne    14d7 <printf+0x6a>
      if(c == '%'){
    14ab:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    14af:	75 0c                	jne    14bd <printf+0x50>
        state = '%';
    14b1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    14b8:	e9 27 01 00 00       	jmp    15e4 <printf+0x177>
      } else {
        putc(fd, c);
    14bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14c0:	0f be c0             	movsbl %al,%eax
    14c3:	83 ec 08             	sub    $0x8,%esp
    14c6:	50                   	push   %eax
    14c7:	ff 75 08             	pushl  0x8(%ebp)
    14ca:	e8 c7 fe ff ff       	call   1396 <putc>
    14cf:	83 c4 10             	add    $0x10,%esp
    14d2:	e9 0d 01 00 00       	jmp    15e4 <printf+0x177>
      }
    } else if(state == '%'){
    14d7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    14db:	0f 85 03 01 00 00    	jne    15e4 <printf+0x177>
      if(c == 'd'){
    14e1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    14e5:	75 1e                	jne    1505 <printf+0x98>
        printint(fd, *ap, 10, 1);
    14e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ea:	8b 00                	mov    (%eax),%eax
    14ec:	6a 01                	push   $0x1
    14ee:	6a 0a                	push   $0xa
    14f0:	50                   	push   %eax
    14f1:	ff 75 08             	pushl  0x8(%ebp)
    14f4:	e8 c0 fe ff ff       	call   13b9 <printint>
    14f9:	83 c4 10             	add    $0x10,%esp
        ap++;
    14fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1500:	e9 d8 00 00 00       	jmp    15dd <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1505:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1509:	74 06                	je     1511 <printf+0xa4>
    150b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    150f:	75 1e                	jne    152f <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1511:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1514:	8b 00                	mov    (%eax),%eax
    1516:	6a 00                	push   $0x0
    1518:	6a 10                	push   $0x10
    151a:	50                   	push   %eax
    151b:	ff 75 08             	pushl  0x8(%ebp)
    151e:	e8 96 fe ff ff       	call   13b9 <printint>
    1523:	83 c4 10             	add    $0x10,%esp
        ap++;
    1526:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    152a:	e9 ae 00 00 00       	jmp    15dd <printf+0x170>
      } else if(c == 's'){
    152f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1533:	75 43                	jne    1578 <printf+0x10b>
        s = (char*)*ap;
    1535:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1538:	8b 00                	mov    (%eax),%eax
    153a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    153d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1541:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1545:	75 25                	jne    156c <printf+0xff>
          s = "(null)";
    1547:	c7 45 f4 40 19 00 00 	movl   $0x1940,-0xc(%ebp)
        while(*s != 0){
    154e:	eb 1c                	jmp    156c <printf+0xff>
          putc(fd, *s);
    1550:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1553:	0f b6 00             	movzbl (%eax),%eax
    1556:	0f be c0             	movsbl %al,%eax
    1559:	83 ec 08             	sub    $0x8,%esp
    155c:	50                   	push   %eax
    155d:	ff 75 08             	pushl  0x8(%ebp)
    1560:	e8 31 fe ff ff       	call   1396 <putc>
    1565:	83 c4 10             	add    $0x10,%esp
          s++;
    1568:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    156c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156f:	0f b6 00             	movzbl (%eax),%eax
    1572:	84 c0                	test   %al,%al
    1574:	75 da                	jne    1550 <printf+0xe3>
    1576:	eb 65                	jmp    15dd <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1578:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    157c:	75 1d                	jne    159b <printf+0x12e>
        putc(fd, *ap);
    157e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1581:	8b 00                	mov    (%eax),%eax
    1583:	0f be c0             	movsbl %al,%eax
    1586:	83 ec 08             	sub    $0x8,%esp
    1589:	50                   	push   %eax
    158a:	ff 75 08             	pushl  0x8(%ebp)
    158d:	e8 04 fe ff ff       	call   1396 <putc>
    1592:	83 c4 10             	add    $0x10,%esp
        ap++;
    1595:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1599:	eb 42                	jmp    15dd <printf+0x170>
      } else if(c == '%'){
    159b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    159f:	75 17                	jne    15b8 <printf+0x14b>
        putc(fd, c);
    15a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15a4:	0f be c0             	movsbl %al,%eax
    15a7:	83 ec 08             	sub    $0x8,%esp
    15aa:	50                   	push   %eax
    15ab:	ff 75 08             	pushl  0x8(%ebp)
    15ae:	e8 e3 fd ff ff       	call   1396 <putc>
    15b3:	83 c4 10             	add    $0x10,%esp
    15b6:	eb 25                	jmp    15dd <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    15b8:	83 ec 08             	sub    $0x8,%esp
    15bb:	6a 25                	push   $0x25
    15bd:	ff 75 08             	pushl  0x8(%ebp)
    15c0:	e8 d1 fd ff ff       	call   1396 <putc>
    15c5:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    15c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15cb:	0f be c0             	movsbl %al,%eax
    15ce:	83 ec 08             	sub    $0x8,%esp
    15d1:	50                   	push   %eax
    15d2:	ff 75 08             	pushl  0x8(%ebp)
    15d5:	e8 bc fd ff ff       	call   1396 <putc>
    15da:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    15dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    15eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ee:	01 d0                	add    %edx,%eax
    15f0:	0f b6 00             	movzbl (%eax),%eax
    15f3:	84 c0                	test   %al,%al
    15f5:	0f 85 94 fe ff ff    	jne    148f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15fb:	90                   	nop
    15fc:	c9                   	leave  
    15fd:	c3                   	ret    

000015fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15fe:	55                   	push   %ebp
    15ff:	89 e5                	mov    %esp,%ebp
    1601:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1604:	8b 45 08             	mov    0x8(%ebp),%eax
    1607:	83 e8 08             	sub    $0x8,%eax
    160a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    160d:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    1612:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1615:	eb 24                	jmp    163b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1617:	8b 45 fc             	mov    -0x4(%ebp),%eax
    161a:	8b 00                	mov    (%eax),%eax
    161c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    161f:	77 12                	ja     1633 <free+0x35>
    1621:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1624:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1627:	77 24                	ja     164d <free+0x4f>
    1629:	8b 45 fc             	mov    -0x4(%ebp),%eax
    162c:	8b 00                	mov    (%eax),%eax
    162e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1631:	77 1a                	ja     164d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1633:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1636:	8b 00                	mov    (%eax),%eax
    1638:	89 45 fc             	mov    %eax,-0x4(%ebp)
    163b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1641:	76 d4                	jbe    1617 <free+0x19>
    1643:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1646:	8b 00                	mov    (%eax),%eax
    1648:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    164b:	76 ca                	jbe    1617 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    164d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1650:	8b 40 04             	mov    0x4(%eax),%eax
    1653:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    165a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165d:	01 c2                	add    %eax,%edx
    165f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1662:	8b 00                	mov    (%eax),%eax
    1664:	39 c2                	cmp    %eax,%edx
    1666:	75 24                	jne    168c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1668:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166b:	8b 50 04             	mov    0x4(%eax),%edx
    166e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1671:	8b 00                	mov    (%eax),%eax
    1673:	8b 40 04             	mov    0x4(%eax),%eax
    1676:	01 c2                	add    %eax,%edx
    1678:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    167e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1681:	8b 00                	mov    (%eax),%eax
    1683:	8b 10                	mov    (%eax),%edx
    1685:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1688:	89 10                	mov    %edx,(%eax)
    168a:	eb 0a                	jmp    1696 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    168c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    168f:	8b 10                	mov    (%eax),%edx
    1691:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1694:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1696:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1699:	8b 40 04             	mov    0x4(%eax),%eax
    169c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a6:	01 d0                	add    %edx,%eax
    16a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ab:	75 20                	jne    16cd <free+0xcf>
    p->s.size += bp->s.size;
    16ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b0:	8b 50 04             	mov    0x4(%eax),%edx
    16b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b6:	8b 40 04             	mov    0x4(%eax),%eax
    16b9:	01 c2                	add    %eax,%edx
    16bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16be:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c4:	8b 10                	mov    (%eax),%edx
    16c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c9:	89 10                	mov    %edx,(%eax)
    16cb:	eb 08                	jmp    16d5 <free+0xd7>
  } else
    p->s.ptr = bp;
    16cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16d3:	89 10                	mov    %edx,(%eax)
  freep = p;
    16d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d8:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
}
    16dd:	90                   	nop
    16de:	c9                   	leave  
    16df:	c3                   	ret    

000016e0 <morecore>:

static Header*
morecore(uint nu)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16e6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16ed:	77 07                	ja     16f6 <morecore+0x16>
    nu = 4096;
    16ef:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	c1 e0 03             	shl    $0x3,%eax
    16fc:	83 ec 0c             	sub    $0xc,%esp
    16ff:	50                   	push   %eax
    1700:	e8 71 fc ff ff       	call   1376 <sbrk>
    1705:	83 c4 10             	add    $0x10,%esp
    1708:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    170b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    170f:	75 07                	jne    1718 <morecore+0x38>
    return 0;
    1711:	b8 00 00 00 00       	mov    $0x0,%eax
    1716:	eb 26                	jmp    173e <morecore+0x5e>
  hp = (Header*)p;
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    171e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1721:	8b 55 08             	mov    0x8(%ebp),%edx
    1724:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1727:	8b 45 f0             	mov    -0x10(%ebp),%eax
    172a:	83 c0 08             	add    $0x8,%eax
    172d:	83 ec 0c             	sub    $0xc,%esp
    1730:	50                   	push   %eax
    1731:	e8 c8 fe ff ff       	call   15fe <free>
    1736:	83 c4 10             	add    $0x10,%esp
  return freep;
    1739:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
}
    173e:	c9                   	leave  
    173f:	c3                   	ret    

00001740 <malloc>:

void*
malloc(uint nbytes)
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1746:	8b 45 08             	mov    0x8(%ebp),%eax
    1749:	83 c0 07             	add    $0x7,%eax
    174c:	c1 e8 03             	shr    $0x3,%eax
    174f:	83 c0 01             	add    $0x1,%eax
    1752:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1755:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    175a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    175d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1761:	75 23                	jne    1786 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1763:	c7 45 f0 64 1f 00 00 	movl   $0x1f64,-0x10(%ebp)
    176a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    176d:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
    1772:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    1777:	a3 64 1f 00 00       	mov    %eax,0x1f64
    base.s.size = 0;
    177c:	c7 05 68 1f 00 00 00 	movl   $0x0,0x1f68
    1783:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1786:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1789:	8b 00                	mov    (%eax),%eax
    178b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1791:	8b 40 04             	mov    0x4(%eax),%eax
    1794:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1797:	72 4d                	jb     17e6 <malloc+0xa6>
      if(p->s.size == nunits)
    1799:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179c:	8b 40 04             	mov    0x4(%eax),%eax
    179f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    17a2:	75 0c                	jne    17b0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    17a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a7:	8b 10                	mov    (%eax),%edx
    17a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ac:	89 10                	mov    %edx,(%eax)
    17ae:	eb 26                	jmp    17d6 <malloc+0x96>
      else {
        p->s.size -= nunits;
    17b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b3:	8b 40 04             	mov    0x4(%eax),%eax
    17b6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    17b9:	89 c2                	mov    %eax,%edx
    17bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c4:	8b 40 04             	mov    0x4(%eax),%eax
    17c7:	c1 e0 03             	shl    $0x3,%eax
    17ca:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17d3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17d9:	a3 6c 1f 00 00       	mov    %eax,0x1f6c
      return (void*)(p + 1);
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	83 c0 08             	add    $0x8,%eax
    17e4:	eb 3b                	jmp    1821 <malloc+0xe1>
    }
    if(p == freep)
    17e6:	a1 6c 1f 00 00       	mov    0x1f6c,%eax
    17eb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    17ee:	75 1e                	jne    180e <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    17f0:	83 ec 0c             	sub    $0xc,%esp
    17f3:	ff 75 ec             	pushl  -0x14(%ebp)
    17f6:	e8 e5 fe ff ff       	call   16e0 <morecore>
    17fb:	83 c4 10             	add    $0x10,%esp
    17fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1801:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1805:	75 07                	jne    180e <malloc+0xce>
        return 0;
    1807:	b8 00 00 00 00       	mov    $0x0,%eax
    180c:	eb 13                	jmp    1821 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1811:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1814:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1817:	8b 00                	mov    (%eax),%eax
    1819:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    181c:	e9 6d ff ff ff       	jmp    178e <malloc+0x4e>
}
    1821:	c9                   	leave  
    1822:	c3                   	ret    
