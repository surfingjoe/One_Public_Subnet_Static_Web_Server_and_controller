
resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.my-vpc.id
  description = "Allows HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks  = ["10.0.1.0/24"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_location}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name  = "SecurityGroup-Web"
    Stage = "Test"
  }
}

resource "aws_security_group" "controller" {
  vpc_id      = aws_vpc.my-vpc.id
  description = "Allows SSH from MyIP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_location}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "SecurityGroup-SSH"
    Stage = "Test"
  }
}