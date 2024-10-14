# ベースイメージを指定 (ARM64 用)
FROM arm64v8/ubuntu:22.04

# 環境変数の設定
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージとROS 2 Humbleのインストール
RUN apt-get update && apt-get install -y \
    locales curl gnupg2 lsb-release python3-pip \
    qemu-user-static binfmt-support build-essential \
    cmake git pkg-config \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# GPGキーとROS 2リポジトリの設定
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | gpg --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2-latest.list

# ROS 2 Humbleのインストール
RUN apt-get update && apt-get install -y ros-humble-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# pipを最新にアップグレードし、colconをインストール
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir -U colcon-common-extensions

# ROS 2 ワークスペースの作成
RUN mkdir -p /ros2_ws/src

# デフォルトのコマンドを指定してコンテナを起動
CMD ["/bin/bash"]

