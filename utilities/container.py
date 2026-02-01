"""Utilities for building and running the Ansible container."""

import subprocess
from pathlib import Path


PROJECT_ROOT = Path(__file__).parent.parent
DOCKER_DIR = PROJECT_ROOT / "docker"
ANSIBLE_DIR = PROJECT_ROOT / "ansible"
CONTAINER_NAME = "ansible-crowsnet"


def build_container(extra_args: list[str] | None = None) -> int:
    """Build the ansible container with podman.

    Args:
        extra_args: Additional arguments to pass to podman build.

    Returns:
        The return code from podman build.
    """
    cmd = ["podman", "build", ".", "-t", f"{CONTAINER_NAME}:latest"]
    if extra_args:
        cmd.extend(extra_args)

    result = subprocess.run(cmd, cwd=DOCKER_DIR, check=False)
    return result.returncode


def run_playbook(playbook: str, extra_args: list[str] | None = None) -> int:
    """Run an ansible playbook inside the container.

    Args:
        playbook: Path to the playbook file (relative to ansible directory).
        extra_args: Additional arguments to pass to ansible-playbook.

    Returns:
        The return code from podman run.
    """
    cmd = [
        "podman",
        "run",
        "-it",
        "--rm",
        "--network",
        "host",
        "--volume",
        f"{ANSIBLE_DIR}:/etc/ansible",
        "-w",
        "/etc/ansible",
        CONTAINER_NAME,
        playbook,
    ]

    if extra_args:
        cmd.extend(extra_args)

    result = subprocess.run(cmd, check=False)
    return result.returncode
