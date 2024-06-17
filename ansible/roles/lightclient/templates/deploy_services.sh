#!/bin/bash

# Define variables
CLIENT_ROLE="{{ service_prefix }}"
CLIENT_VERSION="{{ client_version }}"
SERVICE_DIR="{{ service_dir }}"
SERVICE_START={{ service_start }}
SERVICE_END={{ service_end }}

# Create systemd service files
for (( ITEM=SERVICE_START; ITEM<SERVICE_END; ITEM++ )); do
  cat << EOF > ${SERVICE_DIR}/${CLIENT_ROLE}-${ITEM}.service
[Unit]
Description=${CLIENT_ROLE}-${ITEM}
Documentation="https://github.com/availproject/${CLIENT_ROLE}"

# Bring this up after the network is online
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=${CLIENT_ROLE}-${CLIENT_VERSION} --clean \
--http-server-port $((7000 + ITEM)) \
--seed "${HOSTNAME}-${ITEM}" \
--port $((37000 + ITEM)) \
--config /etc/avail-light/config.toml \
--network {{ network }}

Environment="RUST_BACKTRACE=1"

Restart=on-failure
RestartSec=5s

Type=exec

User=root
Group=root

TimeoutStartSec=infinity
TimeoutStopSec=600

[Install]
WantedBy=multi-user.target
EOF
  systemctl enable ${CLIENT_ROLE}-${ITEM}
  echo "Configured ${CLIENT_ROLE}-${ITEM} ..."
done

# Reload systemd to pick up new service files
systemctl daemon-reload
echo "Run daemon-reload ..."

# Restart all avail-light services
for (( ITEM=SERVICE_START; ITEM<=SERVICE_END; ITEM++ )); do
  systemctl restart ${CLIENT_ROLE}-${ITEM} || true
done
echo "Started all services from ${SERVICE_START} to ${SERVICE_END}"