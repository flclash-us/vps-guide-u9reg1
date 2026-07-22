#!/bin/bash
# VPS Performance Benchmark Script
set -e

echo "========================================"
echo " VPS Performance Benchmark"
echo "========================================"

echo -e "\n[System Info]"
cat /etc/os-release | grep PRETTY_NAME
echo "Kernel: $(uname -r)"
echo "CPU: $(grep model\\ name /proc/cpuinfo | head -1 | cut -d: -f2)"
echo "CPU Cores: $(nproc)"

if command -v sysbench &> /dev/null; then
    echo -e "\n[Running CPU Test]"
    sysbench cpu --cpu-max-prime=20000 --time=30 run
fi

echo -e "\n[Running Disk IO Test]"
dd if=/dev/zero of=test bs=64k count=16k oflag=direct 2>&1 | tail -1
rm -f test

echo -e "\n[Benchmark Complete]"