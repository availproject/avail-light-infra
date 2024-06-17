[lightnode]
%{ for lightnode in jsondecode(lightnodes) ~}
${lightnode.hostname} ansible_host=${lightnode.ip}
%{ endfor ~}

[bootnode]


[fatclient]

[all:vars]
ansible_ssh_private_key_file=${network}_key
ansible_user=root
service_prefix=avail-light
service_dir=/etc/systemd/system
avail_user=avail
avail_home=/var/lib/avail-light
network=${network}