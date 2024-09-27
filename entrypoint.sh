#!/bin/bash

ansible-playbook --vault-password-file vault.pass $@
