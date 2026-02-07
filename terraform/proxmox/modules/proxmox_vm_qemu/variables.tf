# Name of the VM
variable "name" {
}

# Virtual Machine ID, must be unique
variable "vmid" {
}

#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
    default = "esper"
}

# Specify which template name you'd like to use
variable "template_name" {
    default = "template-ubuntu24-small"
}

# The Ubuntu24 template has a default size of 36GB
variable "template_disk_size" {
    default = "36G"
}

# Specify which storage pool to use
variable "storage_pool" {
    default = "ssd_mirror"
}

# Specify the number of vCPU cores
variable "cores" {
    default = 1
}

# Specify the amount of RAM (in MiB)
variable "memory" {
    default = 4096
}

# Specify IP address to configure with cloud_init
#
# Format: "ip=10.10.10.10/24,gw=10.10.10.1"
variable "ip_config" {
}

#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr0"
}

# Specify MAC address (fixed IP's are assigned via DHCP)
variable macaddr {
}

#Establish the VLAN you'd like to use
# variable "vlan_num" {
#     default = "place_vlan_number_here"
# }