#!.venv/bin/python3
"""CLI entry point for CrowsNet infrastructure management."""

import sys
import click
from utilities.container import build_container, run_playbook
from utilities.terraform import build_terraform_container, run_terraform, deploy_vms


@click.group()
def cli():
    """CrowsNet infrastructure management CLI."""


@cli.command(context_settings={"ignore_unknown_options": True})
@click.option("--terraform", is_flag=True, help="Build the terraform container instead")
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def build(terraform, extra_args):
    """Build the ansible or terraform container."""
    args = list(extra_args) if extra_args else None
    if terraform:
        sys.exit(build_terraform_container(args))
    else:
        sys.exit(build_container(args))


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


@cli.command(context_settings={"ignore_unknown_options": True})
@click.argument("target", type=click.Choice(["prod", "stage", "all"]))
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def deploy(target, extra_args):
    """Deploy VMs (prod, stage, or all)."""
    sys.exit(deploy_vms(target, list(extra_args) if extra_args else None))


@cli.command(context_settings={"ignore_unknown_options": True})
@click.option("--env", default="proxmox/prod", help="Terraform environment path")
@click.argument("extra_args", nargs=-1, type=click.UNPROCESSED)
def terraform(env, extra_args):
    """Run terraform commands directly."""
    sys.exit(run_terraform(env, list(extra_args) if extra_args else None))


if __name__ == "__main__":
    cli()
