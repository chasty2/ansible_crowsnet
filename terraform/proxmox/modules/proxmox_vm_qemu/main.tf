terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

resource "proxmox_vm_qemu" "virtual_machine" {
  name = var.name
  target_node = var.proxmox_host

  # Establishes how many instances will be created
  count = 1

  # Image to clone VM from
  clone = var.template_name

  # Creates a full clone, rather than linked clone 
  # https://pve.proxmox.com/wiki/VM_Templates_and_Clones
  full_clone  = "true"

  # VM Settings. `agent = 1` enables qemu-guest-agent
  os_type = "cloud_init"
  agent = 1
  cores = var.cores
  sockets = 1
  memory = var.memory
  vmid = var.vmid
  scsihw = "virtio-scsi-single"
  ipconfig0 = var.ip_config

  disk {
    slot = "scsi0"
    type = "disk"
    # Name of storage local to the host you are spinning the VM up on
    storage = var.storage_pool
    # Disk size of new VM (image is currently 32GB with LVM setup)
    size = var.template_disk_size
  }

  network {
    model = "virtio"
    bridge = var.nic_name
    # MAC-associated IP address
    macaddr = var.macaddr
    # tag = var.vlan_num
  }
}