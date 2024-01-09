# Automate-IaC
Using terraform to create a simple IaC on AWS

Terraform file should be included:
    1x VPC that is private, only allow one port to remote in using SSH protocol
    1x EC2 using with a custom Key Pair
    1x S3 that used to store the custom Key Pair

Github Action:
    1. Create resource: Terraform apply
    2. Destroy resources: Terraform destroy