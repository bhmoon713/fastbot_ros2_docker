FROM osrf/ros:humble-desktop-full

RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions build-essential \
    ros-humble-cartographer-ros \
    ros-humble-nav2-map-server ros-humble-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ros2_ws
RUN mkdir -p src/fastbot
# Copy slam package (and description in case launch includes robot description)
COPY src/fastbot/fastbot_slam        src/fastbot/fastbot_slam
COPY src/fastbot/fastbot_description src/fastbot/fastbot_description

RUN . /opt/ros/humble/setup.sh && colcon build --symlink-install

ENTRYPOINT ["/bin/bash","-lc"]
# Change launch if you prefer AMCL/localization later; for mapping we use cartographer
CMD ["source /opt/ros/humble/setup.bash && source install/setup.bash && ros2 launch fastbot_slam cartographer.launch.py"]
