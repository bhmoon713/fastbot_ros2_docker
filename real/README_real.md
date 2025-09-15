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
fastbot@fastbot:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```
## if you encounter docker container issues during above process, try to remove and try again above process. you can run below command at any context.
docker kill $(docker ps -aq) &> /dev/null;
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls
docker rmi -f $(docker images -aq)


## if you want to try at your local computer, you can key these commands

```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose
sudo service docker start
sudo usermod -aG docker $USER
newgrp docker
sudo apt-get install -y x11-xserver-utils
sudo apt-get update && sudo apt-get install -y sshpass
```

## You want to download from docker hub and run.
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ xhost +local:root
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up
```

## You want to build locally and run. Remove hash tag for build at compose file
```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/real
user:~/ros2_ws/src/fastbot_ros2_docker/real$ docker-compose up --build 
```


## Build image per each package
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
docker network inspect real_fastbot_net | grep -i name




fastbot@fastbot:~$ sudo nano /etc/udev/rules.d/arduino_nano.rules
fastbot@fastbot:~$ sudo nano /etc/udev/rules.d/arduino_nano.rules
fastbot@fastbot:~$ sudo nano /etc/udev/rules.d/lslidar.rules
fastbot@fastbot:~$ sudo nano /etc/udev/rules.d/arduino_nano.rules

sudo udevadm control --reload-rules
sudo udevadm trigger


## docker push command
docker login
bhmoon418
g.q.4xMN2E5bBDG
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-real
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real

## git push
docker login
bhmoon418
g.q.4xMN2E5bBDG
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-real
docker push bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real


## Use Jenkins
cd webpage_ws
./start_jenkins.sh

See '/home/user/jenkins__pid__url.txt' for Jenkins PID and URL.
and move to that address 

id: admin
pw: 12345

and run "CP22 real robot docker image automation _ Build here"
This automates the docker image build and deplpy at fastbot.
1. it build two images
2. push to docker hub
3. and ssh into fastbot, run docker-compose up at robot. it starts robot automatically


## Check each docker container : fastbot-ros2-real
Goto other terminal at your computer
```bash
sudo usermod -aG docker $USER
newgrp docker
docker exec -it fastbot-ros2-real bash
source /opt/ros/humble/setup.bash
source install/setup.bash

root@cd308b0e1118:$ cd ~/ros2_ws/src
root@cd308b0e1118:/ros2_ws# ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=fastbot/cmd_vel
```

```bash
docker tag bhmoon418/bhmoon713-cp22:fastbot-ros2-real \
           bhmoon418/bhmoon713-cp22:fastbot-ros2-real-arm64

docker tag bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real \
           bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real-arm64
```


## For testing new setuo to build arm compatible docker image

```bash
cd ~/ros2_ws/src
docker kill $(docker ps -aq) &> /dev/null;
docker container prune -f
docker volume rm $(docker volume ls -q)
docker volume ls
docker rmi -f $(docker images -aq)

rm -rf fastbot_ros2_docker/
git clone https://github.com/bhmoon713/fastbot_ros2_docker.git

docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-slam-real -f fastbot_ros2_docker/real/dockerfile-ros2-slam-real .
docker build -t bhmoon418/bhmoon713-cp22:fastbot-ros2-real -f fastbot_ros2_docker/real/dockerfile-ros2-real .

docker build -f fastbot_ros2_docker/real/dockerfile-simple -t arm64-ros-test .
docker run -it --rm arm64-ros-test bash


