
# ------------- Create Security Group for Web Server --------
resource "aws_security_group" "web-sg" {
  vpc_id      = aws_vpc.my-vpc.id
  description = "Allows HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups  = ["${aws_security_group.controller-sg.id}"]
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
# ------------- Create Security Group for Controller --------
resource "aws_security_group" "controller-sg" {
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