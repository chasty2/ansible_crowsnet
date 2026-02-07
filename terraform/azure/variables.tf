variable "internal_vm_names" {
  type        = list(string)
  description = "Array of names of internal virtual machines"
  default     = ["web", "nfs"]
}

variable "internal_private_ips" {
  type        = list(string)
  description = "Array of private IP addresses of internal virtual machines"
  default     = ["192.168.4.125", "192.168.4.11"]
}

variable "public_vm_names" {
  type        = list(string)
  description = "Array of names of public virtual machines"
  default     = ["gate"]
}

variable "public_private_ips" {
  type        = list(string)
  description = "Array of private IP addresses of public virtual machines"
  default     = ["192.168.4.100"]
}

variable "public_ssh_key" {
  description = "SSH key of 'ansible' user"
}

variable "builder_public_ip" {
  description = "IP address of machine running Ansible to configure VM's"
}