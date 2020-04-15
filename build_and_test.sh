#!/bin/bash

source .moveit_ci/util.sh


cd workspace


travis_fold start catkin_build "Building workspace"

Xvfb -screen 0 640x480x24 :99 &
export DISPLAY=:99.0
travis_run glxinfo -B

travis_run catkin config --install --init --no-extend --jobserver --cmake-args $CMAKE_ARGS

travis_run catkin build

travis_fold end catkin_build

source install/setup.sh

travis_fold start catkin_build_tests "Building Tests"

travis_run catkin build --make-args tests

travis_fold end catkin_build_tests


travis_fold start catkin_run_tests "Run Tests"

travis_run catkin build --catkin-make-args run_tests

travis_fold end catkin_run_tests

travis_run catkin_test_results
