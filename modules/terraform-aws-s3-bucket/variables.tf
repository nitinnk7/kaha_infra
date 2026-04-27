variable "bucket_name" {
  type = string
}

variable "purpose" {
  type    = string
  default = "general"
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "force_destroy" {
  type    = bool
  default = false
}

# Versioning
variable "enable_versioning" {
  type    = bool
  default = true
}

# Encryption
variable "sse_algorithm" {
  type    = string
  default = "AES256"
}

# Lifecycle
variable "enable_lifecycle" {
  type    = bool
  default = false
}

variable "lifecycle_transition_days" {
  type    = number
  default = 30
}

variable "lifecycle_storage_class" {
  type    = string
  default = "GLACIER"
}

variable "lifecycle_expiration_days" {
  type    = number
  default = 365
}

variable "noncurrent_days" {
  type    = number
  default = 90
}

# Logging
variable "enable_logging" {
  type    = bool
  default = false
}

variable "logging_bucket" {
  type    = string
  default = null
}

variable "logging_prefix" {
  type    = string
  default = null
}

# Policy
variable "attach_policy" {
  type    = bool
  default = false
}

variable "bucket_policy" {
  type    = string
  default = null
}