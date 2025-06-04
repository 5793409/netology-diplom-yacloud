resource "yandex_iam_service_account" "tf_sa" {
  name        = "tf-s3-sa" # Имя сервисного аккаунта
  description = "Service account for Terraform S3 backend"
}

# Назначаем роль "storage.admin" на каталог 
resource "yandex_resourcemanager_folder_iam_binding" "tf_admin" {
  folder_id = var.folder_id   # ID вашего каталога в Yandex Cloud
  role      = "storage.admin" # Роль для работы с Object Storage
  members = [
    "serviceAccount:${yandex_iam_service_account.tf_sa.id}",
  ]
}

# Создаем статические ключи доступа (для S3)
resource "yandex_iam_service_account_static_access_key" "tf_sa_s3_key" {
  service_account_id = yandex_iam_service_account.tf_sa.id
  description        = "Static access key for S3"
}

# Выводим ключи (осторожно, они чувствительные!)
output "s3_access_key" {
  value     = yandex_iam_service_account_static_access_key.tf_sa_s3_key.access_key
  sensitive = true
}

output "s3_secret_key" {
  value     = yandex_iam_service_account_static_access_key.tf_sa_s3_key.secret_key
  sensitive = true
}