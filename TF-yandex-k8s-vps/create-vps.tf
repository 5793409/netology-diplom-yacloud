
resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  hostname    = "bastionhost"
  platform_id = "standard-v3"
  zone        = yandex_vpc_subnet.subnet-nat.zone


  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20

  }

  boot_disk {
    initialize_params {
      image_id = "fd800get7gv0beer0atg" // nat-instance-ubuntu-1804-lts
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-nat.id
    ip_address = var.nat_internal_ip
    nat        = true
    ipv6       = false
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true # Включаем режим прерываемой ВМ
  }
}



# Создаем master инстансы
resource "yandex_compute_instance" "master" {
  for_each = local.master_instances

  name        = each.value.name
  hostname    = each.value.hostname
  zone        = each.value.zone
  platform_id = "standard-v3"


  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80qe8ave6osk8onsqp" # fedora-37-v20250505 
      size     = 15
    }
  }

  network_interface {
    subnet_id          = each.value.subnet_id
    nat                = false
    ipv6               = false
    security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true # Включаем режим прерываемой ВМ
  }
}

# Создаем worker инстансы
resource "yandex_compute_instance" "workers" {
  for_each = local.worker_instances

  name        = each.value.name
  hostname    = each.value.hostname
  zone        = each.value.zone
  platform_id = "standard-v3"


  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80qe8ave6osk8onsqp" # fedora-37-v20250505 
      size     = 15
    }
  }

  network_interface {
    subnet_id          = each.value.subnet_id
    nat                = false
    ipv6               = false
    security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true # Включаем режим прерываемой ВМ
  }
}

