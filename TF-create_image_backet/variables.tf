variable "metadata" {
  type    = map(string)
  default = {}
}

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
variable "default_region" {
  type    = string
  default = "ru-central1"
}
variable "vpc_name" {
  type        = string
  default     = "my_vpc"
  description = "VPC name"
}
variable "public_cidr" {
  type    = list(string)
  default = ["192.168.10.0/24"]
}
variable "public_cidr_name" {
  type        = string
  default     = "public"
  description = "subnet name"
}


variable "service_account_key_file" {
  type = string
}


variable "bucket_config" {
  description = "bucket variables"
  type = object({
    name            = string
    access_level    = string
    storage_class   = string
    max_bucket_size = number
    link_access     = bool
    bucket_access   = bool
    uploaded_name   = string
    image_path      = string
  })
  default = {
    name            = "imagebacket"
    access_level    = "public-read"
    storage_class   = "STANDARD"
    max_bucket_size = 104857600
    link_access     = true
    bucket_access   = true
    uploaded_name   = "ded.jpg"
    image_path      = "ded.jpg"
  }
}


