# terraform-tfe-organization

This module manages an organization in Terraform Cloud/Enterprise.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.49.2, < 1.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1, < 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.49.2, < 1.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.9.1, < 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_admin_organization_settings.admin](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/admin_organization_settings) | resource |
| [tfe_organization.org](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization) | resource |
| [tfe_organization_membership.members](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_membership) | resource |
| [tfe_organization_token.token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token) | resource |
| [time_rotating.time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_beta_tools"></a> [access\_beta\_tools](#input\_access\_beta\_tools) | Whether to allow access to beta tools | `bool` | `false` | no |
| <a name="input_allow_force_delete_workspaces"></a> [allow\_force\_delete\_workspaces](#input\_allow\_force\_delete\_workspaces) | Whether to allow force delete workspaces | `bool` | `false` | no |
| <a name="input_assessments_enforced"></a> [assessments\_enforced](#input\_assessments\_enforced) | Whether to enforce policy checks for Terraform runs | `bool` | `false` | no |
| <a name="input_collaborator_auth_policy"></a> [collaborator\_auth\_policy](#input\_collaborator\_auth\_policy) | Authentication policy (password or two\_factor\_mandatory) | `string` | `"password "` | no |
| <a name="input_cost_estimation_enabled"></a> [cost\_estimation\_enabled](#input\_cost\_estimation\_enabled) | Whether to allow cost estimation | `bool` | `false` | no |
| <a name="input_email"></a> [email](#input\_email) | The admin email address of the organization | `string` | n/a | yes |
| <a name="input_force_regenerate"></a> [force\_regenerate](#input\_force\_regenerate) | Forces new token generation | `bool` | `false` | no |
| <a name="input_global_module_sharing"></a> [global\_module\_sharing](#input\_global\_module\_sharing) | Whether to allow global module sharing | `bool` | `false` | no |
| <a name="input_members"></a> [members](#input\_members) | A list of email addresses of organization members | `list(string)` | `[]` | no |
| <a name="input_module_sharing_consumer_organizations"></a> [module\_sharing\_consumer\_organizations](#input\_module\_sharing\_consumer\_organizations) | Organization names to share modules with | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the organization | `string` | n/a | yes |
| <a name="input_owners_team_saml_role_id"></a> [owners\_team\_saml\_role\_id](#input\_owners\_team\_saml\_role\_id) | The name of the owners team | `string` | `""` | no |
| <a name="input_rotating_days"></a> [rotating\_days](#input\_rotating\_days) | Number of days to rotate the token | `number` | `30` | no |
| <a name="input_send_passing_statuses_for_untriggered_speculative_plans"></a> [send\_passing\_statuses\_for\_untriggered\_speculative\_plans](#input\_send\_passing\_statuses\_for\_untriggered\_speculative\_plans) | Whether to send passing statuses for untriggered speculative plans | `bool` | `false` | no |
| <a name="input_session_remember_minutes"></a> [session\_remember\_minutes](#input\_session\_remember\_minutes) | Session expiration in minutes | `number` | `21600` | no |
| <a name="input_session_timeout_minutes"></a> [session\_timeout\_minutes](#input\_session\_timeout\_minutes) | Session timeout after inactivity in minutes | `number` | `21600` | no |
| <a name="input_workspace_limit"></a> [workspace\_limit](#input\_workspace\_limit) | The maximum number of workspaces allowed in the organization | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The name of the organization |
| <a name="output_token"></a> [token](#output\_token) | Organizational token |
| <a name="output_user_ids"></a> [user\_ids](#output\_user\_ids) | User IDs of organization members |
| <a name="output_usernames"></a> [usernames](#output\_usernames) | Usernames of organization members |
<!-- END_TF_DOCS -->