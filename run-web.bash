#!/bin/bash
docker run \
-e http_proxy=${http_proxy} \
-e https_proxy=${https_proxy} \
-e HTTP_PROXY=${HTTP_PROXY} \
-e HTTPS_PROXY=${HTTPS_PROXY} \
-e RESOLUTION=1920x1080 \
-e PULSE_COOKIE=/tmp/pulse/cookie \
-e PULSE_SERVER=unix:/tmp/pulse/native \
-v /run/user/$(id -u)/pulse/native:/tmp/pulse/native \
-v ~/.config/pulse/cookie:/tmp/pulse/cookie:ro \
--name ai_robot_book \
-p 6080:80 \
--shm-size=512m \
--privileged \
--rm \
airobotbook/ros2-desktop-ai-robot-book:ver0