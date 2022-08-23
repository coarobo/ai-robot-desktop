@echo off
docker run ^
-e http_proxy=%http_proxy% ^
-e https_proxy=%https_proxy% ^
-e HTTP_PROXY=%HTTP_PROXY% ^
-e HTTPS_PROXY=%HTTPS_PROXY% ^
-e RESOLUTION=1920x1080 ^
--name ai_robot_book ^
-p 5900:5900 ^
-p 13389:3389 ^
-p 6080:80 ^
--shm-size=512m ^
--privileged ^
%* ^
airobotbook/ros2-desktop-ai-robot-book:latest