variable "resource_group_name" {
  default = "terraform-learning-rg"
}

variable "location" {
  default = "West Europe"
}

variable "acr_name" {
  default = "terraformlearning"
}

variable "subscription_id" {
  description = "Your Azure subscription ID"
}

variable "create_acr" {
  description = "Whether to create the ACR (true) or use existing (false)"
  type        = bool
  default     = false
}
