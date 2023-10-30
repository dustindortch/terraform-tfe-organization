output "id" {
  description = "The name of the organization"
  value       = tfe_organization.org.id
}

output "usernames" {
  description = "Usernames of organization members"
  value       = tfe_organization_membership.members[*].username
}

output "user_ids" {
  description = "User IDs of organization members"
  value       = tfe_organization_membership.members[*].user_id
}

output "token" {
  description = "Organizational token"
  sensitive   = true
  value       = tfe_organization_token.token.token
}
