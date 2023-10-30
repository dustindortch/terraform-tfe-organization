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
      condition     = (var.global_module_sharing == false && length(var.module_sharing_consumer_organizations) == 0) || (var.global_module_sharing == true && length(var.module_sharing_consumer_organizations) >= 0)
      error_message = "global_module_sharing must be true for module_sharing_consumer_organizations must be set"
    }
  }
}
