# Конфигурация для  инстансов
locals {
  master_instances = {
    "master-0" = {
      name      = "k8s-master-0"
      hostname  = "k8s-master-0"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-a.id
    }
    "master-1" = {
      name      = "k8s-master-1"
      hostname  = "k8s-master-1"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-b.id
    }
    "master-2" = {
      name      = "k8s-master-2"
      hostname  = "k8s-master-2"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-b.id
    }
  }

  worker_instances = {
    "worker-0" = {
      name      = "k8s-worker-0"
      hostname  = "k8s-worker-0"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-a.id
    }
    "worker-1" = {
      name      = "k8s-worker-1"
      hostname  = "k8s-worker-1"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-a.id
    }
    # "worker-2" = {
    #   name      = "k8s-worker-2"
    #   zone      = "ru-central1-a"
    #   subnet_id = yandex_vpc_subnet.subnet-a.id
    # }
    "worker-3" = {
      name      = "k8s-worker-3"
      hostname  = "k8s-worker-3"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-b.id
    }
    "worker-4" = {
      name      = "k8s-worker-4"
      hostname  = "k8s-worker-4"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-b.id
    }
    # "worker-5" = {
    #   name      = "k8s-worker-5"
    #   zone      = "ru-central1-d"
    #   subnet_id = yandex_vpc_subnet.subnet-d.id
    # }
  }
}