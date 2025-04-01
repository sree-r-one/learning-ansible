variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh_key_id" {
  description = "ID of your uploaded SSH key in DigitalOcean"
  type        = string
}
