#!/bin/bash

source .moveit_ci/util.sh

travis_fold start apt_build_system "Install build system"

travis_run_true sudo apt-get update
travis_run_true sudo apt-get install -qq -y build-essential cmake python-pip xvfb mesa-utils

travis_run_true sudo apt-get install -y -qq libccd-dev libqglviewer-dev-qt5

travis_run_true sudo pip install -U setuptools
travis_run_true sudo pip install rosdep wstool rosinstall catkin_tools

travis_run_true sudo rosdep init
travis_run_true rosdep update

travis_fold end apt_build_system

travis_fold start run_wstool "Download ROS packages"

travis_run_simple mkdir -p workspace
travis_run_simple cd workspace
travis_run_true wstool init -j8 src ../install.rosinstall
travis_run_simple --assert sed -i s/fcl/libfcl-dev/g src/fcl/package.xml

travis_fold end run_wstool

travis_fold start run_rosdep "Installing dependencies"

travis_run_true rosdep install --from-paths src --ignore-src --rosdistro melodic -y

travis_fold end run_rosdep
