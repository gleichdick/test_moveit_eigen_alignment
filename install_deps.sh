#!/bin/bash

set -e

sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install -y build-essential cmake python-pip

sudo pip install -U setuptools
sudo pip install rosdep wstool rosinstall catkin_tools

sudo rosdep init
rosdep update

mkdir -p workspace && cd workspace
wstool init -j8 src ../install.rosinstall
sed -i s/fcl/libfcl-dev/g src/fcl/package.xml

rosdep install --from-paths src --ignore-src --rosdistro melodic -y
