	## Week 5 Project

# Azure with Terraform

__In this project I have created an infrastructure for the Weight Tracker application
using Microsoft Azure and Terraform.__

Project environment:

![week-5-project-env](https://bootcamp.rhinops.io/images/week-4-project-env.png)


>To implement this infrastructure Ive used all as described in the picture above.

>This project includes 1 module for the virtual machines.

>You can find documentation for each resource in the source code.

## Note
__For this project I have created VM image with custom data and one managed database__
__The number of VMs can be changed in variables.tf file under num var__
Please read the requirements of the application.

**_In addition the vm gets a script I wrote for setting up the vm, .env file,Okta application redirect URIs using Okta API and finally initialize the database and running the application as a service using pm2_** 

## Deployment
__To deploy the environment you can create your own .tfvars file.__
__This file must include the following:__

>admin_username   = "Virtual machine username"<br/>
admin_password   = "Virtual machine password"<br/>
pg_user          = "Postgres SQL user name"<br/>
pg_password      = "Postgres SQL password"<br/>
okta_secret 	 = "Okta secret"<br/>
okta_client_id   = "Okta client ID"<br/>
okta_org_url     = "Okta URL"<br/>
okta_key         = "Okta key for API calls"<br/>


__To deploy the enviroment follow these steps in the terminal:__

1 . To initialize Terraform, first create azure blobe and update the location in backend.tf file

2 . To initialize Terraform working directory run

    terraform init

3 . To deploy the enviroment:

    terraform apply


>Note: add optional flag "-auto-approve" to automatically approve the plan.

__for example:__

    terraform apply -auto-approve



>To remove whole enviroment run:

    terraform destroy