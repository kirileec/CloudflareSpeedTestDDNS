FROM alpine:latest
MAINTAINER slk1133 <slk1133@qq.com>
RUN apk update
RUN apk add --no-cache bash jq wget curl tar sed gawk coreutils dcron
RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*
WORKDIR /app
COPY ./config.conf .
COPY ./start.sh .
COPY ./cf_ddns .
RUN chmod +x /app/start.sh && chmod +x /app/cf_ddns/*.sh
CMD ["/bin/sh", "-c", "/app/start.sh && tail -f /dev/null"]
