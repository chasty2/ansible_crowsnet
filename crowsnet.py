#!/home/chasty2/Documents/ansible_crowsnet/.venv/bin/python3
"""CLI entry point for CrowsNet infrastructure management."""

import sys
import click
from utilities.container import build_container, run_playbook


def playbook_options(func):
    """Common options for playbook commands."""
    func = click.option("--limit", "-l", help="Limit execution to specific host(s)")(
        func
    )
    func = click.option("--tags", "-t", help="Only run tasks with these tags")(func)
    func = click.option(
        "--check", "-C", is_flag=True, help="Run in check mode (dry-run)"
    )(func)
    return func


@click.group()
def cli():
    """CrowsNet infrastructure management CLI."""


@cli.command()
@click.argument("extra_args", nargs=-1)
def build(extra_args):
    """Build the ansible container."""
    sys.exit(build_container(list(extra_args) if extra_args else None))


@cli.command()
@click.argument("playbook")
@playbook_options
@click.argument("extra_args", nargs=-1)
def run(playbook, limit, tags, check, extra_args):
    """Run a custom ansible playbook."""
    sys.exit(
        run_playbook(
            playbook,
            limit=limit,
            tags=tags,
            check=check,
            extra_args=list(extra_args) if extra_args else None,
        )
    )


@cli.command()
@playbook_options
def site(limit, tags, check):
    """Run the full site deployment (site.yml)."""
    sys.exit(run_playbook("site.yml", limit=limit, tags=tags, check=check))


@cli.command()
@playbook_options
def physical(limit, tags, check):
    """Run physical hosts deployment (physical.yml)."""
    sys.exit(run_playbook("physical.yml", limit=limit, tags=tags, check=check))


@cli.command()
@playbook_options
def virtual(limit, tags, check):
    """Run virtual hosts deployment (virtual.yml)."""
    sys.exit(run_playbook("virtual.yml", limit=limit, tags=tags, check=check))


@cli.command()
@playbook_options
def update(limit, tags, check):
    """Update and reboot all VMs (update.yml)."""
    sys.exit(run_playbook("update.yml", limit=limit, tags=tags, check=check))


if __name__ == "__main__":
    cli()
