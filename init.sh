#!/bin/bash


export TF_VAR_service_account_key_file=$(cat "authorized_key.json")
export TF_VAR_cloud_id=""
export TF_VAR_folder_id=""
export TF_VAR_s3storage_access_key="" 
export TF_VAR_s3storage_secret_key="" 

terraform init -reconfigure -backend-config "access_key=$TF_VAR_s3storage_access_key" -backend-config "secret_key=$TF_VAR_s3storage_secret_key"
