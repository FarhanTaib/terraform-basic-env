#cloud-config
write_files:
- path: /tmp/apache.sh
  content: |
    #!/bin/bash
    sudo yum clean all
    sudo yum makecache fast
    sudo yum -y install httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Deployed via Terraform. From Server:</h1>" | sudo tee /var/www/html/index.html
    hostname | sudo tee -a /var/www/html/index.html
runcmd:
- ["bash", "/tmp/apache.sh"]