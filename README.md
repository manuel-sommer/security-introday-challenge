# This forked repo adds multiple DevOps Tools.
## Terraform 
Use this terraform code to setup an EC2 instance in your AWS account. Setup an AWS account profile in your local environment called "securitytest".
Caution: This is for educational purposes, you are setting here up a vulnerable test environment with a public reachable IP address.
Steps:
- terraform init
- terraform apply

## Ansible
Use the generated key from terraform (ec2-ssh-key-pem.pem) to execute the Ansible.
Prerequisites:
- You need to adapt the second line in the file /terraform/ansible/hosts. This line needs to be the output IP address of the applied Terraform EC2.
Execute the following to setup Docker and Docker-compose in the ec2:
- ansible-playbook --private-key=../ec2-ssh-key-pem.pem -i hosts playbook.yml

## Now do the following:
- ssh into the ec2 instance using the generated key (ssh -i ec2-ssh-key-pem.pem ubuntu@<ip_address_of_ec2>)
- clone this repo https://github.com/manuel-sommer/security-introday-challenge.git
- run: docker-compose up --build -d

# Tis is the Documentation of the fork:
# Security Introday Coding Challenge

## The challenge

Here is a badly written application with many flaws.

Your task is to:

1. Study the application **as a whole** and identify the flaws. Try to fix as many of them as possible*.
2. Containerize the application.
3. Present the improved application and show us the changes you made.

Notes: \*Some flaws cannot be fixed immediately. Document them and explain why they are bad and what will you change.

## Demo application

### Requirements

#### System

- GNU/Linux
- `python` >= 3.7
- `pip` >= 9.0

`>=` means any version of the package, above or equal to the specified version.

#### Application

This application requires `tornado` python package.

You can install them by using:

```bash
pip install tornado
```

Although things do not have to be this way :wink: 

### :rocket: Starting the application

Application can be found in `main.py` file. You can start the application by using:

```bash
python main.py
```

Visit http://localhost:8000. Login with **admin:letmein**.

#### Database

The application comes with a simple predefined sqlite3 database file `db`. There are two tables:

**users** table

| Column   | Type         | Null | Note        |
| -------- | ------------ | ---- | ----------- |
| id       | INTEGER      | No   | Primary key |
| username | VARCHAR(255) | No   |             |
| password | VARCHAR(255) | No   |             |

**fruits** table

| Column   | Type         | Null | Note        |
| -------- | ------------ | ---- | ----------- |
| id       | INTEGER      | No   | Primary key |
| name     | VARCHAR(255) | No   |             |
| quantity | INTEGER      | No   |             |
