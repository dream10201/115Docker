# 115浏览器Docker版
推广链接: [https://115.com/u/VDSCVx/1](https://115.com/u/VDSCVx/1)

用于无头环境Linux上传和下载文件。
![previews](https://github.com/dream10201/115Docker/blob/master/image.png)
## 拉取镜像
```bash
docker pull docker.io/xiuxiu10201/115:latest
// or
docker pull ghcr.io/dream10201/115docker:latest
```
## 运行命令
```shell
docker run --name=115 \
--user 0:0
--env PASSWORD=123456 \
--env DISPLAY_WIDTH=1920 \
--env DISPLAY_HEIGHT=1080 \
--rm --network=host -d \
--env TZ=Asia/Shanghai \
docker.io/xiuxiu10201/115:latest
```

## Web
[http://localhost:1150/vnc.html](http://localhost:1150/vnc.html)

## 环境变量

| 名称 | 描述 | 必须|
|:---------:|:---------:|:---------:|
|PASSWORD|VNC密码|Y|
|CID|Cookie|N|
|SEID|Cookie|N|
|UID|Cookie|N|
|KID|Cookie|N|
|DISPLAY_WIDTH|窗口宽度|N|
|DISPLAY_HEIGHT|窗口高度|N|

## 挂载目录

| 路径 | 描述 | 必须|
|:---------:|:---------:|:---------:|
|/etc/115|115浏览器数据目录|N|
|/opt/Downloads|下载目录|N|

## 端口占用
| 端口 | 描述 | 必须|
|:---------:|:---------:|:---------:|
|1150|WEB端口|Y|
|1152|VNC端口|N|

