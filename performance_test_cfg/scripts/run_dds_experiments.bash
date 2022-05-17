#!/usr/bin/bash

# usage: run_experiments.bash my_experiment

# Setup
# Run script inside perf test workspace root
# Clone performance_test_rt_cfg in home path

log_dir=${1:-perf_logs}

# Run experiments and reports
ros2 run performance_report runner --log-dir $log_dir/dds --test-name experiments --configs ../runner/run_dds_experiments.yaml
