prometheus-raspi-collector
==========================
Prometheus text collector for Raspberry Pi metrics

Installation
------------

Install Debian package
```
$ PRC_DEB_TMP="$(mktemp).deb"
$ curl -L https://github.com/AlmirKadric/prometheus-raspi-collector/releases/download/v0.1.0-1/prometheus-raspi-collector_0.1.0-1_armhf.deb -o "${PRC_DEB_TMP}"
$ sudo apt install "${PRC_DEB_TMP}"
```

Check service status
```
$ sudo systemctl status raspi_collector.timer
● raspi_collector.timer - Timer for the Raspberry Pi Prometheus text collector
   Loaded: loaded (/etc/systemd/system/raspi_collector.timer; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2020-09-11 11:17:57 BST; 4s ago
  Trigger: n/a
```

Check metrics file
```
$ grep -E '^rpi' /var/lib/prometheus/node-exporter/raspi-metrics.prom
rpi_temperature{sensor="thermal_zone0",type="cpu-thermal"} 40.407
rpi_frequency{component="arm"} 600117184
rpi_frequency{component="core"} 199995120
...
```

Packaging
---------
Dependencies (macOS)
```
$ brew install gnu-tar
```

Package
```
$ bash package.sh [version] [iteration]
```

License
-------
MIT