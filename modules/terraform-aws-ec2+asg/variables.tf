variable "name" {}
variable "vpc_id" {}
variable "subnets" { type = list(string) }

variable "ami" {}
variable "instance_type" {}

variable "user_data" {
  type    = string
  default = ""
}

variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}

variable "on_demand_base_capacity" {
  default = 2
}

variable "on_demand_percentage" {
  default = 0
}

variable "target_group_arns" {
  type    = list(string)
  default = []
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "ingress_rules" {
  type = list(object({
    port            = number
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
    description     = optional(string)
  }))

  validation {
    condition = alltrue([
      for rule in var.ingress_rules :
      !(try(rule.cidr_blocks != null, false) && try(rule.security_groups != null, false))
    ])
    error_message = "Cannot use both cidr_blocks and security_groups in same rule."
  }
}

variable "from_port" {
  type    = number
  default = 0
}

variable "to_port" {
  type    = number
  default = 0
}

variable "instance_types" {
  type = list(string)
}

variable "enable_cpu_scaling" {
  type    = bool
  default = false
}

variable "cpu_target_value" {
  description = "Target CPU utilization percentage"
  type        = number
  default     = 60
}

variable "enable_request_count" {
  description = "Enable request count based scaling"
  type        = bool
  default     = false
}

variable "request_count_target_value" {
  description = "Target request count per target"
  type        = number
  default     = 1000
}