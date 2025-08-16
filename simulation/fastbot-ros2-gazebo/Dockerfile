# ROS 2 Humble with Gazebo sim
FROM osrf/ros:humble-desktop-full

# Packages needed by fastbot_gazebo + basics to build
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions build-essential \
    ros-humble-gazebo-ros-pkgs ros-humble-xacro \
    ros-humble-robot-state-publisher ros-humble-joint-state-publisher-gui \
    mesa-utils libgl1-mesa-glx libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

ENV QT_X11_NO_MITSHM=1

# Create and populate a minimal workspace inside the image
WORKDIR /ros2_ws
RUN mkdir -p src/fastbot
# Copy only the simulation-related pkgs from your host context (see compose 'context')
COPY src/fastbot/fastbot_description src/fastbot/fastbot_description
COPY src/fastbot/fastbot_gazebo      src/fastbot/fastbot_gazebo

# Build
RUN . /opt/ros/humble/setup.sh && colcon build --symlink-install

# Launch your sim
ENTRYPOINT ["/bin/bash","-lc"]
CMD ["source /opt/ros/humble/setup.bash && source install/setup.bash && ros2 launch fastbot_gazebo one_fastbot_room.launch.py"]
