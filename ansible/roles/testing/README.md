# Testing Role

Installs VirtualBox and Vagrant for molecule testing infrastructure.

## Requirements

- Debian/Ubuntu-based system
- Sufficient disk space for VirtualBox VMs

## Role Variables

Variables defined in `vars/main.yml`:

| Variable | Description | Default |
|----------|-------------|---------|
| `testing_packages` | Packages to install | `[virtualbox, vagrant]` |

## Tags

- `packages` - Install VirtualBox and Vagrant

## Example Playbook

```yaml
- hosts: testing_server
  roles:
    - testing
```

Run with specific tags:

```bash
ansible-playbook physical.yml --tags packages
```
