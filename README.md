# Terraform Infrastructure

This repository contains Terraform configuration files to provision the infrastructure on AWS. The project is modular and sets up various backend services and resources such as a VPC, Bastion Host, RDS, ElastiCache, MQ Broker, and Elastic Beanstalk application & environment.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Security Considerations](#security-considerations)

## Overview

This Terraform project provisions a complete AWS environment for the application, including:

- **VPC Setup:** Using the [terraform-aws-modules/vpc/aws](https://github.com/terraform-aws-modules/terraform-aws-vpc) module to create a VPC with both public and private subnets.
- **Backend Services:**
  - **RDS (MySQL):** A relational database instance configured with MySQL 8.0.
  - **ElastiCache (Memcached):** A caching service for improved performance.
  - **MQ Broker (RabbitMQ):** A message broker for asynchronous communication.
- **Bastion Host:** An EC2 instance deployed in a public subnet for secure administrative access.
- **Elastic Beanstalk:** An application and environment setup for deploying Java applications using Tomcat 10 on Amazon Linux 2023 with Corretto 21.
- **Remote State Management:** Terraform state is stored in an S3 bucket for collaboration and state locking.

## Architecture

The infrastructure is designed to isolate resources within a VPC:
- **VPC:** Provides network isolation with public and private subnets.
- **NAT Gateway:** Enables internet access for resources in private subnets.
- **Security Groups:** Fine-grained access control is implemented for all resources.
- **Elastic Beanstalk:** Manages application deployment with autoscaling, rolling updates, and load balancing.
- **Bastion Host:** Serves as a secure jump box for managing backend services.


## Prerequisites

- [Terraform](https://www.terraform.io/downloads) v0.14 or later
- AWS CLI installed and configured with proper credentials
- An AWS account with permissions to create the required resources


## Configuration

### Variables

Ensure all required variables are defined either in a `terraform.tfvars` file or via environment variables. Some key variables include:

- **AWS Region and VPC Settings:**
  - `AWS_REGION` – AWS region (e.g., `us-east-1`)
  - `VPC_NAME` – Name for the VPC
  - `vpcCIDR` – CIDR block for the VPC
  - `PrivSub1CIDR`, `PrivSub2CIDR`, `PrivSub3CIDR` – CIDR blocks for private subnets
  - `PubSub1CIDR`, `PubSub2CIDR`, `PubSub3CIDR` – CIDR blocks for public subnets
  - `Zone1`, `Zone2`, `Zone3` – Availability zones

- **Database and MQ Credentials:**
  - `dbname`, `dbuser`, `dbpass` – RDS credentials
  - `rmquser`, `rmqpass` – MQ Broker credentials

- **Bastion Host Configuration:**
  - `USERNAME` – SSH username for the bastion host
  - `PRIV_KEY_PATH` – Path to your private key file for SSH access
  - `instance_count` – Number of bastion host instances

### AWS Credentials

Ensure your AWS credentials are configured through environment variables, a shared credentials file, or your preferred authentication method.

## Usage

1. **Initialize Terraform:**

    ```sh
    terraform init
    ```

2. **Review the execution plan:**

    ```sh
    terraform plan
    ```

3. **Apply the configuration:**

    ```sh
    terraform apply
    ```

4. **Destroy the infrastructure (if needed):**

    ```sh
    terraform destroy
    ```

## Security Considerations

- **SSH Key:**  
  Update the `public_key` field in `keypairs.tf` with a valid public key for secure SSH access.

- **Security Groups:**  
  Review and adjust security group ingress and egress rules to follow the principle of least privilege. For example, consider restricting SSH access to known IP addresses instead of allowing traffic from `0.0.0.0/0`.

- **Remote State:**  
  Terraform state is stored in an S3 bucket. Ensure the bucket is secured with proper IAM policies and consider using DynamoDB for state locking.


