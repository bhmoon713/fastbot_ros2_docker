# First, install docker, docker-compose and xhost

```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo service docker start

sudo usermod -aG docker $USER
newgrp docker

sudo service docker restart
sudo apt-get install -y x11-xserver-utils
```

# Simulation Docker files are located in below directory
```bash
user:~/ros2_ws/src/fastbot_ros2_docker/simulation$ ls
docker-compose.yaml docker-compose_copy.yaml dockerfile-gazebo dockerfile-slam dockerfile-webapp entrypoint.sh
my-site.conf
```


# Build image per each package
```bash
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp -f fastbot_ros2_docker/simulation/dockerfile-webapp .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam -f fastbot_ros2_docker/simulation/dockerfile-slam .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo -f fastbot_ros2_docker/simulation/dockerfile-gazebo .
```
Following images are created
```
bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp #This Docker image will contain everything necessary for starting the Fastbot Web Application.
bhmoon418/bhmoon713-cp22:fastbot-ros2-slam #This Docker image will contain everything necessary for starting the Mapping system.
bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo #This Docker image will contain everything necessary for starting the Gazebo simulation in ROS2.
```

# Run simulation only.
Below command will launch simulation
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

and you can go to next terminal and run below command to move into container.

```bash
sudo docker exec -it fastbot_gazebo_container bash
```
and now in the container, move the robot

```bash
root@cd308b0e1118:/ros2_ws# ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=fastbot/cmd_vel
```

# Run slam only.
```
xhost +local:root
docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix bhmoon418/bhmoon713-cp22:fastbot-ros2-slam bash
```
# if you want to run only nginx
```bash
docker run --rm -it \
  --name nginx_container \
  -h nginx_container \
  -p 7000:80 \
  -v $HOME/ros2_ws/src/fastbot_webapp:/usr/share/nginx/html:ro \
  -v $HOME/ros2_ws/src/fastbot_ros2_docker/simulation/logs:/var/log/nginx \
  bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
```
or
```bash
docker run --rm -it --name nginx_container   -h nginx_container   -p 7000:80   bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
docker run --rm -it --name nginx_container -h nginx_container -p 7000:80 -p 9090:9090 bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp
docker run --rm -it --net=host --name nginx_container -h nginx_container -p 7000:80 -p 9090:9090 bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp



```
ros2 launch rosbridge_server rosbridge_websocket_launch.xml


# You can build and execute all of images at once
```bash
user: cd ~/ros2_ws/src/fastbot_ros2_docker/simulation
user:~/ros2_ws/src/fastbot_ros2_docker/simulation$ xhost +local:root
user:~/ros2_ws/src/fastbot_ros2_docker/simulation$ docker-compose up
```


docker network inspect simulation_fastbot_net | grep -i name


# When you try on other terminal
```bash
sudo usermod -aG docker $USER
newgrp docker
sudo service docker restart
```


# For real robot directory
```bash
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .
```
# You can build all of images at once
```bash
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
user:~/ros2_ws/src$ docker images
```

REPOSITORY TAG IMAGE ID CREATED SIZE
bhmoon418/bhmoon713-cp22 fastbot-ros2-slam-real 22c275187bb6 About a minute ago 4.35GB
bhmoon418/bhmoon713-cp22 fastbot-ros2-real 6492991e4952 6 minutes ago 4.02GB
bhmoon418/bhmoon713-cp22 fastbot-ros2-gazebo 24f5af8316af 18 minutes ago 4.09GB
bhmoon418/bhmoon713-cp22 fastbot-ros2-slam 04ff52edf9f8 23 minutes ago 4.12GB
bhmoon418/bhmoon713-cp22 fastbot-ros2-webapp ad977128f3d1 33 minutes ago 238MB
osrf/ros humble-desktop-full b503d5105db2 4 days ago 3.84GB
ubuntu 22.04 8a4eacce82df 2 weeks ago 77.9MB


# For the case something went wrong, below command will clear up dockers and volumes

```bash
docker kill $(docker ps -aq) &> /dev/null;
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls
```



# Example of commands

```bash
docker-compose build
docker-compose build fastbot-ros2-slam
docker-compose up fastbot-ros2-gazebo
docker-compose up fastbot-ros2-slam
docker exec practical_roentgen /bin/bash -c 'source /opt/ros/noetic/setup.bash && rosservice list'
```


