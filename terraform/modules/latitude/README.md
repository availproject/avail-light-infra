# latitude-deployment

the script init.sh can be used to fetch available regions for any given instance_type/plan

run `source init.sh` which will export the tf env vars used in this module. You might need to go on the console to get different plan options

to run terraform paste your `AWS credentials` for the tf state bucket to initialize and also run `export TF_VAR_latitude_auth_token=<>` 

run `terraform init` in the network folder or whereever this module is used

initialize module like below in deployment folder
```
module "bootnode" {
  source = "../../modules/latitude"
  site = "MIA"
}
```