#!/usr/bin/env bash

source /opt/ros/foxy/setup.bash

set -eu
set -v

colcon_build_options= # '--symlink-install'

sudo -E apt-get update -q

sudo -E apt-get upgrade -yq

# Gazeboのモデルのダウンロード
# https://gist.github.com/Tiryoh/bf24f61992bfa8e32f2e75fc0672a647
function download_model(){
	if [[ -d $HOME'/.gazebo/models/'$1 ]]; then
		echo model $1 is ready.
	else
		wget -l1 -np -nc -r "http://models.gazebosim.org/"$1 --accept=gz
	fi
}

mkdir -p ~/.gazebo/models && cd ~/.gazebo/models
cd /tmp 
TMPDIR=$(mktemp -d tmp.XXXXXXXXXX) 
cd $TMPDIR 
download_model sun
download_model ground_plane
download_model table
if [[ -d "models.gazebosim.org" ]]; then
	cd "models.gazebosim.org"
	for i in *; do tar -zvxf "$i/model.tar.gz"; done
	cp -vfR * ~/.gazebo/models/
fi
rm -rf $TMPDIR

# 前処理
mkdir -p ~/airobot_ws/src

# 第1章
sudo -E apt-get -y install terminator

# 第2章
cd ~/airobot_ws/src
git clone https://github.com/AI-Robot-Book/chapter2
cd ~/airobot_ws
colcon build $colcon_build_options
sudo -E apt-get -y install xterm
sudo cp ~/airobot_ws/src/chapter2/turtlesim_launch/mysim.launch.py /opt/ros/foxy/share/turtlesim/launch

# 第3章
sudo -E apt-get -y install pulseaudio
sudo -E apt-get -y install portaudio19-dev
pip3 install pyaudio
pip3 install SpeechRecognition
pip3 install gTTS
sudo -E apt-get -y install mpg123
pip3 install mpg123
cd ~/airobot_ws/src
git clone https://github.com/AI-Robot-Book/chapter3
cd ~/airobot_ws
colcon build $colcon_build_options

# 第4章
sudo -E apt-get -y install ros-foxy-navigation2
sudo -E apt-get -y install ros-foxy-nav2-bringup
sudo -E apt-get -y install ros-foxy-slam-toolbox
sudo -E apt-get -y install ros-foxy-dynamixel-sdk
sudo -E apt-get -y install ros-foxy-turtlebot3-msgs
sudo -E apt-get -y install ros-foxy-turtlebot3
sudo -E apt-get -y install ros-foxy-teleop-tools
pip3 install matplotlib
pip3 install seaborn
cd ~/airobot_ws/src
git clone https://github.com/AI-Robot-Book/chapter4
git clone https://github.com/AI-Robot-Book/happy_mini_turtlebot3_sim
cd ~/airobot_ws
colcon build $colcon_build_options
echo "export TURTLEBOT3_MODEL=happy_mini" >> ~/.bashrc
cp -r ~/airobot_ws/src/chapter4/map ~

# 第5章
pip3 install opencv-contrib-python
sudo -E apt-get -y install ros-foxy-vision-opencv
sudo -E apt-get -y install ros-foxy-camera-calibration-parsers
sudo -E apt-get -y install ros-foxy-camera-info-manager
sudo -E apt-get -y install ros-foxy-launch-testing-ament-cmake
sudo -E apt-get -y install ros-foxy-image-pipeline
sudo -E apt-get -y install ros-foxy-usb-cam
sudo -E apt-get -y install ros-foxy-realsense2-camera
cd ~/airobot_ws
git clone -bv6.2 https://github.com/ultralytics/yolov5
cd yolov5
pip3 install -r requirements.txt
cd ~/airobot_ws/src
git clone https://github.com/JMU-ROBOTICS-VIVA/ros2_aruco
git clone https://github.com/AI-Robot-Book/chapter5
cd ~/airobot_ws
colcon build $colcon_build_options

# 第6章
sudo -E apt-get -y install ros-foxy-joint-state-publisher-gui
cd ~/airobot_ws/src
git clone https://github.com/rt-net/crane_plus
### rosdep回避
# rosdep install -r -y -i --from-paths .
### rosdepの代わりに依存パッケージの列挙
sudo -E apt-get -y install \
  ros-foxy-controller-manager ros-foxy-dynamixel-sdk ros-foxy-gazebo-ros2-control \
  ros-foxy-gazebo-ros-pkgs ros-foxy-geometry-msgs ros-foxy-hardware-interface \
  ros-foxy-ign-ros2-control ros-foxy-joint-state-publisher-gui ros-foxy-launch \
  ros-foxy-moveit ros-foxy-moveit-ros-planning-interface ros-foxy-pluginlib \
  ros-foxy-rclcpp ros-foxy-robot-state-publisher ros-foxy-ros2-controllers \
  ros-foxy-ros2controlcli ros-foxy-ros-ign ros-foxy-rviz2 ros-foxy-tf2-geometry-msgs \
  ros-foxy-tf2-ros ros-foxy-xacro 
###
sudo -E apt-get -y install ros-foxy-tf-transformations
pip3 install transforms3d
echo 'KERNEL=="ttyUSB*", DRIVERS=="ftdi_sio", MODE="0666", ATTR{device/latency_timer}="1"' > ~/99-ftdi_sio.rules
sudo -E mv ~/99-ftdi_sio.rules /etc/udev/rules.d/
git clone https://github.com/AI-Robot-Book/chapter6
cd ~/airobot_ws
colcon build $colcon_build_options
## Ignition Gazeboのモデルのダウンロード
ign fuel download -v 4 -u https://fuel.ignitionrobotics.org/1.0/openrobotics/models/sun
ign fuel download -v 4 -u https://fuel.ignitionrobotics.org/1.0/openrobotics/models/ground%20plane
ign fuel download -v 4 -u https://fuel.ignitionrobotics.org/1.0/openrobotics/models/wood%20cube%205cm
ign fuel download -v 4 -u https://fuel.ignitionrobotics.org/1.0/openrobotics/models/table

# 第7章
cd ~/airobot_ws/src
git clone https://github.com/jeffrey870517/executive_smach
git clone https://github.com/AI-Robot-Book/chapter7
cd ~/airobot_ws
colcon build $colcon_build_options

# 付録E
sudo -E apt-get -y install ros-foxy-tf-transformations
pip3 install transforms3d
cd ~/airobot_ws/src
git clone https://github.com/AI-Robot-Book/appendixE
cd ~/airobot_ws
colcon build $colcon_build_options

# Turtlebot2
sudo -E apt-get -y install ros-foxy-gazebo-ros ros-foxy-camera-info-manager
sudo -E apt-get -y install ros-foxy-realsense2-description
sudo -E apt-get -y install ros-foxy-diagnostic-updater ros-foxy-ecl-linear-algebra ros-foxy-kobuki-core ros-foxy-xacro ros-foxy-joint-state-publisher
sudo -E apt-get -y install ros-foxy-navigation2 ros-foxy-nav2-bringup
sudo -E apt-get -y install ros-foxy-urg-node
sudo -E apt-get -y install ros-foxy-tf-transformations
sudo -E apt-get -y install ros-foxy-rqt-robot-steering

cd ~/airobot_ws/src
git clone https://github.com/kobuki-base/kobuki_ros_interfaces
git clone -b foxy-devel https://github.com/pal-robotics/realsense_gazebo_plugin
git clone https://github.com/AI-Robot-Book/kobuki_ros_airobotbook
git clone https://github.com/AI-Robot-Book/turtlebot2_airobotbook

cd ~/airobot_ws
colcon build $colcon_build_options

# 後処理

echo "source ~/airobot_ws/install/setup.bash" >> ~/.bashrc

set +u

sudo -E rm -rf /var/lib/apt/lists/*