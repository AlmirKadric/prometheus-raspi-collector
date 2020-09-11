#!/bin/bash

set -o nounset
set -o errexit


# Make collector script executable
chmod +x "/usr/local/sbin/raspi_collector"

# Shutdown service just in case
systemctl stop raspi_collector.timer || true
systemctl disable raspi_collector.timer

# Enable service and start
systemctl daemon-reload
systemctl enable raspi_collector.timer
systemctl start raspi_collector.timer