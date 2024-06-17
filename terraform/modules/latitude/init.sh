#!/bin/bash

export TF_VAR_latitude_auth_token=$(cat lat_token.txt)
export TF_VAR_plan="s2-small-x86"

# Fetch available regions for the specified TF_VAR_plan
regions=$(curl -s --request GET \
     --url "https://api.latitude.sh/plans?filter[slug]=${TF_VAR_plan}" \
     --header "Authorization: Bearer ${TF_VAR_latitude_auth_token}" \
     --header "accept: application/json")

export TF_VAR_site=$(echo $regions | jq -r '.data[0].attributes.regions[].locations.in_stock[]' | head -n 1)
echo "Using region $TF_VAR_site for plan $TF_VAR_plan"

# source set_site.sh
# https://docs.latitude.sh/reference/get-TF_VAR_plans