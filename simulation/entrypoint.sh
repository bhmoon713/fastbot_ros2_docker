#! /bin/bash 
set -e
set -x

# Source ROS 2 else ros2 command is not recognized
#source /opt/ros/humble/setup.bash
#source /ros2_ws/install/setup.bash

#ros2 launch rosbridge_server rosbridge_websocket_launch.xml

echo "$(date +'[%Y-%m-%d %T]') Starting nginx server..."

nginx -g 'daemon off;'