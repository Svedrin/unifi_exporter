#!/bin/sh

set -e
set -u

<<EOF cat > /tmp/unifi-exporter.conf
listen:
  address: "${UE_LISTEN_ADDRESS:-0.0.0.0:9130}"
  metricspath: "${UE_LISTEN_METRICSPATH:-/metrics}"
unifi:
  address: "${UE_UNIFI_ADDRESS}"
  username: "${UE_UNIFI_USERNAME}"
  password: "${UE_UNIFI_PASSWORD}"
  site: "${UE_UNIFI_SITE}"
  insecure: "${UE_UNIFI_INSECURE:-false}"
  timeout: "${UE_UNIFI_TIMEOUT:-5s}"
EOF

exec /bin/unifi_exporter -config.file /tmp/unifi-exporter.conf "$@"
