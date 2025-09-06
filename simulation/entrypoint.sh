#!/usr/bin/env bash
# safer flags, but avoid -u while sourcing ROS
set -Eeo pipefail

# --- source ROS envs (disable -u temporarily) ---
set +u
source /opt/ros/humble/setup.bash
[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash
set -u 2>/dev/null || true   # re-enable if supported

# Start rosbridge (bind to all interfaces for -p 9090:9090)
ros2 launch rosbridge_server rosbridge_websocket_launch.xml \
  address:=0.0.0.0 port:=9090 > /var/log/rosbridge.log 2>&1 &

# Start webTF publisher (tf2_web_republisher node,, follong gitclone Cmake)
ros2 run tf2_web_republisher tf2_web_republisher_node \
  > /var/log/tf2_web_republisher.log 2>&1 &


# Start nginx in foreground (container must not exit)
exec nginx -g 'daemon off;'
