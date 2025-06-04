output "file_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.public_image_bucket.bucket}/${yandex_storage_object.image_object.key}"
}