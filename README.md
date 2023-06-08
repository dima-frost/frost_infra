# frost_infra
integration whith travic-ci

# Docker-1

Usefull cli commnads:

> docker --version
> docker info
>  docker ps
>  docker ps -a
>  docker images
>  docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Names}}"
> docker start <u_container_id>
> docker attach <u_container_id>
docker run = docker create + docker start +
docker attach*
> docker create # create without starting

docker run parrametrs:
-i - start in foregraund mode (docker attach)
-d - start in backgraund mode
-t - create TTY
example: docker run -dt nginx:latest

> docker exec #create new proces inside container
example: docker exec -it <u_container_id> bash

> docker commit #create image from container
example: docker commit <u_container_id> yourname/ubuntu-tmp-file

Docker kill & stop

> docker kill # SIGKILL >docker kill $(docker ps -q)
> docker stop # SIGTERM

> docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          15        2         4.994GB   4.994GB (99%)
Containers      3         0         0B        0B
Local Volumes   14        0         2.267GB   2.267GB (100%)
Build Cache     0         0         0B        0B

Docker rm & rmi

> docker rm # remove container, with parram -f remove working container(sigkill)
> docker rmi # remove image if image doesn't have container that depend on it image

>docker rm $(docker ps -a -q) # remove all working containers
>docker rmi $(docker images -q)
### None network driver
> docker run -ti --rm --network none joffotron/docker-net-tools -c ifconfig

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
### Host network driver
> docker run -ti --rm --network host joffotron/docker-net-tools -c ifconfig
(same as host "ip a")
br-519f6ff0070b Link encap:Ethernet  HWaddr 02:42:53:38:4B:5F  
          inet addr:172.18.0.1  Bcast:172.18.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

docker0   Link encap:Ethernet  HWaddr 02:42:FB:E0:53:78  
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

enp2s0    Link encap:Ethernet  HWaddr D4:3D:7E:DB:0C:44  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32537/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:1958 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1958 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:166110 (162.2 KiB)  TX bytes:166110 (162.2 KiB)

wlx984827e0748d Link encap:Ethernet  HWaddr 98:48:27:E0:74:8D  
          inet addr:192.168.1.237  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::a03d:9838:9df0:c594%32537/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:524790 errors:0 dropped:3 overruns:0 frame:0
          TX packets:126692 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:597332807 (569.6 MiB)  TX bytes:28033761 (26.7 MiB)

### NETWORK

> docker network create back_net --subnet=10.0.2.0/24
> docker network create front_net --subnet=10.0.1.0/24

> docker run -d --network=back_net --network-alias=post_db --network-alias=comment_db mongo:latest
> docker run -d --network=back_net --network-alias=post dimafrost/post:1.0
> docker run -d --network=back_net --network-alias=comment dimafrost/comment:1.0
> docker run -d --network=front_net -p 9292:9292 dimafrost/ui:1.0

