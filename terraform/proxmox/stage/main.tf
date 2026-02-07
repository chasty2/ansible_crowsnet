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

module "lab" {
  source = "../modules/proxmox_vm_qemu"
  name = "lab"
  vmid = 200
  ip_config = "ip=192.168.4.200/22,gw=192.168.4.1"
  macaddr = "CA:9B:F1:85:90:C0"
  cores = 2
}
