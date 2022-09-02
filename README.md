The exercise
============
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


How To Use
==========

```bash
1. Login to Jenkins by using the following URL:
http://18.184.209.205:8080/

2. Run the "mobileyePipelineJob" job.
```

HELP
----

```bash
% docker run -v `pwd`:/tmp/screenshot adjeras/docker_capture_web_otorio
usage: screenshot.py [-h] [-w WINDOW_SIZE] [--ua USER_AGENT] [--wait WAIT]
                     [-v] [--vv]
                     url filename

positional arguments:
  url              specify URL
  filename         specify capture image filename

optional arguments:
  -h, --help       show this help message and exit
  -w WINDOW_SIZE   specify window size like 1200x800
  --ua USER_AGENT  specify user-agent
  --wait WAIT      specify wait seconds after scroll
  -v               set LogLevel to INFO
  --vv             set LogLevel to DEBUG
```

How To Build
===========

```bash
./build
```
