The assignment
==============
```bash
General Instructions:
-	Create an empty git repository. In it, create a simple text file with the text "Hello Mobileye!".
-	If needed, you can create additional git repositories. 
-	Use the given AWS credits and create an AWS account to implement the task below.

The task:
  1.	Write a Dockerfile to the project. 
     a.	You need to make sure that python version 3.8 is installed.
     b.	Place the text file in /tmp
     c.	The server can be triggered by running the command: python -m http.server --directory /tmp/

  2.	Write an IaaC module (feel free to use any tool you are familiar with. E.g., Terraform/CloudFormation/CDK) to create:
     a.	An EC2 instance
     b.	An ECR repository
     c.	A container orchestrator cluster (e.g., ECS/EKS)
  3.	Create an EC2 instance using the IaaC module from step 2.a
  4.	Launch a CI server (e.g., Jenkins) on the EC2 instance. If more instances are needed, create them using the IaaC module from step 2.a
  5.	Write a CI pipeline script for the micro-service. The pipeline must include:
     a.	Creating an ECR repository using the module from step 2.b
     b.	Building a Docker image based on the Dockerfile from step 1
     c.	Pushing the Docker image to the ECR repository
  6.	Create a job in the CI server that will run the CI script.
  7.	Create a container orchestrator cluster using the IaaC module from step 2.c 
  8.	Provide a deployment solution to the application on the cluster that was just created. The application must be accessible from the browser on port 80. 
```

URL to see the text file under /tmp dir 
=======================================

```bash
http://a84688956b5354f86aac5e39e02279d7-928147059.eu-central-1.elb.amazonaws.com

http://a84688956b5354f86aac5e39e02279d7-928147059.eu-central-1.elb.amazonaws.com/mobileye.txt
```


How to access Jenkins to run the pipeline
=========================================

```bash
1. Login to Jenkins by using the following URL:
http://18.184.209.205:8080/

2. Run the "mobileyePipelineJob" job.
```

Commands & more
---------------

-	Installation steps of the first AWS ec2 node that includes the Jenkins app using Terraform:
1. Creating a repository named mobileye on my github account.

2. Cloned the repo to my PC using my VSC (Visual Studio Code) terminal with the following command:
**git clone git@github.com:adjeras/mobileye.git**

3. Installing AWS and Terraform extensions (VSC).

4. Execute the creation of the first node (the Jenkins node) using Terraform module - Some relevant commands for this step:

**which terraform**
**terraform --version**
**mkdir terraform**
**cd terraform**
**vim main.tf**
**vim userdata.tpl** # this is where I execute the post install commands

**ls -l ~/.ssh/amirkey.pub**

**terraform init**
**terraform plan**
**terraform apply -target="aws_instance.mobileye_node1" -auto-approve**



**git status**
**git add <filename>**
**git commit -m "create Terraform ec2 module"**
**git pull --rebase**
**git push origin master**
**git push origin main**

5. Once Jenkins node was ready I logged into it using PuTTY (and the private key I generated) and from this point I started working only on the Jenkins node.

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 394916145019.dkr.ecr.eu-central-1.amazonaws.com
eksctl get cluster --name mobileye-eks-cluster --region eu-central-1



How To Build
===========

```bash
./build
```
