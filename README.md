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

Make sure to have these in your env
```
AVAIL_LIGHT_VERSION=avail-light-client-v1.12.0-rc1
FATCLIENT_VERSION=avail-light-fat-v1.12.0-rc4
BOOTNODE_VERSION=avail-light-bootstrap-v0.3.0-rc2
DATADOG_API_KEY=<>
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

### Troubleshooting
If you run into the error below during a `terraform init`:

```
https://www.terraform.io/docs/cli/plugins/signing.html
╷
│ Error: Incompatible provider version
│ 
│ Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.
│ 
│ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have different platforms supported.
╵
```

This is because you're probably running an M1 chip, run this 
```
brew uninstall terraform
brew install tfenv
TFENV_ARCH=amd64 tfenv install 1.7.0
tfenv use 1.7.0
terraform init
```