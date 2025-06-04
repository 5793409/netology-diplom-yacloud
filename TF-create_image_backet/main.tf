
resource "yandex_storage_bucket" "public_image_bucket" {
  bucket = var.bucket_config.name
  acl    = var.bucket_config.access_level

  default_storage_class = var.bucket_config.storage_class
  max_size              = var.bucket_config.max_bucket_size


}

resource "yandex_storage_object" "image_object" {
  bucket = yandex_storage_bucket.public_image_bucket.bucket
  key    = var.bucket_config.uploaded_name
  source = var.bucket_config.image_path

}

 resource "yandex_storage_object" "image_object2" {
   bucket = yandex_storage_bucket.public_image_bucket.bucket
   key    = "puh.png"
   source = "puh.png"

 }
