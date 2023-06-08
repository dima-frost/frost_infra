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

> docker rm $(docker ps -a -q) # remove all working containers
> docker rmi $(docker images -q)


# Docker-3

### HOWTO BUILD

docker pull mongo:latest
docker build -t dimafrost/post:1.0 ./post-py
docker build -t dimafrost/comment:1.0 ./comment
docker build -t dimafrost/ui:1.0 ./ui

### HOWTO RUN

> docker network create reddit
> docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
> docker run -d --network=reddit --network-alias=post dimafrost/post:1.0
> docker run -d --network=reddit --network-alias=comment dimafrost/comment:1.0
> docker run -d --network=reddit -p 9292:9292 dimafrost/ui:1.0

### ADD VOLUME

> docker volume create reddit_db

> docker run -d --network=reddit --network-alias=post_db \
--network-alias=comment_db -v reddit_db:/data/db mongo:latest

### KILL ALL

 for i in $(docker ps -q); do docker kill $i; done
