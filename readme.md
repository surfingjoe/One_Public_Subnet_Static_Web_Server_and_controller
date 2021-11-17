# Creating a New VPC

## With One Public Subnet, Static Website and a controller

The Web server starts out as a simple "Hello World"

<img src="VPC_one_public_subnet_static_web_server-Compute Layout.png">

------

## Requirements 

[Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

[Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

[Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

```
Note:  You don't have to install these requirements into your desktop.  You can use virtual desktops instead or cloud based desktops.  For example running a Linux platform like Ubuntu using Oracle's Virtualbox then install the requirements within that development environment.  Or perhaps use AWS Cloud 9 environment.
```

## Configuration

`Note: **You need to change variables.tf, s3_policy.tf and create an S3 bucket for this exercise**

Once the requirements are installed clone this repository and edit the file variables.tf

*  Edit the variable in variables.tf file, with your choice for AWS Region (currently, the default is "us-west-1").
*  Edit the CIDR blocks in variables.tf file,  if you want to use different address range for your new VPC
*  Edit the Instance type variable in variables.tf,  if you want to use a different instance type (note: the default "t2.micro" is the only type you can use for free tier)
*  Edit the variable ssh_location (put in your public IP address, you can find your public IP address by opening a browser and typing "what is my IP" in the address bar). Be sure to change the variable default to "your IP address with a  /32" subnet mask.  
*  Place your regional EC2 Key Pair name as the default for variable "Key" in the variables.tf file

## Create an S3 Bucket in AWS

1. Sign in to the AWS Management Console and open the Amazon S3 console at https://console.aws.amazon.com/s3/
2. Choose **Create bucket**
3. Enter the **Bucket name** (for example, my-awesome-bucket)

*Note: S3 buckets must have a **UNIQUE NAME**. Literally it has to be a unique name within AWS S3 for **ALL REGIONS, Globally**

Choose the Region where you want to create the bucket

Accept the default settings and create the bucket, choose **Create**.

## Copy the static website files into the new S3 bucket

I have included a "Creative Commons" static website that found @ html5up.net.  As of the time of this writing I've scanned the files & no malware or viruses exist and it is free to use from html5up's web site.

Copy the "Static_Website_files.zip" to any folder, unzip the file and then copy the assets folder and the index.html file into your new S3 bucket

#### Configure the s3_policy.tf file

Configure the s3_policy.tf  with the "arn" of your new S3 bucket, the s3_policy creates an IAM policy that allows your new Web server to copy the contents of your S3 bucket into /var/www/html folder 

## Launching the VPC and Web Server

After installing the requesite software and configuration of variables.

Run the following commands in terminal

* Terraform init (Causes terraform to install the necessary provider modules, in this case to support AWS provisioning)
* terraform validate (Validates the AWS provisioning code)
* Terraform Apply (Performs the AWS provisioning of VPC and Web Server)

After Terraform finishes provisioning the new VPC, Security Group and Web Server, it will output the Public IP address of the new public server in the terminal Window

------

#### Open a browser, paste in the Public IP address and you should see a static web site with rolling mountains as a background
------

## Clean up

Once you have finished with this example run:

* Terraform Destroy (to remove VPC and Web Server)

## Integrating with Jenkins
* I have included a Jenkinsfile, to use it, be sure to add Terraform Plugin which is required, and be sure to configure Terraform Plugin  
* I have a built in name for a Jenkins Slave encoded in the Jenkins file, pay attention to the Agent name, you'll need to change slave name.  
* If you integrating Github with Jenkins, then know this: I have configured the Jenkinsfile with paramaters. When run for the first time, it will need build approval, allowing you to execuite 'Terraform Apply'

**To cleanup AWS after Jenkins build, manually run the Jenkins Project a second time and choose "Build with Parameters" and checkmark Destroy **

* Note: The terraform plugin doesn't recognize parameters the first time it is run, (a bug in Jenkins),hence will fail because it doesn't see the parameters on the first run.  I am Ok with that, for myself, however to make it run the first time, everytime, you might want to remove the lines associated with using workspace naming paramater and the line that utilizes the workspace name.

* Also, if using the Jenkins file, pay attention to the credential names to plug in your secret credentials, or better yet use base64encode to encrypt the credentials.