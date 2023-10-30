module "organizations" {
  for_each = var.organizations
  source   = "../.."

  name  = each.key
  email = each.value.email
}
