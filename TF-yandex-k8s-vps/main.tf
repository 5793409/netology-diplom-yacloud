
data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init/cloud-init.yaml")
  vars = {
    vms_ssh_root_key = var.vms_ssh_root_key
  }
}