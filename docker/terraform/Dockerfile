FROM docker.io/hashicorp/terraform:1.7

# Copy all terraform code (built from project root context)
COPY terraform /terraform

# Copy tfvars to proxmox environments
COPY docker/terraform/terraform.tfvars /terraform/proxmox/prod/terraform.tfvars
COPY docker/terraform/terraform.tfvars /terraform/proxmox/stage/terraform.tfvars

WORKDIR /terraform

ENTRYPOINT ["terraform"]
