#!/user/bin/bash

# usage: run_experiments.bash my_experiment

# Setup
# Run script inside perf test workspace root
# Clone performance_test_rt_cfg in home path

log_dir=${1:-perf_logs}

# Run experiments and reports
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ros2 run performance_report runner --log-dir $log_dir/$RMW_IMPLEMENTATION --test-name experiments --configs ~/performance_test_rt_cfg/runner/run_all_experiments.yaml

export RMW_IMPLEMENTATION=rmw_fastrtps_cpp 
ros2 run performance_report runner --log-dir $log_dir/$RMW_IMPLEMENTATION --test-name experiments --configs ~/performance_test_rt_cfg/runner/run_all_experiments.yaml