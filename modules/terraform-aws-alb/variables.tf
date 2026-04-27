variable "name" {}
variable "vpc_id" {}
variable "subnets" { type = list(string) }

variable "target_port" {
  default = 80
}

variable "health_check_path" {
  default = "/"
}

variable "deregistration_delay" {
  default = 60
}

variable "enable_https" {
  default = false
}

variable "certificate_arn" {
  default = null
}

variable "enable_access_logs" {
  default = false
}

variable "log_bucket" {
  default = null
}

variable "enable_deletion_protection" {
  default = false
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "ingress_rules" {
  type = list(object({
    port        = number
    cidr_blocks = list(string)
  }))
  default = []
}