# Real robot

From your terminal, ssh to fastbot real robot. 
key in password : fastbot

```bash
ssh fastbot@master
```
now you are in the robot fastbot@fastbot:~$
intalling required packages, you can skip this block if you already intalled on your robot

```bash
fastbot@fastbot:~$ sudo apt update
fastbot@fastbot:~$ sudo apt install git -y
fastbot@fastbot:~$ sudo apt-get update
fastbot@fastbot:~$ sudo apt-get install -y docker.io docker-compose
fastbot@fastbot:~$ sudo service docker start
fastbot@fastbot:~$ sudo usermod -aG docker fastbot
fastbot@fastbot:~$ newgrp docker
```
## Now download git page and run the docker images
```bash
fastbot@fastbot:~$ cd ros2_ws/src
fastbot@fastbot:~/ros2_ws/src$ sudo rm -rf fastbot_ros2_docker/
fastbot@fastbot:~/ros2_ws/src$ git clone https://github.com/bhmoon713/fastbot_ros2_docker.git
fastbot@fastbot:~/ros2_ws/src$ cd fastbot_ros2_docker/real/
fastbot@fastbot:~/ros2_ws/src/fastbot_ros2_docker/real$ docker rmi -f $(docker images -aq)
fastbot@fastbot:~/ros2_ws/src/fastbot_ros2_docker/real$ xhost +local:root
fastbot@fastbot:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```
## if you encounter docker container issues during above process, try to remove and try again above process. you can run below command at any context. This will clean up docker containers and docker images.
```bash
docker kill $(docker ps -aq) &> /dev/null;
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls
docker rmi -f $(docker images -aq)
```
## For the case you need build the image again.
cd ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .

## Check each docker container : fastbot-ros2-real
```bash
sudo docker exec -it fastbot-ros2-real bash
root@cd308b0e1118:/ros2_ws# ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=fastbot/cmd_vel
```

## Check each docker container : fastbot-ros2-slam-real
```bash
sudo docker exec -it fastbot-ros2-slam-real bash
source /opt/ros/humble/setup.bash
source install/setup.bash

root@cd308b023452:
```
## Check network
```bash
docker network inspect real_fastbot_net | grep -i name
```
## docker push command
```bash
docker login
bhmoon418
g.q.4xMN2E5bBDG
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-real
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real
```