#Install docker and xhost

sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo service docker start
sudo usermod -aG docker $USER
newgrp docker
sudo service docker restart
sudo apt-get install -y x11-xserver-utils

Simulation Docker files are located in below directory
user:~/ros2_ws/src/fastbot_ros2_docker/simulation$ ls
docker-compose.yaml  docker-compose_copy.yaml  dockerfile-gazebo  dockerfile-slam  dockerfile-webapp  entrypoint.sh  my-site.conf

	
Build image per each package
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp -f fastbot_ros2_docker/simulation/dockerfile-webapp .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam -f fastbot_ros2_docker/simulation/dockerfile-slam .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo -f fastbot_ros2_docker/simulation/dockerfile-gazebo .

Each docker can be run by following command


You can build all of images at once
user:~/ros2_ws/src/fastbot_ros2_docker/simulation$ docker-compose up
bhmoon418/bhmoon713-cp22:fastbot-ros2-webapp		#This Docker image will contain everything necessary for starting the Fastbot Web Application.
bhmoon418/bhmoon713-cp22:fastbot-ros2-slam		#This Docker image will contain everything necessary for starting the Mapping system.
bhmoon418/bhmoon713-cp22:fastbot-ros2-gazebo		#This Docker image will contain everything necessary for starting the Gazebo simulation in ROS2.



For real directory
user:cd ~/ros2_ws/src
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .

You can build all of images at once
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up



user:~/ros2_ws/src$ docker images
REPOSITORY                 TAG                      IMAGE ID       CREATED              SIZE
bhmoon418/bhmoon713-cp22   fastbot-ros2-slam-real   22c275187bb6   About a minute ago   4.35GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-real        6492991e4952   6 minutes ago        4.02GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-gazebo      24f5af8316af   18 minutes ago       4.09GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-slam        04ff52edf9f8   23 minutes ago       4.12GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-webapp      ad977128f3d1   33 minutes ago       238MB
osrf/ros                   humble-desktop-full      b503d5105db2   4 days ago           3.84GB
ubuntu                     22.04                    8a4eacce82df   2 weeks ago          77.9MB



For the case something went wrong, below command will clear up dockers and volumes
docker kill $(docker ps -aq) &> /dev/null; 
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls

Here can try to run docker each.
xhost +local:root
docker run -it --net=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix my_navigation_docker:latest
docker run -it -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix gazebo:v0



user:~/ros2_ws/src$ docker images
REPOSITORY                 TAG                      IMAGE ID       CREATED              SIZE
bhmoon418/bhmoon713-cp22   fastbot-ros2-slam-real   22c275187bb6   About a minute ago   4.35GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-real        6492991e4952   6 minutes ago        4.02GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-gazebo      24f5af8316af   18 minutes ago       4.09GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-slam        04ff52edf9f8   23 minutes ago       4.12GB
bhmoon418/bhmoon713-cp22   fastbot-ros2-webapp      ad977128f3d1   33 minutes ago       238MB
osrf/ros                   humble-desktop-full      b503d5105db2   4 days ago           3.84GB
ubuntu                     22.04                    8a4eacce82df   2 weeks ago          77.9MB



Example of commands

# build everything
docker-compose build
# or only the slam image
docker-compose build fastbot-ros2-slam
# run gazebo first (or in a separate terminal)
docker-compose up fastbot-ros2-gazebo
# then run slam
docker-compose up fastbot-ros2-slam