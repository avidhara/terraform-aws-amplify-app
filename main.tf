resource "aws_amplify_app" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  description = var.description
  repository  = var.repository

  access_token                  = var.access_token
  oauth_token                   = var.oauth_token
  auto_branch_creation_patterns = var.auto_branch_creation_patterns
  basic_auth_credentials        = var.enable_basic_auth ? var.basic_auth_credentials : null
  enable_auto_branch_creation   = var.enable_auto_branch_creation
  enable_basic_auth             = var.enable_basic_auth
  enable_branch_auto_build      = var.enable_branch_auto_build
  enable_branch_auto_deletion   = var.enable_branch_auto_deletion
  environment_variables         = var.environment_variables
  iam_service_role_arn          = var.iam_service_role_arn

  platform = var.platform



  dynamic "auto_branch_creation_config" {
    for_each = var.auto_branch_creation_config
    content {
      basic_auth_credentials        = try(auto_branch_creation_config.value.basic_auth_credentials, null)
      build_spec                    = try(auto_branch_creation_config.value.build_spec, null)
      enable_auto_build             = try(auto_branch_creation_config.value.enable_auto_build, null)
      enable_basic_auth             = try(auto_branch_creation_config.value.enable_basic_auth, null)
      enable_performance_mode       = try(auto_branch_creation_config.value.enable_performance_mode, null)
      enable_pull_request_preview   = try(auto_branch_creation_config.value.enable_pull_request_preview, null)
      environment_variables         = try(auto_branch_creation_config.value.environment_variables, null)
      framework                     = try(auto_branch_creation_config.value.framework, null)
      pull_request_environment_name = auto_branch_creation_config.value.pull_request_environment_name
      stage                         = try(auto_branch_creation_config.value.stage, null)

    }

  }

  custom_headers = var.custom_headers

  dynamic "custom_rule" {
    for_each = var.custom_rule
    content {
      condition = try(custom_rule.value.condition, null)
      source    = custom_rule.value.source
      status    = try(custom_rule.value.status, null)
      target    = custom_rule.value.target
    }
  }

  tags = var.tags
}


##### aws_amplify_branch
resource "aws_amplify_branch" "this" {
  for_each = var.branches

  app_id = aws_amplify_app.this[0].id

  branch_name                   = each.key
  backend_environment_arn       = lookup(each.value, "backend_environment_arn", null)
  basic_auth_credentials        = lookup(each.value, "basic_auth_credentials", null)
  description                   = lookup(each.value, "description", null)
  display_name                  = lookup(each.value, "display_name", null)
  enable_auto_build             = lookup(each.value, "enable_auto_build", null)
  enable_basic_auth             = lookup(each.value, "enable_basic_auth", null)
  enable_notification           = lookup(each.value, "enable_notification", null)
  enable_performance_mode       = lookup(each.value, "enable_performance_mode", null)
  enable_pull_request_preview   = lookup(each.value, "enable_pull_request_preview", null)
  environment_variables         = lookup(each.value, "environment_variables", null)
  framework                     = lookup(each.value, "framework", null)
  pull_request_environment_name = lookup(each.value, "pull_request_environment_name", null)
  stage                         = lookup(each.value, "stage", null)
  tags                          = var.tags
  ttl                           = lookup(each.value, "ttl", null)
}

#### aws_amplify_domain_association
resource "aws_amplify_domain_association" "this" {
  for_each = var.domains

  app_id                 = aws_amplify_app.this[0].id
  domain_name            = each.key
  enable_auto_sub_domain = lookup(each.value, "enable_auto_sub_domain", false)

  dynamic "sub_domain" {
    for_each = lookup(each.value, "sub_domain", [])
    content {
      branch_name = sub_domain.value.branch_name
      prefix      = sub_domain.value.prefix
    }
  }

  wait_for_verification = lookup(each.value, "wait_for_verification", false)
}