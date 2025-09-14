#!/usr/bin/env bash
set -euo pipefail

# RMW (can be overridden from env)
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}"

# Prefer an actual file at /etc/cyclonedds.xml if present
if [[ -f /etc/cyclonedds.xml ]]; then
  export CYCLONEDDS_URI="file:///etc/cyclonedds.xml"
else
  # If you KNOW another file exists, set CYCLONEDDS_URI via env/compose instead.
  unset CYCLONEDDS_URI || true
fi

# Source ROS 2
source /opt/ros/humble/setup.bash

# Source your workspace if it exists (don’t fail if missing)
if [[ -f /ros2_ws/install/setup.bash ]]; then
  source /ros2_ws/install/setup.bash
fi

# Run the given command, or keep a shell if none provided (avoid crash-loop)
if [[ $# -eq 0 ]]; then
  echo "[entrypoint] No CMD provided; starting interactive shell."
  exec bash
else
  exec "$@"
fi
