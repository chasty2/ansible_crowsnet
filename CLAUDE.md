# Project Guidelines

## Project Overview
- **Name**: CrowsNet
- **Purpose**: Self-hosted homelab, runs entirely out of infrastructure-as-code
- **Stack**: Python (uv), Ansible, Podman


## Commands

```bash
./crowsnet.py build              # Build the ansible container
./crowsnet.py site               # Run full site deployment
./crowsnet.py physical           # Run physical hosts only
./crowsnet.py virtual            # Run virtual hosts only
./crowsnet.py update             # Update and reboot all VMs
./crowsnet.py run <playbook>     # Run a custom playbook
```

### Common Options
| Option | Description |
|--------|-------------|
| `--limit`, `-l` | Limit execution to specific host(s) |
| `--tags`, `-t` | Only run tasks with these tags |
| `--check`, `-C` | Dry-run mode (no changes) |

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

1. **Start by forming a plan** - Do not begin work until I approve your plan
2. **Simplicity over cleverness** - Write code that's immediately understandable
3. **Leverage existing solutions** - Use standard libraries, don't reinvent
4. **Single responsibility** - Functions do one thing, under 50 lines
5. **Early returns** - Guard clauses over nested conditionals
6. **Match existing patterns** - Follow the file's conventions exactly


## Git Conventions

- All work should be done in a branch outside of main
- Each goal should be accomplished in its own branch
- Commit early and often, after each meaningful change
- When done, check in with the user for approval
- Submit a PR to merge into main with a semantic tag in the title (e.g., `feat:`, `fix:`, `refactor:`, `docs:`)


## Before You Start

| File | When to Read |
|------|--------------|
| ansible/CLAUDE.md | Writing new Ansible and Ansible-related code |
