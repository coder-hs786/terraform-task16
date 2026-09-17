# Task 16 - Infrastructure Provisioning on AWS Using Terraform with Kubernetes Deployment

## Objective

Provision AWS infrastructure using Terraform and deploy a Kubernetes
application on a private EC2 instance using Kind.

## Architecture

Internet
  |
AWS Application Load Balancer
  |
Private EC2 :30080
  |
Kind Kubernetes Cluster
  |
Nginx Application

Bastion Host -> Secure SSH -> Private EC2

Terraform -> AWS Infrastructure

## AWS Infrastructure

- VPC: 10.0.0.0/16
- Two Availability Zones
- Two Public Subnets
- Two Private Subnets
- Internet Gateway
- NAT Gateway
- Public Route Table
- Private Route Table
- Bastion Host in Public Subnet
- Private EC2 in Private Subnet
- Security Groups
- Application Load Balancer
- Target Group
- HTTP Listener

## Kubernetes

Docker, kubectl and Kind were configured on the private EC2 instance.

Application:
- Nginx
- Kubernetes Deployment
- NodePort Service
- NodePort: 30080

## Access

The private EC2 instance is accessed through the Bastion Host.

Internet access for the private EC2 instance is provided through the NAT Gateway.

The application is publicly accessible through the AWS Application Load Balancer.

## Verification

- Terraform configuration validated successfully.
- VPC and subnets created successfully.
- NAT Gateway available.
- Bastion Host can access Private EC2.
- Kind Kubernetes node is Ready.
- Application pod is Running.
- Kubernetes service is available on port 30080.
- ALB is Active.
- ALB Target Group reports Healthy.
- Nginx application is accessible through the ALB DNS name.

## Troubleshooting

### EC2 Free Tier Error
Error:
The selected instance type was not Free Tier eligible.

Root Cause:
t3.medium was not eligible for the account Free Tier.

Solution:
Changed the private EC2 instance type to t3.small.

### Kind NodePort Access Issue
Error:
curl localhost:30080 returned connection refused.

Root Cause:
Kind runs Kubernetes nodes inside Docker containers and the NodePort was
not mapped to the EC2 host.

Solution:
Recreated the Kind cluster using extraPortMappings for port 30080.

### ALB Connectivity
The ALB security group allows HTTP port 80.
The private EC2 security group allows port 30080 from the ALB security group.
The target group health check confirms that the application target is healthy.

## Security

- Private EC2 has no public IP address.
- SSH access to Private EC2 is through the Bastion Host.
- Private subnet internet access uses NAT Gateway.
- Application traffic enters through the ALB.
