# Real robot

From your terminal, ssh to fastbot real robot
```bash
ssh fastbot@master
```
now you are in the robot fastbot@fastbot:~$
```bash
fastbot@fastbot:~$ sudo apt update
fastbot@fastbot:~$ sudo apt install git -y
fastbot@fastbot:~$ sudo apt-get update
fastbot@fastbot:~$ sudo apt-get install -y docker.io docker-compose
fastbot@fastbot:~$ sudo service docker start
fastbot@fastbot:~$ sudo usermod -aG docker fastbot
fastbot@fastbot:~$ newgrp docker

fastbot@fastbot:~$ cd ros2_ws/src
fastbot@fastbot:~/ros2_ws/src$ rm -rf fastbot_ros2_docker/
fastbot@fastbot:~/ros2_ws/src$ git clone https://github.com/bhmoon713/fastbot_ros2_docker.git
fastbot@fastbot:~/ros2_ws/src$ cd fastbot_ros2_docker/real/
fastbot@fastbot:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```

# if you want to try at your local computer, you can key these commands

```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo service docker start

sudo usermod -aG docker $USER
newgrp docker

sudo service docker restart
sudo apt-get install -y x11-xserver-utils
```

# You want to download from docker hub and run.
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ xhost +local:root
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```

# You want to build locally and run. Remove hash tag for build at compose file
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up --build 
```


# Build image per each package
```bash
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .
```
Following images are created
```bash
bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real #This Docker image will contain everything necessary for starting the Mapping system.
bhmoon418/bhmoon713-cp22:fastbot-ros2-real #This Docker image will contain everything necessary for starting the Gazebo real in ROS2.
```

## Check the network, it should show three attachments

```bash
docker network inspect real_fastbot_net | grep -i name
```
    "Name": "real_fastbot_net",
            "Name": "nginx_container",
            "Name": "fastbot-ros2-gazebo",
            "Name": "fastbot-ros2-slam",


## Check each docker : nginx Docker
```bash
sudo docker exec -it nginx_container bash

root@cd308b023452:
source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash
ps aux | grep republisher
ps aux | grep rosbridge
```

### Rosbridge is already running by docker but this is command
```bash
ros2 launch rosbridge_server rosbridge_websocket_launch.xml
```

### tf2_web_republisher is already running by docker but this is command
```bash
ros2 run tf2_web_republisher tf2_web_republisher_node
```

## Gazebo Docker (try move robot)
```bash
sudo docker exec -it fastbot-ros2-gazebo bash
root@cd308b0e1118:/ros2_ws# ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=fastbot/cmd_vel
```
## Slam Docker
```bash
sudo docker exec -it fastbot-ros2-slam bash
```

# Individual Docker Running 
## Run real only.
Below command will launch real
```bash
xhost +local:root
docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo bash
```
or
```bash
docker run -it \
  -e DISPLAY=$DISPLAY \
  -e XDG_RUNTIME_DIR=/tmp/runtime-root \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $XAUTHORITY:/root/.Xauthority \
  -e XAUTHORITY=/root/.Xauthority \
  --net=host \
  bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo bash
```
or 
```bash
docker run -it \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name fastbot_gazebo_container \
  bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo bash
```

## Run slam only.
```
xhost +local:root
docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix bhmoon418/bhmoon713-cp22:fastbot-ros2-slam bash
```
## if you want to run only nginx
```bash
docker run --rm -it \
  --name nginx_container \
  -h nginx_container \
  -p 7000:80 \
  -v $HOME/ros2_ws/src/fastbot_webapp:/usr/share/nginx/html:ro \
  -v $HOME/ros2_ws/src/fastbot_ros2_docker/real/logs:/var/log/nginx \
  bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
```
or
```bash
docker run --rm -it --name nginx_container   -h nginx_container   -p 7000:80   bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
docker run --rm -it --name nginx_container -h nginx_container -p 7000:80 -p 9090:9090 bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
docker run --rm -it --net=host --name nginx_container -h nginx_container -p 7000:80 -p 9090:9090 bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
```


# When you try on other terminal
```bash
sudo usermod -aG docker $USER
newgrp docker
```
################################################################################################################
################################################################################################################

# You want to download from docker hub and run.
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```

# You want to build locally and run.
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ xhost +local:root
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up 
```


# build individual docker real robot directory
```bash
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .
```
# You can build all of images at once
```bash
cd fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
user:~/ros2_ws/src$ docker images
```

# Check network
docker network inspect real_fastbot_net | grep -i name
docker network inspect real_fastbot_net | grep -i name

# Check in container for debug
sudo docker exec -it fastbot-ros2-real bash
sudo docker exec -it fastbot-ros2-slam-real bash

docker run --rm -it --name fastbot-ros2-real   -h fastbot-ros2-real    bhmoon418/bhmoon713-cp22:fastbot-ros2-real

# For the case something went wrong, below command will clear up dockers and volumes

```bash
docker kill $(docker ps -aq) &> /dev/null;
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls
```
