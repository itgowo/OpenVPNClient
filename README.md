# OpenVPNClient
Openvpn client for Synology NAS

# 1:pull image
```
docker pull itgowo/openvpn-client
```
# 2.Create client.ovpn
* mkdir /var/services/openvpn
* download ovpn file
我是用的[OpenVPN](https://openvpn.net/)官方软件，所以通过server ui轻松拿到ovpn文件，然后下载到/var/services/openvpn目录下
# 3.Run Container
```
docker run --name vpn  --net=host -v /dev/net/tun:/dev/net/tun -v /var/services/openvpn/client.ovpn:/etc/openvpn/client.ovpn --cap-add NET_ADMIN -d  itgowo/openvpn-client:latest
```
|参数名|参数值|说明|
|---|---|---|
|***--name***|vpn|容器名，可以随意定义|
|***--net***|host|网络模式，必须是host，使用主机网络，方便代理主机|
|***--cap-add***|NET_ADMIN|网络控制授权|
|***-v***|/dev/net/tun:/dev/net/tun|代理需要使用tun|
|***-v***|-v /var/services/openvpn/client.ovpn:/etc/openvpn/client.ovpn|挂载配置文件，必须是绝对路径，我在Nas上的这个位置存的，可以自定义|

# 说明
群辉NAS不同于其他linux发行版，我们不能随意安装软件，不过支持Docker，我们需要的软件可以借助Docker实现；群辉NAS不支持VPN Client，我们也只能通过Docker实现；
# Dockerfile
```
FROM    alpine:3.10
MAINTAINER      itgowo "lujianchao@itgowo.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone && echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories && \
    apk add openvpn
COPY start.sh /etc/openvpn/start.sh
CMD /etc/openvpn/start.sh
```
* 使用alpine:3.10体积非常小，之前用过CentOS做镜像，大的吓人；
* /etc/localtime 默认时区是中国上海，注意啊，国外请改一下；
* 默认添加了aliyun仓库；

# start.sh
```
echo "Ready to start OpenVPN"
openvpn --version
openvpn --config /etc/openvpn/client.ovpn
echo "OpenVPN is closed"
```
* 方便自定义脚本
echo "Ready to start OpenVPN"
