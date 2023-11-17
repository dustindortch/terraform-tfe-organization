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

output "agent_pools" {
  description = "self-hosted agent pools"
  value       = tfe_agent_pool.pools
}

output "workspaces" {
  description = "Workspaces in the organization"
  value       = data.tfe_workspace_ids.all
}

output "all_workspace_ids" {
  description = "value of all_workspace_ids"
  value       = values(data.tfe_workspace_ids.all.ids)
}

output "agent_tokens" {
  description = "agent tokens"
  value       = tfe_agent_token.tokens
}
