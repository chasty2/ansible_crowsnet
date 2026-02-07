terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  # References our vars.tf file to plug in the api_url 
  pm_api_url = var.api_url
  # References our secrets.tfvars file to plug in our token_id
  pm_api_token_id = var.token_id
  # References our secrets.tfvars to plug in our token_secret 
  pm_api_token_secret = var.token_secret
  # Default to `true` unless you have TLS working within your pve setup 
  pm_tls_insecure = true
}

module "gate" {
  source = "../modules/proxmox_vm_qemu"
  name = "gate"
  vmid = 100
  ip_config = "ip=192.168.4.100/22,gw=192.168.4.1"
  macaddr = "82:08:61:78:5A:6C"
  cores = 2
  memory = 4096
}

module "proxy" {
  source = "../modules/proxmox_vm_qemu"
  name = "proxy"
  vmid = 101
  ip_config = "ip=192.168.4.101/22,gw=192.168.4.1"
  macaddr = "BC:24:11:88:D8:67"
  cores = 2
  memory = 8192
}

module "bailey" {
  source = "../modules/proxmox_vm_qemu"
  name = "bailey"
  vmid = 125
  ip_config = "ip=192.168.4.125/22,gw=192.168.4.1"
  macaddr = "02:26:85:4A:AC:52"
  cores = 4
  memory = 12288
}

module "kube-1" {
  source = "../modules/proxmox_vm_qemu"
  template_name = "template-ubuntu24-large"
  template_disk_size = 130
  name = "kube-1"
  vmid = 126
  ip_config = "ip=192.168.4.126/22,gw=192.168.4.1"
  macaddr = "BC:24:11:91:7B:19"
  cores = 2
  memory = 8192
}