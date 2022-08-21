FROM chasty2/ansible:5.1

# Copy SSH keys to ansible .ssh directory
COPY ./ssh-keys/ansible_ed25519 /home/ansible/.ssh/id_ed25519
COPY ./ssh-keys/ansible_ed25519.pub /home/ansible/.ssh/id_ed25519.pub

# Set SSH key permissions
RUN chown ansible:ansible /home/ansible/.ssh/id_ed25519* \
  && chmod 600 /home/ansible/.ssh/id_ed25519 \
  && chmod 644 /home/ansible/.ssh/id_ed25519.pub

# Switch to ansible user to run playbooks
USER ansible

# Set 'entrypoint.sh' as the default entrypoint
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash","/entrypoint.sh"]
