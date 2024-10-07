resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.yml"
  content  = templatefile("${path.module}/../ansible/templates/inventory.tpl", {
    ec2_public_ips = output.ec2_public_ips
  })
}