variable "create_droplet" {
  description = "Whether to create a new droplet or use existing"
  type        = bool
  default     = false
}

variable "droplet_name" {
  description = "Name of the droplet"
  type        = string
  default     = "tradeport-staging"
}

variable "do_token" {
  type        = string
  sensitive   = true
}

variable "ssh_key_id" {
  type        = string
}
