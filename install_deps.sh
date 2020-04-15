#!/bin/bash

set -e

apt-get update && apt-get dist-upgrade -y
apt-get install -y build-essential cmake python-pip

pip install -U setuptools
pip install rosdep wstool rosinstall catkin_tools

rosdep init
rosdep update

mkdir -p workspace && pushd workspace
wstool init -j8 src ../install.rosinstall
sed -i s/fcl/libfcl-dev/g src/fcl/package.xml


rosdep install --from-paths src --ignore-src --rosdistro melodic -y
