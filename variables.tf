variable "region" {
    type=string
    description="AWS region for placement of VPC"
    default="us-west-1"
}

variable "vpc_cidr" {
    type=string
    default="10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type=string
    default="10.0.1.0/24"
}

variable "public_availability_zone"{
    type = string
    default="us-west-1a"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key" {
  type    = string
  default = "Your AWS Key Name for the region"  
}

variable "ssh_location" {
  type        = string
  description = "My Public IP Address"
  default     = "1.2.3.432"
}

