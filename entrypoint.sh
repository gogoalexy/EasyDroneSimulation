#!/bin/bash

# Start virtual X server in the background
# - DISPLAY default is :99, set in dockerfile
# - Users can override with `-e DISPLAY=` in `docker run` command to avoid
#   running Xvfb and attach their screen

if [[ -x "$(command -v Xvfb)" && "$DISPLAY" == ":99" ]]; then
	echo "Starting Xvfb"
	Xvfb :99 -screen 0 1600x1200x24+32 &
fi

# Use the LOCAL_USER_ID if passed in at runtime
#if [ -n "${LOCAL_USER_ID}" ]; then
#	echo "Starting with UID : $LOCAL_USER_ID"
	# modify existing user's id
#	usermod -u $LOCAL_USER_ID user
	# run as user
#	exec gosu user "$@"
#else
#	exec "$@"
#fi

${SITL_RTSP_PROXY}/build/sitl_rtsp_proxy &

source ${WORKSPACE_DIR}/edit_rcS.bash $1 $2 &&
cd ${FIRMWARE_DIR} &&
#make px4_sitl gazebo_typhoon_h480
make px4_sitl gazebo_solo_cam__drone_race_track_2018_actual
