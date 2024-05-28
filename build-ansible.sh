#!/bin/bash

## script to build ansible container with tag 'latest'
## Written by Cody Hasty

# Example use: ./build-ansible.sh

#
## Arguments to podman
#
# .							                specify Dockerfile in working directory 
# -t container_name:tag					    name and tag container

podman build . -t ansible-crowsnet:latest