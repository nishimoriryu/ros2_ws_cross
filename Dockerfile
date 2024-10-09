# ベースイメージを指定 (ARM64 用)
FROM arm64v8/ubuntu:22.04

# ROS 2 Humble のインストール
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN curl -sSL http://repo.ros2.org/repos.key | apt-key add - \
    && echo "deb http://repo.ros2.org/ubuntu/main $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list \
    && apt-get update && apt-get install -y ros-humble-desktop
