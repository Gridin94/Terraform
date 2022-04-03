	## Week 6 Project

# Azure with Terraform & Ansible

__In this project I have created an infrastructure for the Weight Tracker application
using Microsoft Azure and Terraform & deployed the configuration using Ansible.__

Project environment:

![week-6-project-env](https://bootcamp.rhinops.io/images/week-6-envs.png)


>To implement this infrastructure Ive used all as described in the picture above.

>This project includes 1 module for the virtual machines.

>You can find documentation for each resource in the source code.

## Note
__The number of VMs can be changed in variables.tf file under num var__
Please read the requirements of the application. 

## Deployment
__To deploy the environment you can create your own .tfvars file.__
__This file must include the following:__

>admin_username   = "Virtual machine username"<br/>
admin_password   = "Virtual machine password"<br/>


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