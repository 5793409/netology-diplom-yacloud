variable "metadata" {
  type    = map(string)
  default = {}
}
# variable "default_account_id" {
#   type = string
# }


variable "cloud_id" {
  type = string
}
variable "folder_id" {
  type = string
}
variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "nat_internal_ip" {
  type    = string
  default = "10.0.100.250"
}

variable "default_region" {
  type    = string
  default = "ru-central1"
}



variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "service_account_key_file" {
  type = string
}

variable "s3storage_access_key" {
  type = string
}
variable "s3storage_secret_key" {
  type = string
}