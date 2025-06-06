FROM docker.io/alpine:3.20.0

ENV ANSIBLE_VERSION=9.5.1-r0
ENV ANSIBLE_LINT_VERSION=24.5.0-r0

# Install dependencies
RUN apk update \
  && apk add --no-cache --progress python3 openssl \
  ca-certificates git openssh sshpass \
  && apk --update add --virtual build-dependencies \
  python3-dev py3-pip libffi-dev openssl-dev build-base bash \
  && rm -rf /var/cache/apk/*

# Install Ansible
RUN apk add ansible=${ANSIBLE_VERSION} \
  && apk add ansible-lint=${ANSIBLE_LINT_VERSION}

# Create ansible user and SSH key directory
RUN addgroup -S ansible && adduser -S ansible -G ansible \
  && mkdir -p /home/ansible/.ssh && chown ansible:ansible /home/ansible/.ssh \
  && chmod 0700 /home/ansible/.ssh

# Copy SSH keys to ansible .ssh directory
COPY ./ssh-keys/ansible_ed25519 /home/ansible/.ssh/id_ed25519
COPY ./ssh-keys/ansible_ed25519.pub /home/ansible/.ssh/id_ed25519.pub
COPY ./ssh-keys/azure_id_rsa /home/ansible/.ssh/id_rsa
COPY ./ssh-keys/azure_id_rsa.pub /home/ansible/.ssh/id_rsa.pub

# Set SSH key permissions
RUN chown ansible:ansible /home/ansible/.ssh/id_ed25519* \
  && chmod 600 /home/ansible/.ssh/id_ed25519 \
  && chmod 644 /home/ansible/.ssh/id_ed25519.pub \
  && chown ansible:ansible /home/ansible/.ssh/id_rsa* \
  && chmod 600 /home/ansible/.ssh/id_rsa \
  && chmod 644 /home/ansible/.ssh/id_rsa.pub

# Switch to ansible user
USER ansible

# Add ansible users local/bin to PATH
ENV PATH="$PATH:/home/ansible/.local/bin"

# Set ansible environment variables
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_PYTHON_INTERPRETER auto_silent

# Set 'entrypoint.sh' as the default entrypoint
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh"]

# Update podman collection (fix: nfs bind mount idempotency)
RUN ansible-galaxy collection install --upgrade containers.podman
