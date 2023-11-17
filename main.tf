terraform {
  required_version = "~> 1.6"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.49.2, < 1.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1, < 1.0.0"
    }
  }
}

resource "tfe_organization" "org" {
  name  = var.name
  email = var.email

  allow_force_delete_workspaces                           = var.allow_force_delete_workspaces
  assessments_enforced                                    = var.assessments_enforced
  cost_estimation_enabled                                 = var.cost_estimation_enabled
  send_passing_statuses_for_untriggered_speculative_plans = var.send_passing_statuses_for_untriggered_speculative_plans

  collaborator_auth_policy = var.collaborator_auth_policy
  owners_team_saml_role_id = var.owners_team_saml_role_id
  session_remember_minutes = var.session_remember_minutes
  session_timeout_minutes  = var.session_timeout_minutes
}

resource "tfe_organization_membership" "members" {
  for_each = toset(var.members)

  organization = tfe_organization.org.name
  email        = each.key
}

resource "time_rotating" "time" {
  rotation_days = var.rotating_days
}

resource "tfe_organization_token" "token" {
  organization     = tfe_organization.org.name
  force_regenerate = var.force_regenerate
}

resource "tfe_admin_organization_settings" "admin" {
  count = var.terraform_enterprise ? 1 : 0

  organization                          = tfe_organization.org.name
  access_beta_tools                     = var.access_beta_tools
  global_module_sharing                 = var.global_module_sharing
  module_sharing_consumer_organizations = var.module_sharing_consumer_organizations
  workspace_limit                       = var.workspace_limit

  lifecycle {
    precondition {
      condition = (
        var.global_module_sharing == false &&
        length(var.module_sharing_consumer_organizations) == 0
        ) || (
        var.global_module_sharing == true && length(var.module_sharing_consumer_organizations) >= 0
      )
      error_message = "global_module_sharing must be true for module_sharing_consumer_organizations must be set"
    }
  }
}

resource "tfe_agent_pool" "pools" {
  for_each = var.agent_pools

  name                = each.key
  organization        = tfe_organization.org.name
  organization_scoped = each.value.organization_scoped
}

data "tfe_workspace_ids" "all" {
  names        = ["*"]
  organization = tfe_organization.org.name

  lifecycle {
    postcondition {
      condition = alltrue(flatten([
        for k, v in var.agent_pools : [
          for id in v.allowed_workspace_ids :
          contains(
            values(self.ids),
            id
          )
        ]
      ]))
      error_message = "Workspace not found for agent_pools.allowed_workspace_ids"
    }
  }
}

locals {
  workspace_agent_pool_permissions = {
    for k, v in var.agent_pools : k => v if v.organization_scoped == false
  }
}

resource "tfe_agent_pool_allowed_workspaces" "pool-workspaces" {
  for_each = local.workspace_agent_pool_permissions

  agent_pool_id         = tfe_agent_pool.pools[each.key].id
  allowed_workspace_ids = each.value.allowed_workspace_ids
}

locals {
  agent_tokens = merge(flatten([
    for k, v in var.agent_pools : {
      for agent in v.agents : "${k}_${agent}" => {
        agent_name    = agent
        agent_pool_id = tfe_agent_pool.pools[k].id
      }
    }
  ])...)
}

resource "tfe_agent_token" "tokens" {
  for_each = local.agent_tokens

  agent_pool_id = each.value.agent_pool_id
  description   = each.value.agent_name
}
