FROM    alpine:3.10
MAINTAINER      itgowo "lujianchao@itgowo.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone && echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories && \
    apk add openvpn
COPY start.sh /etc/openvpn/start.sh
CMD /etc/openvpn/start.sh
