# ACIT 4640 - A03: Terraform Provisioning and Ansible Configuration

- [ACIT 4640 - A03: Terraform Provisioning and Ansible Configuration](#acit-4640---a03-terraform-provisioning-and-ansible-configuration)
  - [Description](#description)
    - [Terraform Backend](#terraform-backend)
    - [Terraform Infrastructure](#terraform-infrastructure)
    - [Ansible](#ansible)
  - [Setup](#setup)
    - [Terraform Backend Setup](#terraform-backend-setup)
    - [Terraform Infrastructure Setup](#terraform-infrastructure-setup)
    - [Ansible Setup](#ansible-setup)

## Description

This project has 3 parts:

- Terraform Backend
- Terraform
- Ansible

### Terraform Backend

The `./backend_setup` directory contains the Terraform files required to create a backend to store the Terraform state files.
The `tfvars` file contains the names for AWS resources.

### Terraform Infrastructure

The `./infrastructure` directory contains the Terraform files required to create the infrastructure required to run our web application.
It now uses modules to create the resources in a reusable manner.

### Ansible

The `./service` directory contains the Ansible `yml` files required to configure the infrastructure that was created.
The playbook now uses roles that are contained in the `./service/roles` directory.
The playbook now also makes use of a dynmaic inventory file that ends in `aws_ec2.yml`.
**Due to an issue in my environment, the keyed groups will be prepended by and underscore.**

## Setup

The following setup instructions should be done in order.

### Terraform Backend Setup

Please initialize the Terraform backend in the `backend_setup` directory by using the following command in the `backend_setup` directory:

```bash
terraform init
```

You **MUST** change the S3 bucket name and Dynamo DB name in the `terraform.tfvars` file.

To setup the backend, go into the `infrastructure` directory and run the following:

```bash
terraform plan -var-file=terraform.tfvars
```

Then run the following command to apply the Terraform on AWS:

```bash
terraform apply tfplan
```

This will create a backend file for the main infrastructure to use.

### Terraform Infrastructure Setup

Please initialize the Terraform in the `infrastructure` directory by using the following command in the `infrastructure` directory:

```bash
terraform init
```

If you would like to edit the subnet CIDRs, project name, aws-region, etc. please edit the `terraform.tfvars` file.
I would recommend you change the `home_net` and `ssh_key_name` to match your environment.

To setup the infrastructure, go into the `infrastructure` directory and run the following:

```bash
terraform plan -out tfplan -var-file=terraform.tfvars
```

This will create a `tfplan` binary file that we can apply to create our infrastructure.

Run the following command to apply the terraform on AWS:

```bash
terraform apply tfplan
```

The infrastructure should now be launched.
Two files will be created in the `service` directory.
The file in `./service/inventory` contains the hostnames of the ec2 instances.
The file in `./service/group_vars` contains variables (mostly internal ip addresses) that ansible needs to run its playbook.

### Ansible Setup

There needs to be a `servers.yml` file in the `./service/group_vars` ~~and `./service/inventory`~~ directories.
If those files don't exist, the playbook will fail.
Please follow the instructions in the Terraform section to create the files.

If you wish to change the message displayed on the website,
please edit the insert statement in `./service/templates/init.sql.j2`.

`ansible.cfg` should set the inventory file to be located in the `./service/inventory/` directory.

In the `./service` directory, run the following command to configure the ec2 instances:

```bash
ansible-playbook ansible.yml
```

The website should now display the data.
