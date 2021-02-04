# 基于 docker 学习nginx

其实也就是为了学习方便，也不想污染太多环境，以后很多工具和功能都要测试，就依赖docker了～

[Nginx 文档地址](https://www.nginx.cn/doc/)

## 核心模块

### 1. user
**语法：**`user USER [group]`; 
**默认：**`user nobody nobody`;

> 这里有个点，Nginx 主进程（master process）会以 root 权限运行，之后主进程会读取 /etc/nginx/nginx.conf 文件中的 user 模块的配置，nginx 会使用这个指定的用户启动工作进程（worker process）。

**查看用户指令**： `cat /etc/passwd`

```sh
# 这里设置成 root 用户运行
user  root;

# 其余的配置....
```
![user](https://cdn.nlark.com/yuque/0/2021/png/1252774/1612408050030-1c52238f-b295-4c7f-a497-1008a4e3b89e.png)

### 2. worker_processes

**语法**：`worker_processes NUMBER;`
**默认**：`worker_processes 1;`

- 配置工作进程数目, 默认 1。
- 一般设置为 CPU 核数，充分利用多核。
- 查看工作进程脚本：`ps -ef | grep nginx`

```sh
user root;

# 这里设置成 4个工作进程
worker_processes  4;

# 其余的配置....
```
![worker_processes](https://cdn.nlark.com/yuque/0/2021/png/1252774/1612409019433-9f33a6b7-fd7a-4846-b7c5-a17e3694f1fa.png)

### 3. error_log

**语法:** `error_log FILE LEVEL`
**默认:** 都是必填。

- `FILE`: 文件路径。可以指定任意存放日志的目录
- `LEVEL`: 错误日志级别。常见的错误日志级别有[debug|info|notice|warn|error|crit|alert|emerg]，级别越高记录的信息越少。生产场景一般选是 warn | error | crit 其一。

> 注意：不要配置info等级较低的级别，会带来大量的磁盘I/O消耗。

**语法位置**
可以配置在 `main`, `http`, `server`, `location` 中。

**查看日志**
`docker log -f {镜像名称}`

> nginx 官方镜像的日志是输出到 STDOUT(标准输出)、STDERR(标准错误输出) 上的。因此，进入容器中去查看 access.log 和 error.log 会挂住，并查看不到内容。

```sh
# 错误日志路径，级别。
error_log /var/log/nginx/error.log warn;
```

### 4. pid

指定 nginx 进程运行文件存放地址

**语法:** `pid /nginx/pid/nginx.pid`;



- [Nginx错误日志（error_log）配置及信息详解](https://blog.csdn.net/czlun/article/details/73251714)
- [Docker容器日志管理最佳实践](https://www.cnblogs.com/operationhome/p/10907591.html)
