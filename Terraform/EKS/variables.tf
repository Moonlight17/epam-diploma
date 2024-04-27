variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}
variable "profile" {
  default     = "dev-backup"
  description = "AWS Profile"
}

variable "min_size" {
  default     = 1
  description = "min_size eks"
}

variable "max_size" {
  default     = 5
  description = "max_size eks"
}

variable "kubernetes_version" {
  default     = 5
  description = "max_size eks"
}
