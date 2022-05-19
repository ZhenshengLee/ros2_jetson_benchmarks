#!/usr/bin/bash

# usage: create_reports.bash my_experiment

log_dir=${1:-perf_logs}

# Create rmw comparison report
mkdir -p $log_dir/rmw_compare/rmw_cyclonedds_cpp
mkdir -p $log_dir/rmw_compare/rmw_fastrtps_cpp
mkdir -p $log_dir/rmw_compare/rmw_ecal_dynamic_cpp
cp $log_dir/rmw_cyclonedds_cpp/experiments/* $log_dir/rmw_compare/rmw_cyclonedds_cpp
cp $log_dir/rmw_fastrtps_cpp/experiments/* $log_dir/rmw_compare/rmw_fastrtps_cpp
cp $log_dir/rmw_ecal_dynamic_cpp/experiments/* $log_dir/rmw_compare/rmw_ecal_dynamic_cpp

ros2 run performance_report reporter --log-dir $log_dir/rmw_compare  --configs ../reporter/rmw_compare/report_compare_transport__rmw_cyclonedds*
ros2 run performance_report reporter --log-dir $log_dir/rmw_compare --configs ../reporter/rmw_compare/report_compare_transport__rmw_fastrtps*
ros2 run performance_report reporter --log-dir $log_dir/rmw_compare  --configs ../reporter/rmw_compare/report_compare_transport__rmw_ecal*

ros2 run performance_report reporter --log-dir $log_dir/rmw_compare --configs ../reporter/rmw_compare/report_compare_rmw__udp_*
ros2 run performance_report reporter --log-dir $log_dir/rmw_compare --configs ../reporter/rmw_compare/report_compare_rmw__intra_*
ros2 run performance_report reporter --log-dir $log_dir/rmw_compare --configs ../reporter/rmw_compare/report_compare_rmw__zc_*

# Remove temp files
rm -r $log_dir/rmw_compare/rmw_*
