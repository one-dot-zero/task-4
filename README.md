# Task 4

The configuration found in this repository can be used to deploy the following resources:
 - a VPC with 2 public subnets (InternetGateway + entry in the default route table to the igw)
 - a Network Load Balancer
 - a listener for the load balancer (listen on port 80)
 - a target group that sends traffic to port 31555
 - a Security Group that allows traffic on port 31555 from 0.0.0.0/0
 - an Auto-Scaling Group
 - a launch template for the instances used in the ASG (nginx is installed and configured to listen on 31555 via a user_data script)
 - two auto-scaling schedules that scale-up or scale-down the group based on a schedule(cron)

 User_data script can be found in `user_data.sh` file.

 ## How to deploy
 Make sure that you have the aws cli configured. If not please follow the [link](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started).

In the root directory, issue the following commands:
 1. `terraform init`
 2. `terraform plan` 
 3. `terraform apply`

 ## How to test the configuration
 Curl the DNS name of the load balancer.