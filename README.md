# avail-light-infra

Paste AWS credentials for Avail Mainnet account into terminal


cd into the terraform deployment folder for the environment/network
```
cd terraform/deployment/<network>
```

Run terraform apply, which will create the inventory file and ssh key for the network in ansible folder

```
terraform apply
```

Open another terminal and cd into ansible folder for ansible changes
```
cd ansible && chmod 0600 <network>_key
```

Try to ping the hosts in the inventory

```
ansible all -m ping -i inventory/<network>.ini
```

Run playbook
```
ansible-playbook playbook.yml -i inventory/<network>.ini
```
