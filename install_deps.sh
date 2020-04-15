#!/bin/bash

source .moveit_ci/util.sh

travis_fold start apt_build_system "Install build system"

travis_run sudo apt-get update
travis_run sudo apt-get install -qq -y build-essential cmake python-pip xvfb mesa-utils

travis_run sudo apt-get install -y -qq libccd-dev libqglviewer-dev-qt5

travis_run sudo pip install -U setuptools
travis_run sudo pip install rosdep wstool rosinstall catkin_tools

travis_run sudo rosdep init
travis_run rosdep update

travis_fold end apt_build_system

travis_fold start run_wstool "Download ROS packages"

mkdir -p workspace
cd workspace
travis_run wstool init -j8 src ../install.rosinstall
travis_run_simple --no-timing sed -i s/fcl/libfcl-dev/g src/fcl/package.xml

travis_fold end run_wstool

travis_fold start run_rosdep "Installing dependencies"

travis_run rosdep install --from-paths src --ignore-src --rosdistro melodic -y

travis_fold end run_rosdep
