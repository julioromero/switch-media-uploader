variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "gcp_region_1" {
  type        = string
  description = "GCP Region"
}

# define GCP zone
variable "gcp_zone_1" {
  type        = string
  description = "GCP Zone"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

#app specific variables
variable "token_value" {
    type    = string
    description = "Telegram bot token value"
}

variable "chat_value" {
    type    = string
    description = "Telegram chat id value"
}