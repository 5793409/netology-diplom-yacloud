terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net" # ← Полный URL с https://
    }
    bucket = "kovtykh-tf-state"
    key    = "diplom/terraform_k8s.tfstate"
    region = "ru-central1"



    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}

