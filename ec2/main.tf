// Configure the EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami                         = "mention ami name"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_name // use the already created key
  subnet_id                   = var.vpc.public_subnets 
  vpc_security_group_ids      = [var.sg_pub_id] // will be created separately

  tags = {
    "Name" = "ganesh-EC2-PUBLIC"
  }

  //SG for ec2 instance

  resource "aws_security_group" "allow_ssh_public" {
  name        = "ganesh-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from the internet"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ganesh-allow_ssh_pub"
  }
}