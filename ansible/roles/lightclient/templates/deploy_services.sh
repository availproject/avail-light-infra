#!/bin/bash

# TODO: specify FC block partitions
# Define variables
SERVICE_PREFIX="{{ service_prefix }}"
CLIENT_VERSION="{{ client_version }}"
SERVICE_DIR="{{ service_dir }}"
SERVICE_START={{ service_start }}
SERVICE_END={{ service_end }}

# Create systemd service files
for (( INDEX=SERVICE_START; INDEX<SERVICE_END; INDEX++ )); do
  cat << EOF > ${SERVICE_DIR}/${SERVICE_PREFIX}-${INDEX}.service
[Unit]
Description=${SERVICE_PREFIX}-${INDEX}

After=network-online.target
Wants=network-online.target

[Service]
ExecStart=${SERVICE_PREFIX}-${CLIENT_VERSION} --clean \
--http-server-port $((7000 + INDEX)) \
--seed "${HOSTNAME}-${INDEX}" \
--port $((38000 + INDEX)) \
--config /etc/avail-light/config.toml \
--verbosity debug \
--avail-path {{ avail_home }}/${SERVICE_PREFIX}-${INDEX}/db \
--identity {{ avail_home }}/${SERVICE_PREFIX}-${INDEX}/identity.toml \
{% if group_names[0] == "fatclient" %}
--block-matrix-partition $((INDEX + 1))/40
{% endif %}

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
  systemctl enable ${SERVICE_PREFIX}-${INDEX}
  echo "Configured ${SERVICE_PREFIX}-${INDEX} ..."
done

# Reload systemd to pick up new service files
systemctl daemon-reload
echo "Run daemon-reload ..."

# Restart all avail-light services
for (( INDEX=SERVICE_START; INDEX<=SERVICE_END; INDEX++ )); do
  systemctl restart ${SERVICE_PREFIX}-${INDEX} || true
done
echo "Started all services from ${SERVICE_START} to ${SERVICE_END}"
