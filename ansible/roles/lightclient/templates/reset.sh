#!/bin/bash

# Stop all matching services
for service in $(systemctl list-units --type=service --all --no-pager --no-legend 'avail-*' | awk '{print $1}'); do
  echo "Stopping $service"
  sudo systemctl stop "$service"
done

# Disable all matching services
for service in $(systemctl list-unit-files --type=service --all --no-pager --no-legend 'avail-*' | awk '{print $1}'); do
  echo "Disabling $service"
  sudo systemctl disable "$service"
done

# Remove all matching service unit files
for service_file in /etc/systemd/system/avail-*.service /lib/systemd/system/avail-*.service; do
  if [ -e "$service_file" ]; then
    echo "Deleting $service_file"
    sudo rm "$service_file"
  fi
done

# Reload systemd manager configuration
sudo systemctl daemon-reload

echo "All avail-* services stopped and deleted."
