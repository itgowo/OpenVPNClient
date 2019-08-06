# OpenVPNClient
Openvpn client for Synology NAS

# first:pull image
```
docker pull itgowo/openvpn-client
```
# run Container
```
docker run --name vpn  --net=host -v /dev/net/tun:/dev/net/tun -v /var/services/openvpn/client.ovpn:/etc/openvpn/client.ovpn --cap-add NET_ADMIN -d  itgowo/openvpn-client:latest
```
* ***--name***Container name
* ***--net***Net 网络模式为HOST
* ***--cap-add NET_ADMIN***
|参数名|参数值|说明|
|---|---|---|
|***--name***|vpn|容器名，可以随意定义|
|***--net***|host|网络模式，必须是host，使用主机网络，方便代理主机|
|***--cap-add***|NET_ADMIN|网络控制授权|
|***-v***|/dev/net/tun:/dev/net/tun|代理需要使用tun|
|***-v***|-v /var/services/openvpn/client.ovpn:/etc/openvpn/client.ovpn|挂载配置文件，必须是绝对路径，我在Nas上的这个位置存的，可以自定义|
