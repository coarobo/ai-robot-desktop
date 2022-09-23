# 「ROS2とPythonで作って学ぶAIロボット入門」の教材一式を提供するDockerイメージの作成

## 概要
- [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)をフォーク．
  - フォークした時点の内容は[develop](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/tree/develop)ブランチ．
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

## イメージの公開場所

https://hub.docker.com/repository/docker/airobotbook/ros2-desktop-ai-robot-book

## 実行（Linux）

### コンテナ起動

```
./run.bash
```
### デスクトップの利用

- ウェブブラウザをVNCビューアにする場合
  - `http://127.0.0.1:6080` にアクセス．

- VNCビューア（Remminaなど）を使う場合
  - `127.0.0.1:15900` に接続．

## 実行（Windows）

### コンテナ起動

```
run.bat
```

### デスクトップの利用

- ウェブブラウザをVNCビューアにする場合
  - `http://127.0.0.1:6080` にアクセス．

- VNCビューア（TightVNC Viewerなど）を使う場合
  - `127.0.0.1:15900` に接続．

- Windows標準のリモートデスクトップを使う場合
  - `127.0.0.1:13389` に接続．

## 既知の問題・今後の課題

- オーディオ機能付きRDPサーバを使う場合，pyaudioを使う場合にreadがうまく行かない．
- イメージのビルド中にrosdep initの実行に失敗する（現状ではrosdepを使わないようにしている）
- 容量の削減

## 著者

升谷 保博

## 履歴

- 2022/8/31 (v1.0)
  - 書籍の発行に合わせて正式リリース
  - イメージサイズ： 10GB

- 2022/8/25
  - オーディオ機能付きRDPサーバを組み込む．
  - イメージサイズ： 9.8GB

- 2022/8/4
  - [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)からフォークしたものにマージ．
  - イメージサイズ： 9.67GB

## ライセンス

Copyright (c) 2022, MASUTANI Yasuhiro  
All rights reserved.  
This project is licensed under the Apache License 2.0 license found in the LICENSE file in the root directory of this project.

## 参考文献

- Doro Wu: A Docker image to provide web VNC interface to access Ubuntu LXDE/LxQT desktop environment, [GitHub fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)

- Daisuke Sato: Dockerfiles to provide HTML5 VNC interface to access Ubuntu LXDE + ROS2, [GitHub tiryoh/ros2-desktop-vnc:foxy](https://github.com/Tiryoh/docker-ros2-desktop-vnc) 

- danielguerra69: Ubuntu 20.04/18.04/16.04 Multi User Remote Desktop Server, [GitHub danielguerra69/ubuntu-xrdp](https://github.com/danielguerra69/ubuntu-xrdp)
