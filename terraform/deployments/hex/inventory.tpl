[bootnode]

[lightnode]
%{ for lightnode in jsondecode(lightnodes) ~}
${lightnode.hostname} ansible_host=${lightnode.ip}
%{ endfor ~}

[fatclient]
%{ for fatclient in jsondecode(fatclients) ~}
${fatclient.hostname} ansible_host=${fatclient.ip}
%{ endfor ~}

[otel]
%{ for otel in jsondecode(otel) ~}
${otel.hostname} ansible_host=${otel.ip}
%{ endfor ~}

[all:vars]
ansible_ssh_private_key_file=${network}_key
ansible_user=root
network=${network}