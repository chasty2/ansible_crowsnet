variable "vm_count" {
  type        = number
  description = "the number of virtual machines to create"
}

variable "subnet_id" {
  type        = string
  description = "ID of subnet the VM's will be created on"
}

variable "hostname_list" {
  type        = list(string)
  description = "a list of names, one for each VM being created"
}

variable "private_ip_list" {
  type        = list(string)
  description = "A list of private IP addresses, assigned to the host in hostname_list with the same index"
}

variable "location" {
  type        = string
  description = "datacenter to house the virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "AzureRM resource group this VM will be a part of"
}

variable "network_security_group_id" {
  type        = string
  description = "Network security group id to attach to each NIC"
}

variable "size" {
  type        = string
  description = "amount of resources allocated to virtual machine"
  default     = "Standard_D2ads_v6"
}

variable "username" {
  type        = string
  description = "local user that will be created on each VM"
  default     = "ansible"
}

variable "public_ssh_key" {
  type        = string
  description = "public SSH key to be used by the local admin user"
}

variable "storage_account" {
  type        = string
  description = "Storage account to hold boot diagnostics data"
}