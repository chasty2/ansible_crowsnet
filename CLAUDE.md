# Project Guidelines

## Project Overview
- **Name**: CrowsNet
- **Purpose**: Self-hosted homelab, runs entirely out of infrastructure-as-code
- **Stack**: Python (uv), Ansible, Podman


## Commands (TODO)


## Directory Structure
ansible_crowsnet/
├── ansible/            # Configures servers and containers
├── docker/             # Infrastructure-related containers built via Podman


## Core Principles

1. **Simplicity over cleverness** - Write code that's immediately understandable
2. **Leverage existing solutions** - Use standard libraries, don't reinvent
3. **Single responsibility** - Functions do one thing, under 50 lines
4. **Early returns** - Guard clauses over nested conditionals
5. **Match existing patterns** - Follow the file's conventions exactly


## Before You Start

| File | When to Read |
|------|--------------|
| ansible/CLAUDE.md | Writing new Ansible and Ansible-related code |
