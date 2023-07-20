#!/bin/bash

## script to run ansible container with a given playbook
## Written by Cody Hasty

# Example use: ./run_ansible.sh playbook.yml [--tags tag_name]

#
## Arguments to podman
#
# -it							            interactive mode 
# --rm							            delete container after use
# --network host					        use IP address of host VM
#--volume PATH/configs:/etc/ansible 		point /etc/ansible in container to configs directory in host
# -w /etc/ansible 					        set /etc/ansible as working directory inside container
# ansible_crowsnet					        specify container
# $@ 							            specify a playbook at command line when running this script (and optionally tags, etc)           

podman run -it --rm --network host --volume /home/chasty2/ansible_crowsnet/configs:/etc/ansible -w /etc/ansible ansible-crowsnet $@
