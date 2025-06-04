# Создаём облачную сеть (VPC)
resource "yandex_vpc_network" "k8s_network" {
  name = "k8s-vpc-network"
}

# Создаём подсеть в зоне ru-central1-a
resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  network_id     = yandex_vpc_network.k8s_network.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.0.1.0/24"]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Создаём подсеть в зоне ru-central1-b
resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  network_id     = yandex_vpc_network.k8s_network.id
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Создаём подсеть в зоне ru-central1-c
resource "yandex_vpc_subnet" "subnet-d" {
  name           = "subnet-d"
  network_id     = yandex_vpc_network.k8s_network.id
  zone           = "ru-central1-d"
  v4_cidr_blocks = ["10.0.3.0/24"]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}


# Создаём NAT подсеть в зоне ru-central1-a
resource "yandex_vpc_subnet" "subnet-nat" {
  name           = "subnet-nat"
  network_id     = yandex_vpc_network.k8s_network.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.0.100.0/24"]

}


resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.k8s_network.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_internal_ip

  }
}

