resource "yandex_storage_bucket" "s3_bucket" {
  bucket     = var.bucket_config.name
  acl        = var.bucket_config.access_level
  access_key = yandex_iam_service_account_static_access_key.tf_sa_s3_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.tf_sa_s3_key.secret_key

  default_storage_class = var.bucket_config.storage_class
  max_size              = var.bucket_config.max_bucket_size
  depends_on            = [yandex_resourcemanager_folder_iam_binding.tf_admin]
}

