#!/bin/bash

set -o nounset
set -o errexit


SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"

PACKAGE_VERSION="${1:-}"
if ! (echo "${PACKAGE_VERSION}" | grep -q -E '^[0-9]+\.[0-9]+\.[0-9]+$'); then
    echo "Usage: ${0} [version] [iteration]"
    exit 1
fi

PACKAGE_ITERATION="${2:-}"
if ! (echo "${PACKAGE_ITERATION}" | grep -q -E '^[0-9]+'); then
    echo "Usage: ${0} [version] [iteration]"
    exit 1
fi

# Make sure fpm was installed
if ! (gem list fpm | grep -q fpm); then
    sudo gem install fpm
fi

# Add gnu-tar in path if macOS
if uname -a | grep -qi 'darwin'; then
    export PATH="${PATH}:/usr/local/opt/gnu-tar/libexec/gnubin"
fi


# Create Debian package
fpm -s dir -t deb \
    --name "prometheus-raspi-collector" \
    --description "Prometheus text collector for Raspberry Pi metrics" \
    --category "net" \
    --url "https://github.com/AlmirKadric/prometheus-raspi-collector" \
\
    --maintainer "Almir Kadric <github@almirkadric.com>" \
    --license "MIT" \
\
    --version "${PACKAGE_VERSION}" \
    --iteration "${PACKAGE_ITERATION}" \
\
    --architecture "armhf" \
    --depends "curl" \
    --depends "libraspberrypi-bin" \
    --depends "prometheus-node-exporter" \
\
    --after-install "${SCRIPT_PATH}/scripts/deb/after_install.sh" \
    --before-remove "${SCRIPT_PATH}/scripts/deb/before_remove.sh" \
\
    --force \
    --package "${SCRIPT_PATH}/package" \
    -C "${SCRIPT_PATH}/src" .