# Creating a New VPC

## With One Public Subnet and One Web Server

The Web server starts out as a simple "Hello World"

<img src="One-public-one-web.png">

------

## Requirements 

[Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

[Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

[Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

```
Note:  You don't have to install these requirements into your desktop.  It is certainly quite feasible to use a virtual desktop for your development environment using tools like Oracle's virtualbox or VMware Workstation or Player, or Mac Fusion or Mac Parallels.  Perhaps an AWS Workspace or AWS Cloud 9 environments.
```

## Configuration

`Note: The variables do not have to be changed if you are ok with running a new VPC and Web server out of US-West-1 region`

Once the requirements are installed clone this repository and edit the file variables.tf

*  Edit the variable for your choice for AWS Region (currently, the default is "us-west-1").
*  Edit the CIDR blocks if you want to use different address range for your new VPC
*  Edit the Instance type if you want to use a different instance type (note: the default "t2.micro" is the only type you can use for free tier)
*  Edit the variable ssh_location (put in your public IP address, you can find your public IP address by opening a browser and typing "what is my IP" in the address bar)

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