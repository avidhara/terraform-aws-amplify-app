module "amplify" {
  source               = "../.."
  name                 = "test"
  description          = "test application"
  repository           = "https://github.com/dabit3/aws-amplify-vue-sample"
  iam_service_role_arn = "arn:aws:iam::xxxxx:role/amplifyconsole-backend-role"
  platform             = "WEB"

  oauth_token = "xxxx"

  tags = {
    Name = "test"
  }

  branches = {
    main = {
      description       = "main branch"
      display_name      = "main"
      enable_auto_build = true
      environment_variables = {
        a = "b"
      }
    }
  }
}