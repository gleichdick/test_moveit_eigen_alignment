#!/bin/bash

set -e

cd workspace

catkin config --install --init --no-extend --jobserver --cmake-args $CMAKE_ARGS

catkin build

catkin build --make-args tests

catkin build --catkin-make-args run_tests

catkin_test_results
