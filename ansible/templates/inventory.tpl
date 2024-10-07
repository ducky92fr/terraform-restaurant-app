all:
  hosts:
%{ for name, ip in ec2_public_ips ~}
    ${name}:
      ansible_host: ${ip}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/.ssh/your_key.pem
%{ endfor ~}