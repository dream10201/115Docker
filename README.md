# 115Docker - Web 环境中的 115 浏览器客户端
一个基于 LinuxServer WebTop 的 Docker 解决方案，在 Web 环境中运行 115 浏览器客户端，提供便捷的远程访问体验。

推广链接: [https://115.com/u/VDSCVx/1](https://115.com/u/VDSCVx/1)

## 🌟 功能特性

- **Web 访问**: 通过浏览器直接访问 115 客户端，无需安装本地软件
- **增强功能**: 集成 115Cookie 扩展，增强浏览器功能
- **优化配置**: 预配置的浏览器参数，优化性能和稳定性

## 🚀 快速开始
### Docker CLI
```bash
docker run \
--name 115docker \
--security-opt seccomp:unconfined \
-e PUID=0 \
-e PGID=0 \
--user 0:0 \
--network=host -d \
-e PASSWORD=123456 \
-e DISPLAY_WIDTH=1920 \
-e DISPLAY_HEIGHT=1080 \
-e COOKIE_CID="xxxxxxxxx" \
-e COOKIE_SEID="xxxxxxxx" \
-e COOKIE_UID="xxxxxxxxx" \
-e COOKIE_KID="xxxxxxxxx" \
-e TZ=Asia/Shanghai \
-e LC_ALL=zh_CN.UTF-8 \
-v /path/to/download:/opt/Downloads \
--shm-size 1gb \
--restart unless-stopped \
ghcr.io/dream10201/115docker:latest
```
### 访问服务
[http://localhost:1150/vnc.html](http://localhost:1150/vnc.html)

## 📋 详细配置

### 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| `PASSWORD` | "" | VNC密码,必须设置 |
| `COOKIE_CID` | "" | Cookie | 用于自动登录 |
| `COOKIE_SEID` | "" | Cookie | 用于自动登录 |
| `COOKIE_UID` | "" | Cookie | 用于自动登录 |
| `COOKIE_KID` | "" | Cookie | 用于自动登录 |
| `DISPLAY_WIDTH` | 1366 | 窗口宽度 |
| `DISPLAY_HEIGHT` | 768 | 窗口高度 |

### 数据卷挂载

| 容器路径 | 说明 |
|----------|------|
| `/etc/115` | 115 浏览器用户数据目录，存储浏览记录、登录信息等 |
| `/opt/Downloads` | 下载目录 |

## 📄 许可证

本项目采用 [GPL-3.0 许可证](LICENSE)。

## ⚖️ 免责声明

- 本项目仅供学习和研究使用
- 请遵守相关法律法规和服务条款
- 使用本项目产生的任何问题由用户自行承担
- 项目作者不对使用本项目造成的任何损失负责

---

**注意**: 本项目与 115 官方无关，仅为第三方 Docker 化解决方案。使用前请确保遵守 115 服务条款。

