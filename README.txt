1.I have a sample Next.js app code in the directory "nextjs" on my local machine.

2.I pushed the code to the GitHub repository named "nextjs" using the following commands:
###########     
	 Using below command add all of the files in the current directory to the staging area:
	# git add *
	
	 Once you have added the files to the staging area, commit them to your Git repository by running below command:
	# git commit -m "new code"
	
	 And then push them to git repo with the below command:
	# git push origin master
###########

3.I created Terraform code to deploy the Next.js app to AWS Amplify from the GitHub repository.

4.It's worth mentioning that I have made all the Terraform code available publicly in my GitHub repository.
  
5. I have uploaded terraform code in the directory name terraform in the same github repo and pasted the code below as well.

#The following Terraform code deploys an AWS Amplify web app by creating the necessary resources and configuring the deployment from a specified GitHub repository.
 and enable the continuous deployments (CI/CD)#
############
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
############

6.Use the following terraform command to deploy application on AWS Amplify.

    To validate the terraform code use the following command:
	#terraform validate
	
	To initializes a Terraform working directory use the following command:
	#terraform init
	
	To deploy code use the following command:
	#terraform apply
	
7.App link is given below:

https://main.dizbkd8qqu770.amplifyapp.com/