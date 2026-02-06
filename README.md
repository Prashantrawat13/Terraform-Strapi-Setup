# 2-Tier AWS Architecture with Terraform

This repository contains Terraform configurations to deploy a **secure, scalable, and robust 2-tier architecture** on AWS. The project follows **Terraform best practices** with a modular approach to improve **code reusability** and **scalability**.  

The architecture includes a **Web Tier** and an **Application Tier**, along with load balancers, auto-scaling groups, and proper networking to ensure high availability.

---

## Architecture Overview

## **Features**

- Secure networking with public/private subnet separation.
- Scalable web and application layers using Auto Scaling Groups.
- High availability across multiple AZs.
- Fully modular Terraform code for easy reuse and maintenance.
- Bastion host for secure admin access.
- Internet and NAT gateways for controlled internet access.

### Networking

- **2 Public Subnets** → For internet-facing resources (e.g., Web-tier instances, External ALB)  

- **2 Private Subnets** → For application-tier instances  

- **Internet Gateway** → Provides internet access to public subnets  
- **NAT Gateway** → Enables private subnets to access the internet securely  

- **Route Tables** → Separate route tables for public and private subnets

### ALB

- **External Internet-facing ALB (Web-tier)**
  
  - Listener and target group for Web-tier EC2 instances  
- **Internal ALB (Application-tier)**  
  - Listener and target group for Application-tier EC2 instances  
- **5 Security Groups**:
  1. External ALB  
  2. Web-tier Instances  
  3. Internal ALB  
  4. Application-tier Instances
  5. Bastion Host

> Security groups are carefully configured to follow the **principle of least privilege**.

### Compute

- **Web-tier Auto Scaling Group** → Uses Launch Template to spin up EC2 instances  

- **Application-tier Auto Scaling Group** → Uses Launch Template for EC2 instances  

- **Bastion Host** → Separate Launch Template, Auto Scaling Group, and Security Group for secure access  

---
***

## Project Structure


- `modules/` – Contains reusable modules for compute, networking, and ALB  
- `modules/compute/keys/` – Stores private keys (**ignored by Git**)  
- `terraform/` – Root Terraform files and state management  
- `.terraform/` – Terraform plugin cache (ignored by Git)  

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5  
- AWS account with proper IAM credentials  
- [AWS CLI](https://aws.amazon.com/cli/) configured (`aws configure`)  
- Optional: Git for version control

---

## Setup Instructions

1. **Clone the repository:**

```bash
git clone <https://github.com/Prashantrawat13/Terraform-Strapi-Setup.git>
cd <Terraform-Strapi-Setup>     # Now we are in the root directory of the project
cd terraform           # Change to the terraform directory where the main configuration files are located
```

2. **Initialize Terraform:**

```bash
terraform init
```

3. **Validate the configuration:**

```bash
terraform validate
```

4. **Plan the deployment:**

```bash
terraform plan
```

5. **Apply the Terraform configuration:**

```bash
terraform apply
```

6. **Verify resources in the AWS console (VPC, subnets, ALBs, EC2 instances, Security Groups, ASGs).**

***

### **Keys Points / Best Practices**

- **Modular Design**: The project is structured into reusable modules for better organization and maintainability.  

- **Security**: Security groups are configured to allow only necessary traffic, following the principle of least privilege.

- **Scalability**: Auto Scaling Groups ensure that the architecture can handle varying loads by automatically adjusting the number of instances.

- **State Management**: Terraform state is managed locally, but it can be easily switched to remote backends (e.g., S3) for better collaboration and security.

- **networking**: Proper separation of public and private subnets ensures secure access to resources while allowing necessary internet connectivity.

- **TAGGING**: Resources are tagged appropriately for better organization and cost management.

***

## Cleanup

To destroy the infrastructure created by Terraform, run:

```bash
terraform destroy
```

---

## **References**

- **Terraform AWS Provider**  
  
  [Official Terraform AWS Provider Documentation:](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

- **AWS VPC, Subnets, and Networking**  
 
  - [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)  
  
  - [Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)  
  
  - [Internet Gateway & NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)  

- [**AWS Launch Template**](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html)

- [**AWS Auto Scaling Group**](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html)

- [**AWS Security Groups**](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

- **AWS Application Load Balancer (ALB)**  

  - [Internet-facing ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-getting-started.html)  

  - [Internal ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-internal.html)

---

## **Author**

- [LinkedIn](https://www.linkedin.com/in/prashantrawat13/)

- [GitHub](https://github.com/Prashantrawat13)

- [Email](mailto:prashantrawat733@gmail.com)

---
---