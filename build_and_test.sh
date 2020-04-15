#!/bin/bash

source .moveit_ci/util.sh

set -e

cd workspace


travis_fold start catkin_build "Building workspace"

catkin config --install --init --no-extend --jobserver --cmake-args $CMAKE_ARGS

catkin build

travis_fold end catkin_build

source install/setup.sh

travis_fold start catkin_build_tests "Building Tests"

catkin build --make-args tests

travis_fold end catkin_build_tests


travis_fold start catkin_run_tests "Run Tests"

catkin build --catkin-make-args run_tests

travis_fold end catkin_run_tests

catkin_test_results
