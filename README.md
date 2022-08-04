# 「ROS2とPythonで作って学ぶAIロボット入門」の教材一式を提供するDockerイメージ
升谷 保博  
2022年8月

## 概要
- [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)をフォーク．
  - オリジナルと違い，amd64, Ubuntu 20.04, LXDEしか想定していない．
- [tiryoh/ros2-desktop-vnc:foxy](https://github.com/Tiryoh/docker-ros2-desktop-vnc) を真似して，ROS2の環境を追加．
- VSCodium
- 日本語環境
- [「ROS2とPythonで作って学ぶAIロボット入門」](https://github.com/AI-Robot-Book/)に必要なライブラリ，パッケージ，サンプルプログラムを全て含む．

## イメージ作成

```
git clone --recursive https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book
cd docker-ros2-desktop-ai-robot-book
./build.bash
```

## 実行（Linux）

### 専用のVNCビューアを使う場合

```
./run.bash
```
VNCビューアで `172.0.0.1:5900` に接続．

### ウェブブラウザをVNCビューアにする場合
```
./run-web.bash
```
ウェブブラウザで `http://127.0.0.1:6080` にアクセス．

## 実行（Windows）

### 専用のVNCビューアを使う場合

```
docker run -e RESOLUTION=1920x1080 --name ai_robot_book -p 5900:5900 --shm-size=512m --privileged --rm airobotbook/ros2-desktop-ai-robot-book:ver0
```
VNCビューアで `172.0.0.1:5900` に接続．

### ウェブブラウザをVNCビューアにする場合
```
docker run -e RESOLUTION=1920x1080 --name ai_robot_book -p 6080:80 --shm-size=512m --privileged --rm airobotbook/ros2-desktop-ai-robot-book:ver0
```
ウェブブラウザで `http://127.0.0.1:6080` にアクセス．

## 既知の問題・今後の課題

- RDPサーバ機能を追加できないか？
- 容量の削減

## 履歴

- ver0
  - [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)からフォークしたものにマージ．
  - イメージサイズ： 9.67GB