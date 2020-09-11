#!/bin/bash

set -o nounset
set -o errexit


# Get text file location
TEXTFILE_DIR="/var/lib/prometheus/node-exporter"
METRICS_FILE="${TEXTFILE_DIR}/raspi-metrics.prom"

# Stop and disable service
systemctl stop raspi_collector.timer || true
systemctl disable raspi_collector.timer
systemctl daemon-reload

# Remove created text files
rm -f "${METRICS_FILE}"