# Ansible Homelab Project Memory

## Project Overview
This is an Ansible codebase for managing a homelab environment. The ansible directory is attached to a container that runs ansible to configure the homelab infrastructure.

## Ansible Role Structure Standards

All Ansible roles in this project follow a standardized 5-task organization pattern:

### Task Organization
Each role splits tasks into up to 5 standardized task files, each with a specific tag:

1. **`users.yml`** - `tags: users` - User/group management, SSH keys, sudo configuration
2. **`system.yml`** - `tags: system` - System-level configuration (hostname, etc.)  
3. **`packages.yml`** - `tags: packages` - Package installation/removal
4. **`services.yml`** - `tags: services` - Service management (start/stop/enable)
5. **`firewalld.yml`** - `tags: firewall` - Firewall configuration

### Key Patterns
- `tasks/main.yml` includes each task file with `ansible.builtin.include_tasks` and assigns the corresponding tag
- Roles don't need to implement all 5 files - only what's needed
- Tags enable selective execution (e.g., `ansible-playbook --tags users,firewall`)
- Individual task files use `block:` structure to ensure tags are properly applied to all tasks
- Ensures consistent organization across all roles in the homelab

### Standard Role Structure
```
role_name/
├── tasks/
│   ├── main.yml          # Entry point with includes and tags
│   ├── users.yml         # User management tasks
│   ├── system.yml        # System configuration tasks
│   ├── packages.yml      # Package management tasks
│   ├── services.yml      # Service management tasks
│   └── firewalld.yml     # Firewall configuration tasks
├── vars/main.yml         # Role variables
├── handlers/main.yml     # Event handlers
├── templates/            # Jinja2 templates
└── files/               # Static files
```

This standardization allows predictable role structure and granular control over which aspects of configuration to apply during playbook runs.