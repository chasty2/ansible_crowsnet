#!/bin/bash

## script to build ansible container with tag 'latest'
## Written by Cody Hasty

# Example use: ./build-ansible.sh [-t ansible-crowsnet:version_number]

#
## Arguments to podman
#
# .							                specify Dockerfile in working directory 
# -t container_name:tag					    name and tag container
# $@                                        (optional) specify additional tags

podman build . -t ansible-crowsnet:latest $@