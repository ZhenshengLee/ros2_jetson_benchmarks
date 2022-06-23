# ros2_jetson_benchmarks

## amd64

### os performance tunning

#### cpu power-saving

```sh
sudo nano /etc/default/grub
GRUB_CMDLINE_LINUX="nosmt processor.max_cstate=0 intel_idle.max_cstate=0"

sudo update-grub
sudo reboot -h now
```

#### cpu performance-mode

```sh
sudo apt-get install cpufrequtils
# to get the highest freq
sudo cpufreq-set -g performance
```

#### network-stack

64MB

```sh
sudo cpufreq-set -g performance
sudo sysctl -w net.ipv4.udp_mem="10240087380016777216"
sudo sysctl -w net.core.netdev_max_backlog="30000"
sudo sysctl -w net.core.rmem_max="67108864"
sudo sysctl -w net.core.wmem_max="67108864"
sudo sysctl -w net.core.rmem_default="67108864"
sudo sysctl -w net.core.wmem_default="67108864"
```

#### swap

```sh
sudo swapoff -a
sudo nano /etc/fstab
# comment the swap config
```

### os realtime tunning

todo

### performance test results

#### a handy test

the unit is ms.
1:1 pub: sub
qos: besteffort + keep all + volatile + historydepth=1000

| version | format | encoder  | trans    | dds      | Array1K | Array60K | Array256K | Array1M | Array2M | Array4M |
| ------- | ------ | -------- | -------- | -------- | ------- | -------- | --------- | ------- | ------- | ------- |
| 2.3.x   | idl    | cdr      | shm      | fastrtps | 0.03    | 0.03     | 0.04      | 0.12    | 0.22    | 0.46    |
| 2.3.x   | idl    | cdr      | zc       | fastrtps | 0.015   | 0.018    | 0.025     | 0.05    | 0.09    | 0.20    |
| 1.0.1   | rosidl | none     | zc       | iceoryx  | 0.02    | 0.028    | 0.05      | 0.11    | 0.12    | -       |
| 5.10.0  | proto2 | protobuf | shm      | ecal     | 0.012   | 0.078    | 0.29      | 1.16    | 2.38    | 4.62    |
| 5.10.0  | proto2 | protobuf | zc       | ecal     | 0.042   | 0.14     | 0.36      | 1.13    | 2.26    | 4.45    |
| 5.10.0  | proto3 | protobuf | shm(opt) | ecal     | 0.009   | 0.02     | 0.06      | 0.34    | 0.68    | 2.28    |
| 5.10.0  | proto3 | protobuf | zc(opt)  | ecal     | 0.009   | 0.018    | 0.048     | 0.232   | 0.455   | 0.97    |
| 5.10.0  | rosidl | none     | shm      | ecal     | 0.033   | 0.072    | 0.115     | 0.30    | 0.52    | 0.94    |
| 5.10.0  | rosidl | none     | zc       | ecal     | 0.029   | 0.058    | 0.099     | 0.188   | 0.292   | 0.512   |
| 5.10.0  | rosidl | none     | shm(opt) | ecal     | 0.009   | 0.016    | 0.038     | 0.166   | 0.32    | 0.68    |
| 5.10.0  | rosidl | none     | zc(opt)  | ecal     | 0.008   | 0.010    | 0.017     | 0.043   | 0.074   | 0.146   |

## jetson-xavier

### os tunning

```sh
# jetson
sudo jetson_clocks
```

```sh
sudo cpufreq-set -g performance
sudo sysctl -w net.ipv4.udp_mem="10240087380016777216"
sudo sysctl -w net.core.netdev_max_backlog="30000"
sudo sysctl -w net.core.rmem_max="67108864"
sudo sysctl -w net.core.wmem_max="67108864"
sudo sysctl -w net.core.rmem_default="67108864"
sudo sysctl -w net.core.wmem_default="67108864"
```

## automatic test report

see [test report for amd64](./benchmark_results/galactic/pc_ros2_galactic_v5.13.0-41-generic_amd64/)

see [test report for jetson-xavier](./benchmark_results/galactic/xavier_r32.5.1_ros2_galactic_4.9.201-tegra_aarch64/)
