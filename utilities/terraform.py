"""Utilities for building and running the Terraform container."""

import subprocess
from pathlib import Path


PROJECT_ROOT = Path(__file__).parent.parent
TERRAFORM_DIR = PROJECT_ROOT / "terraform"
DOCKER_TERRAFORM_DIR = PROJECT_ROOT / "docker" / "terraform"
CONTAINER_NAME = "terraform-crowsnet"


def build_terraform_container(extra_args: list[str] | None = None) -> int:
    """Build the terraform container with podman.

    Args:
        extra_args: Additional arguments to pass to podman build.

    Returns:
        The return code from podman build.
    """
    cmd = [
        "podman",
        "build",
        "-f",
        str(DOCKER_TERRAFORM_DIR / "Dockerfile"),
        "-t",
        f"{CONTAINER_NAME}:latest",
        ".",
    ]
    if extra_args:
        cmd.extend(extra_args)

    result = subprocess.run(cmd, cwd=PROJECT_ROOT, check=False)
    return result.returncode


def run_terraform(environment: str, args: list[str] | None = None) -> int:
    """Run terraform in the container.

    Args:
        environment: The terraform environment path (e.g., 'proxmox/prod').
        args: Terraform arguments to pass.

    Returns:
        The return code from podman run.
    """
    workdir = f"/terraform/{environment}"
    cmd = [
        "podman",
        "run",
        "-it",
        "--rm",
        "-w",
        workdir,
        CONTAINER_NAME,
    ]
    if args:
        cmd.extend(args)

    result = subprocess.run(cmd, check=False)
    return result.returncode


def deploy_vms(target: str, extra_args: list[str] | None = None) -> int:
    """Deploy VMs for the specified target.

    Args:
        target: One of 'prod', 'stage', or 'all'.
        extra_args: Additional arguments to pass to terraform apply.

    Returns:
        The return code from the deployment.
    """
    environments = []
    if target == "all":
        environments = ["proxmox/stage", "proxmox/prod"]
    elif target == "prod":
        environments = ["proxmox/prod"]
    elif target == "stage":
        environments = ["proxmox/stage"]
    else:
        print(f"Unknown target: {target}")
        return 1

    for env in environments:
        print(f"Deploying {env}...")

        # Build apply command with extra args
        apply_cmd = "terraform apply -auto-approve"
        if extra_args:
            apply_cmd += " " + " ".join(extra_args)

        # Run init and apply in same container (init creates .terraform/ state)
        workdir = f"/terraform/{env}"
        cmd = [
            "podman",
            "run",
            "-it",
            "--rm",
            "-w",
            workdir,
            "--entrypoint",
            "/bin/sh",
            CONTAINER_NAME,
            "-c",
            f"terraform init && {apply_cmd}",
        ]

        result = subprocess.run(cmd, check=False)
        if result.returncode != 0:
            return result.returncode

    return 0
