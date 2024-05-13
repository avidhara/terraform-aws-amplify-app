variable "create" {
  type        = bool
  description = "(Optional) Whether to create the resource. Set to false to prevent the module from creating any resources"
  default     = true
}

variable "name" {
  type        = string
  description = "(Required) Name for an Amplify app."
}

variable "description" {
  type        = string
  description = "(Optional) Description for an Amplify app."
  default     = null
  nullable    = true
}

variable "repository" {
  type        = string
  description = "(Optional) Repository for an Amplify app."
  default     = null
}

variable "access_token" {
  type        = string
  description = "(Optional) Personal access token for a third-party source control system for an Amplify app. The personal access token is used to create a webhook and a read-only deploy key. The token is not stored."
  default     = null
  nullable    = true
}

variable "oauth_token" {
  type        = string
  description = "(Optional) OAuth token for a third-party source control system for an Amplify app. The OAuth token is used to create a webhook and a read-only deploy key. The OAuth token is not stored."
  default     = null
}

variable "auto_branch_creation_patterns" {
  type        = list(string)
  description = "(Optional) Automated branch creation glob patterns for an Amplify app."
  default     = []
}

variable "basic_auth_credentials" {
  type        = string
  description = "(Optional) Credentials for basic authorization for an Amplify app."
  default     = null
}

variable "enable_auto_branch_creation" {
  type        = bool
  description = "(Optional) Enables automated branch creation for an Amplify app."
  default     = false
}

variable "enable_basic_auth" {
  type        = bool
  description = "(Optional) Enables basic authorization for an Amplify app. This will apply to all branches that are part of this app."
  default     = false
}

variable "enable_branch_auto_deletion" {
  type        = bool
  description = "(Optional) Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository."
  default     = false
}

variable "enable_branch_auto_build" {
  type        = bool
  description = "(Optional) Enables auto-building of branches for the Amplify App."
  default     = false
}

variable "environment_variables" {
  type        = map(string)
  description = "(Optional) Environment variables map for an Amplify app."
  default     = {}
}

variable "iam_service_role_arn" {
  type        = string
  description = "(Optional) AWS Identity and Access Management (IAM) service role for an Amplify app."
  default     = null
}

variable "platform" {
  type        = string
  description = "(Optional) Platform or framework for an Amplify app. Valid values: WEB, WEB_COMPUTE. Default value: WEB."
  default     = "WEB"
}

variable "auto_branch_creation_config" {
  type = list(object({
    basic_auth_credentials        = optional(string)
    build_spec                    = optional(string)
    enable_auto_build             = optional(bool)
    enable_basic_auth             = optional(bool)
    enable_performance_mode       = optional(bool)
    enable_pull_request_preview   = optional(bool)
    environment_variables         = optional(map(string))
    framework                     = optional(string)
    pull_request_environment_name = optional(string)
    stage                         = optional(string)
  }))
  description = <<-_EOT
    (Optional) Automated branch creation configuration for an Amplify app. 
    The dynamic block supports the following:
    - basic_auth_credentials - (Optional) Basic auth credentials for an automated branch.
    - build_spec - (Optional) Build spec for an automated branch.
    - enable_auto_build - (Optional) Whether to enable auto build for an automated branch.
    - enable_basic_auth - (Optional) Whether to enable basic auth for an automated branch.
    - enable_performance_mode - (Optional) Whether to enable performance mode for an automated branch.
    - enable_pull_request_preview - (Optional) Whether to enable pull request preview for an automated branch.
    - environment_variables - (Optional) Environment variables for an automated branch.
    - framework - (Optional) Framework for an automated branch.
    - pull_request_environment_name - (Required) Pull request environment name for an automated branch.
    - stage - (Optional) Stage for an automated branch.
   _EOT
  default     = []
}

variable "custom_headers" {
  type        = any
  description = "(Optional) The custom HTTP headers for an Amplify app."
  default     = null
}

variable "custom_rule" {
  type = list(object({
    condition = optional(string)
    source    = optional(string)
    status    = optional(number)
    target    = optional(string)
  }))
  description = <<_EOT
    (Optional) Custom rewrite / redirect rules for an Amplify app. 
    The dynamic block supports the following:
    - condition - (Optional) The condition for a URL rewrite or redirect rule, e.g. country code.
    - source - (Optional) The source pattern for a URL rewrite or redirect rule, e.g. /index.html.
    - status - (Optional) The status code for a URL rewrite or redirect rule, e.g. 301.
    - target - (Optional) The target pattern for a URL rewrite or redirect rule, e.g. /index.html.
  _EOT
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags for an Amplify app."
  default     = {}
}

##### aws_amplify_branch

variable "branches" {
  type = map(object({
    backend_environment_arn       = optional(string)
    basic_auth_credentials        = optional(string)
    description                   = optional(string)
    display_name                  = optional(string)
    enable_auto_build             = optional(bool)
    enable_basic_auth             = optional(bool)
    enable_notification           = optional(bool)
    enable_performance_mode       = optional(bool)
    enable_pull_request_preview   = optional(bool)
    environment_variables         = optional(map(string))
    framework                     = optional(string)
    pull_request_environment_name = optional(string)
    stage                         = optional(string)
    ttl                           = optional(number)
  }))
  description = <<_EOT
    (Optional) Branch configuration for an Amplify app. 
    The dynamic block supports the following:
    Name: branch name
    - backend_environment_arn - (Optional) The ARN for the backend environment.
    - basic_auth_credentials - (Optional) Basic auth credentials for the branch.
    - description - (Optional) Description for the branch.
    - display_name - (Optional) Display name for the branch.
    - enable_auto_build - (Optional) Whether to enable auto build for the branch.
    - enable_basic_auth - (Optional) Whether to enable basic auth for the branch.
    - enable_notification - (Optional) Whether to enable notification for the branch.
    - enable_performance_mode - (Optional) Whether to enable performance mode for the branch.
    - enable_pull_request_preview - (Optional) Whether to enable pull request preview for the branch.
    - environment_variables - (Optional) Environment variables for the branch.
    - framework - (Optional) Framework for the branch.
    - pull_request_environment_name - (Optional) Pull request environment name for the branch.
    - stage - (Optional) Stage for the branch.
    - ttl - (Optional) Time to live for the branch.
  _EOT
  default     = {}
}


##### aws_amplify_domain_association

variable "domains" {
  type = map(object({
    enable_auto_sub_domain = bool
    sub_domain = list(object({
      branch_name = string
      prefix      = string
    }))
    wait_for_verification = bool
  }))
  description = <<_EOT
    (Optional) Domain configuration for an Amplify app. 
    The dynamic block supports the following:
    Name: domain name
    - enable_auto_sub_domain - (Required) Whether to enable auto sub domain for the domain.
    - sub_domain - (Required) Sub domain configuration for the domain.
      - branch_name - (Required) Branch name for the sub domain.
      - prefix - (Required) Prefix for the sub domain.
    - wait_for_verification - (Required) Whether to wait for verification for the domain.
  _EOT
  default     = {}
}