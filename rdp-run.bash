#!/bin/bash
docker run \
-e http_proxy=${http_proxy} \
-e https_proxy=${https_proxy} \
-e HTTP_PROXY=${HTTP_PROXY} \
-e HTTPS_PROXY=${HTTPS_PROXY} \
-e RESOLUTION=1920x1080 \
--name ai_robot_book \
-p 13389:3389 \
--shm-size=512m \
--privileged \
$* \
airobotbook/ros2-desktop-ai-robot-book:latest