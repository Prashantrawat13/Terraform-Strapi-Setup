# Overview

This module is responisble for creating the compute resources for our project.

## Services Used

Now we'll be seeing the services used in this module.

### This is the list of services created for bastion host

- Key Pair for Bastion Host
- EC2 Instance for Bastion Host
- Auto Scaling Group for Bastion Host

### This is the list of services created for Web servers

- Launch Template for Web Servers
- Auto Scaling Group for Web Servers
- Written User Data for Web Servers to install and configure Nginx Web Server using Docker.
  
### This is the list of services created for Application servers

- Launch Template for Application Servers
- Auto Scaling Group for Application Servers.
