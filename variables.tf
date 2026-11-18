variable "vpclattice_services" {
  description = <<EOT
Map of vpclattice_services, attributes below
Required:
    - name
Optional:
    - auth_type
    - certificate_arn
    - custom_domain_name
    - idle_timeout_seconds
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    name                 = string
    auth_type            = optional(string)
    certificate_arn      = optional(string)
    custom_domain_name   = optional(string)
    idle_timeout_seconds = optional(number)
    region               = optional(string)
    tags                 = optional(map(string))
    tags_all             = optional(map(string))
  }))
  validation {
    condition = alltrue([
      for k, v in var.vpclattice_services : (
        v.custom_domain_name == null || (length(v.custom_domain_name) >= 3 && length(v.custom_domain_name) <= 255)
      )
    ])
    error_message = "must be between 3 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.vpclattice_services : (
        v.idle_timeout_seconds == null || (v.idle_timeout_seconds >= 60 && v.idle_timeout_seconds <= 600)
      )
    ])
    error_message = "must be between 60 and 600"
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

