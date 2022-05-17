#!/user/bin/bash

# usage: create_reports.bash my_experiment

log_dir=${1:-perf_logs}

# Create reports for each rmw implementation
ros2 run performance_report reporter --log-dir $log_dir/rmw_cyclonedds_cpp --configs ~/performance_test_rt_cfg/reporter/report_compare*
ros2 run performance_report reporter --log-dir $log_dir/rmw_fastrtps_cpp --configs ~/performance_test_rt_cfg/reporter/report_compare*

# Create rmw comparison report
mkdir -p $log_dir/rmw_compare/rmw_cyclonedds_cpp
mkdir -p $log_dir/rmw_compare/rmw_fastrtps_cpp
cp $log_dir/rmw_cyclonedds_cpp/experiments/* $log_dir/rmw_compare/rmw_cyclonedds_cpp
cp $log_dir/rmw_fastrtps_cpp/experiments/* $log_dir/rmw_compare/rmw_fastrtps_cpp
ros2 run performance_report reporter --log-dir $log_dir/rmw_compare --configs ~/performance_test_rt_cfg/reporter/rmw_compare/report_*

# Remove temp files
rm -r $log_dir/rmw_compare/rmw_*
