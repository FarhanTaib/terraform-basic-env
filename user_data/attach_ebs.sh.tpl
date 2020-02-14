#cloud-config
write_files:
- path: /tmp/attach_ebs.sh
  content: |
    #!/bin/bash
    sudo mkfs -t xfs ${ebs_block_device}
    sudo mount ${ebs_block_device} /data
    sudo echo "${ebs_block_device}  /data xfs defaults,nofail 0 2" >> /etc/fstab
runcmd:
- ["bash", "/tmp/attach_ebs.sh"]