variable "metadata" {
  type    = map(string)
  default = {}
}
variable "default_account_id" {
  type = string
}

variable "service_account_key_file" {
  type = string
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



variable "bucket_config" {
  description = "bucket variables"
  type = object({
    name            = string
    access_level    = string
    storage_class   = string
    max_bucket_size = number
    link_access     = bool
    bucket_access   = bool
    # uploaded_name   = string
    # image_path      = string
  })
  default = {
    name         = "kovtykh-tf-state"
    access_level = "private"
    # access_level = "custom"

    storage_class   = "STANDARD"
    max_bucket_size = 104857600
    link_access     = false
    bucket_access   = false
  }
}



variable "kms_key_name" {
  default     = "s3-bucket-key"
  description = "kms-key name"
}

variable "kms_key_algorithm" {
  default     = "AES_256"
  description = "kms-key algorithm"
}

variable "kms_key_expiration" {
  default     = "8760h"
  description = "kms-key expiration"
}

variable "sse_algorithm" {
  default     = "aws:kms"
  description = "sse algorithm"
}