##Fetch nextjs app code from github and deploy it on aws amplify##

resource "aws_amplify_app" "frontend"{
  name = "distracted-frog-r3p4kx-1"

  repository = "https://github.com/mahe31337/nextjs"
  access_token= "ghp_5DPNUKkcGMvn9VV2keuHFRee4JFVnG4LGt"

  build_spec = <<-EOT
  version: 1
  frontend:
    phases:
      preBuild:
        commands:
          - npm ci
      build:
        commands:
          - npm run build
    artifacts:
      baseDirectory: .next
      files:
        - '**/*'
    cache:
      paths:
        - node_modules/**/*
  EOT

  enable_auto_branch_creation = true
  enable_branch_auto_build = true
  enable_branch_auto_deletion = true
  platform = "WEB"
}

##Enable continuous deployments (CI/CD)##

resource "aws_amplify_branch" "master_branch" {
  app_id       = aws_amplify_app.frontend.id
  branch_name  = "master"  # Replace with the name of your main branch in the repository
}


