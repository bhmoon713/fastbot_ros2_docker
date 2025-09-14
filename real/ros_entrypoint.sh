#!/usr/bin/env bash
set -euo pipefail

export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}"

# Prefer a config baked at /etc/cyclonedds.xml if present
if [[ -f /etc/cyclonedds.xml ]]; then
  export CYCLONEDDS_URI="file:///etc/cyclonedds.xml"
fi

# Source ROS 2
source /opt/ros/humble/setup.bash

# Source workspace if built
if [[ -f /ros2_ws/install/setup.bash ]]; then
  source /ros2_ws/install/setup.bash
fi

# Run the given command (from CMD or docker-compose command:)
if [[ $# -eq 0 ]]; then
  echo "[entrypoint] No CMD provided; starting interactive shell."
  exec bash
else
  exec "$@"
fi
