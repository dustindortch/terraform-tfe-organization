variable "organizations" {
  description = "A list of organizations to create"
  type = map(object({
    email                    = string
    owners_team_saml_role_id = optional(string)
  }))
}
