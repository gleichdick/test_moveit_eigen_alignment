#!/bin/bash

set -e

source .moveit_ci/util.sh

travis_fold start apt_build_system "Install build system"

sudo apt-get update
sudo apt-get install -qq -y build-essential cmake python-pip

sudo apt-get install -y -qq libccd-dev libqglviewer-dev-qt5

sudo pip install -U setuptools
sudo pip install rosdep wstool rosinstall catkin_tools

sudo rosdep init
rosdep update

travis_fold end apt_build_system

travis_fold start wstool "Download ROS packages"

mkdir -p workspace && cd workspace
wstool init -j8 src ../install.rosinstall
sed -i s/fcl/libfcl-dev/g src/fcl/package.xml

travis_fold end wstool

travis_fold start rosdep "Installing dependencies"

rosdep install --from-paths src --ignore-src --rosdistro melodic -y

travis_fold end rosdep
