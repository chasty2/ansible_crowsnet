Role Name
=========

Configure Proxmox Backup Server

Requirements
------------

- Host is running firewalld (installed in common role)
- Host is running Proxmox Backup Server

Role Variables
--------------

backup_permitted_ports: List of ports to open on firewalld


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: lab
      roles:
         - common
         - pbs

License
-------

GPL 3.0

Author Information
------------------

Cody Hasty