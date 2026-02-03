#!.venv/bin/python3
"""CLI entry point for CrowsNet infrastructure management."""

import sys
import click
from utilities.container import build_container, run_playbook


@click.group()
def cli():
    """CrowsNet infrastructure management CLI."""


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def build(extra_args):
    """Build the ansible container."""
    sys.exit(build_container(list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("playbook")
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def run(playbook, extra_args):
    """Run a custom ansible playbook."""
    sys.exit(run_playbook(playbook, list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def site(extra_args):
    """Run the full site deployment (site.yml)."""
    sys.exit(run_playbook("site.yml", list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def physical(extra_args):
    """Run physical hosts deployment (physical.yml)."""
    sys.exit(run_playbook("physical.yml", list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def virtual(extra_args):
    """Run virtual hosts deployment (virtual.yml)."""
    sys.exit(run_playbook("virtual.yml", list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def update(extra_args):
    """Update and reboot all VMs (update.yml)."""
    sys.exit(run_playbook("update.yml", list(extra_args) if extra_args else None))


if __name__ == "__main__":
    cli()
