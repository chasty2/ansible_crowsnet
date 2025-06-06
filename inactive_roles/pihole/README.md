pihole
=========

Implement a pihole DNS/DHCP server via podman

Requirements
------------

This role assumes it is running on a recent version of Ubuntu LTS

Role Variables
--------------

- pihole_ports
- pihole_users
- pihole_web_password

Dependencies
------------

This role depends on the following:
- common (create podman user)
- podman (enable podman user to run containers without root access)

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: dns_server
      roles:
         - pihole
