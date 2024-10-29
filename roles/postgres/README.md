Role Name
=========

Manage a postgres database server in a container with podman

Role Variables
--------------

- postgres_ports
- postgres_users
- postgres_password

Dependencies
------------

- podman role

Example Playbook
----------------

    - hosts: database_servers
      roles:
         - postgres
