# ------------- set provider and region ----------------------------
provider "aws" {
  region = var.region
}

#--------- Get Ubuntu 20.04 AMI image for the region ----------------
data "aws_ssm_parameter" "ubuntu-focal" {
  name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

# Creating Web server
resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.ubuntu-focal.value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-1.id
  vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
  iam_instance_profile   = "${aws_iam_instance_profile.assume_role_profile.name}" 
  key_name               = var.key
  user_data = file("bootstrap_web.sh")
  tags = {
    Name  = "Basic-Web-Server"
    Stage = "Test"
  }
}

# Creating controller node
resource "aws_instance" "controller" {
  ami                    = data.aws_ssm_parameter.ubuntu-focal.value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-1.id
  vpc_security_group_ids = ["${aws_security_group.controller-sg .id}"]
  user_data              = file("bootstrap_controller.sh")
  key_name               = var.key

  tags = {
    Name = "Controller"
    Stage = "Test"
  }
}

output "web" {
  value = [aws_instance.web.public_ip, aws_instance.web.private_ip]
}

output "Controller" {
  value = [aws_instance.controller.public_ip]
}