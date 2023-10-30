variable "name" {
  description = "The name of the organization"
  type        = string
}

variable "email" {
  description = "The admin email address of the organization"
  type        = string
}

variable "allow_force_delete_workspaces" {
  default     = false
  description = "Whether to allow force delete workspaces"
  type        = bool
}

variable "assessments_enforced" {
  default     = false
  description = "Whether to enforce policy checks for Terraform runs"
  type        = bool
}

variable "cost_estimation_enabled" {
  default     = false
  description = "Whether to allow cost estimation"
  type        = bool
}

variable "send_passing_statuses_for_untriggered_speculative_plans" {
  default     = false
  description = "Whether to send passing statuses for untriggered speculative plans"
  type        = bool
}

variable "session_remember_minutes" {
  default     = 20160
  description = "Session expiration in minutes"
  type        = number
}

variable "session_timeout_minutes" {
  default     = 20160
  description = "Session timeout after inactivity in minutes"
  type        = number
}

variable "collaborator_auth_policy" {
  default     = "password"
  description = "Authentication policy (password or two_factor_mandatory)"
  type        = string

  validation {
    condition     = contains(["password", "two_factor_mandatory"], var.collaborator_auth_policy)
    error_message = "value must be either password or two_factor_mandatory"
  }
}

variable "owners_team_saml_role_id" {
  default     = ""
  description = "The name of the owners team"
  type        = string
}

variable "members" {
  default     = []
  description = "A list of email addresses of organization members"
  type        = list(string)
}

variable "rotating_days" {
  default     = 30
  description = "Number of days to rotate the token"
  type        = number
}

variable "force_regenerate" {
  default     = false
  description = "Forces new token generation"
  type        = bool
}

variable "access_beta_tools" {
  default     = false
  description = "Whether to allow access to beta tools"
  type        = bool
}

variable "global_module_sharing" {
  default     = false
  description = "Whether to allow global module sharing"
  type        = bool
}

variable "module_sharing_consumer_organizations" {
  default     = []
  description = "Organization names to share modules with"
  type        = list(string)
}

variable "workspace_limit" {
  default     = 0
  description = "The maximum number of workspaces allowed in the organization"
  type        = number

  validation {
    condition     = var.workspace_limit >= 0
    error_message = "value must be greater than or equal to 0"
  }
}
