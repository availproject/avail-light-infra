#!/bin/bash

export TOKEN=$(cat lat_token.txt)
export PLAN="m4-metal-medium"

# Fetch available regions for the specified plan
regions=$(curl -s --request GET \
     --url "https://api.latitude.sh/plans?filter[slug]=${PLAN}" \
     --header "Authorization: Bearer ${TOKEN}" \
     --header "accept: application/json")

echo $regions | jq -r '.data[0].attributes.regions[].locations.in_stock[]'
export TF_VAR_site=$(echo $regions | jq -r '.data[0].attributes.regions[].locations.in_stock[]' | head -n 1)

echo "Using region $TF_VAR_site for plan $PLAN"

# source set_site.sh
# https://docs.latitude.sh/reference/get-plans