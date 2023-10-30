output "id" {
  description = "The name of the organization"
  value       = tfe_organization.org.id
}

output "members" {
  description = "Organization members"
  value       = tfe_organization_membership.members
}

output "token" {
  description = "Organizational token"
  sensitive   = true
  value       = tfe_organization_token.token.token
}
