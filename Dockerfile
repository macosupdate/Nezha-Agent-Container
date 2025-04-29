# 第一阶段：构建
FROM alpine:3.19 AS builder

# 设置构建参数
ARG TARGETOS
ARG TARGETARCH

# 安装构建工具
RUN apk add --no-cache wget unzip

# 下载并解压 nezha-agent
RUN wget -O nezha-agent.zip https://github.com/nezhahq/agent/releases/download/v0.20.5/nezha-agent_linux_${TARGETARCH}.zip && \
    unzip nezha-agent.zip -d /tmp && \
    chmod +x /tmp/nezha-agent

# 第二阶段：运行
FROM alpine:3.19.1

# 从构建阶段复制二进制文件
COPY --from=builder /tmp/nezha-agent /usr/local/bin/nezha-agent

# 设置入口点
ENTRYPOINT ["nezha-agent"]