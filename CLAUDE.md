# Project Guidelines

## Project Overview
- **Name**: CrowsNet
- **Purpose**: Self-hosted homelab, runs entirely out of infrastructure-as-code
- **Stack**: Python (uv), Ansible, Podman


## Commands

```bash
# Build the ansible container
./crowsnet.py build
uv run crowsnet build

# Run full site deployment
./crowsnet.py site
uv run crowsnet site

# Run physical hosts only
./crowsnet.py physical
uv run crowsnet physical

# Run virtual hosts only
./crowsnet.py virtual
uv run crowsnet virtual

# Update and reboot all VMs
./crowsnet.py update
uv run crowsnet update

# Run a custom playbook
./crowsnet.py run <playbook>
uv run crowsnet run <playbook>
```

### Common Options
| Option | Description |
|--------|-------------|
| `--limit`, `-l` | Limit execution to specific host(s) |
| `--tags`, `-t` | Only run tasks with these tags |
| `--check`, `-C` | Dry-run mode (no changes) |
| `--diff`, `-D` | Show file differences |

## Workflow Patterns (TODO after implementing molecule testing)

## Directory Structure
```
ansible_crowsnet/
├── ansible/            # Configures servers and containers
├── docker/             # Container definition and legacy scripts
├── utilities/          # Python utilities for container operations
└── crowsnet.py         # CLI entry point for all operations
```


## Core Principles

1. **Simplicity over cleverness** - Write code that's immediately understandable
2. **Leverage existing solutions** - Use standard libraries, don't reinvent
3. **Single responsibility** - Functions do one thing, under 50 lines
4. **Early returns** - Guard clauses over nested conditionals
5. **Match existing patterns** - Follow the file's conventions exactly


## Git Conventions

- All work should be done in a branch outside of main
- Commit early and often, after each meaningful change


## Before You Start

| File | When to Read |
|------|--------------|
| ansible/CLAUDE.md | Writing new Ansible and Ansible-related code |
