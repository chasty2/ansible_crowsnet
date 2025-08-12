#!/bin/bash

# Backup file system to Proxmox Backup Server using proxmox-backup-client
# Written by Cody Hasty
#
# Usage: backup.sh namespace file_system
proxmox-backup-client backup $1.pxar:$2 --repository root@pam@192.168.4.12:backup --ns $1