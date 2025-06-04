resource "local_file" "inventory_cfg" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      master = yandex_compute_instance.master,
      worker = yandex_compute_instance.workers,

      bastion = length(yandex_compute_instance.bastion) > 0 ? [yandex_compute_instance.bastion] : []
    }
  )

  filename = "${abspath(path.module)}/hosts.txt"
}


resource "local_file" "inventory_cfg_kubespray" {
  content = templatefile("${path.module}/inventory_kubespray.tftpl",
    {
      master = yandex_compute_instance.master,
      worker = yandex_compute_instance.workers,

      bastion = length(yandex_compute_instance.bastion) > 0 ? [yandex_compute_instance.bastion] : []
    }
  )

  filename = "${abspath(path.module)}/hosts_kubespray.txt"
}

resource "null_resource" "hosts_provision" {
  #Ждем создания инстанса
  depends_on = [
    yandex_compute_instance.master,
    yandex_compute_instance.workers,
    yandex_compute_instance.bastion,
    local_file.inventory_cfg
  ]


  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent

  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && cat ~/.ssh/yandex_cloud_nk3409_ed25519 | ssh-add -"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок

  }



  #Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # В случае использования cloud-init может потребоваться еще больше времени
  provisioner "local-exec" {
    command = "sleep 60"
  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook ${abspath(path.module)}/playbook.yaml -i ${abspath(path.module)}/hosts.txt "
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    #всегда т.к. дата и время постоянно изменяются
    always_run = "${timestamp()}"
    # при изменении содержимого playbook файла
    # playbook_src_hash = file("${abspath(path.module)}/playbook.yml")
    # ssh_public_key = local.vms_ssh_root_key } # при изменении переменной
  }

}

