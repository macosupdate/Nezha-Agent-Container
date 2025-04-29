# Nezha Agent Docker 镜像构建说明
## 项目简介
这是一个用于构建 Nezha Agent Docker 镜像的项目。该镜像基于 Alpine Linux，支持多架构（amd64/arm64）构建。

## 功能特点
- 基于 Alpine 3.19 构建，镜像体积小
- 支持 amd64 和 arm64 架构
- 自动从官方仓库获取最新版本
- 支持环境变量配置
- 支持主机系统信息采集

## 环境变量
- NEZHA_SERVER : 面板服务器地址
- NEZHA_PORT : 面板服务器端口
- NEZHA_KEY : 客户端密钥
- NEZHA_TLS : 是否启用 TLS（可选值：--tls）

## 使用方法
### Docker 运行
```
docker run -d \
  --name nezha-agent \
  --restart unless-stopped \
  --privileged \
  --pid host \
  -v /:/host:ro \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /etc:/host/etc:ro \
  -e NEZHA_SERVER=demo.nezha.org \
  -e NEZHA_PORT=5555 \
  -e NEZHA_KEY=your_key \
  -e NEZHA_TLS=--tls \
  fscarmen/nezha-agent:latest
```
### Docker Compose
```
services:
  nezha-agent:
    image: fscarmen/nezha-agent:latest
    container_name: nezha-agent
    privileged: true
    pid: host
    volumes:
      - /:/host:ro
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /etc:/host/etc:ro
    environment:
      - NEZHA_SERVER=demo.nezha.org
      - NEZHA_PORT=5555
      - NEZHA_KEY=your_key
      - NEZHA_TLS=--tls
    restart: unless-stopped
```

## 构建说明
项目使用 GitHub Actions 自动构建，支持以下特性：

- 每日自动检查更新
- 多架构支持（amd64/arm64）
- 自动推送到 Docker Hub
- 版本标签自动更新

## 注意事项
1. 需要挂载主机目录以获取准确的系统信息
2. 建议使用 host 网络模式
3. 所有挂载目录均为只读模式，确保安全性
4. 环境变量必须正确配置，否则无法连接面板

## 贡献指南
欢迎提交 Issue 和 Pull Request