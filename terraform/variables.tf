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

variable "create_plan" {
  description = "Whether to create the App Service Plan (true) or use existing (false)"
  type        = bool
  default     = false
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "container-app-plan"
}

variable "create_frontend" {
  description = "Whether to create the frontend App Service"
  type        = bool
  default     = false
}

variable "create_backend" {
  description = "Whether to create the backend App Service"
  type        = bool
  default     = false
}

