#Set your public SSH key here
# variable "ssh_key" {
#   default = "your_public_ssh_key_here"
# }

#Provide the url of the host you would like the API to communicate on.
#It is safe to default to setting this as the URL for what you used
#as your `proxmox_host`, although they can be different
variable "api_url" {
    default = "https://192.168.4.11:8006/api2/json"
}

#Blank var for use by terraform.tfvars
variable "token_secret" {
}

#Blank var for use by terraform.tfvars
variable "token_id" {
}