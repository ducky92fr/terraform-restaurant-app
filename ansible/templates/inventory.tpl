all:
  hosts:
%{ for name, info in ec2_ips ~}
%{ if info.subnet_type == "public" }
    ${name}:
      ansible_host: ${info.public_ip}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/your_key.pem
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
%{ else }
    ${name}:
      ansible_host: ${info.private_ip}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/your_key.pem
      ansible_ssh_common_args: '-o ProxyJump=my-haproxy StrictHostKeyChecking=no'
%{ endif ~}
%{ endfor ~}