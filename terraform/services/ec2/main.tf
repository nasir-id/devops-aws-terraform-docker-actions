data "aws_partition" "current" {}

resource "aws_instance" "webapp_server" {
  ami                    = "ami-0c1907b6d738188e5" 
  instance_type          = "t2.micro"
  subnet_id              = data.terraform_remote_state.subnet.outputs.subnet_id
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  iam_instance_profile   = aws_iam_instance_profile.webapp.name
  availability_zone           = "ap-southeast-1a"
  user_data = file("user_data.sh")
  root_block_device {
      volume_size           = 50
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
  }
}

resource "aws_iam_role" "webapp" {

  name        = "webapp_ssm_role"
  description = "SSM Role for webapp Instance"

  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true

}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.webapp.name 
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "webapp" {
  role = aws_iam_role.webapp.name
  name        = "webapp_ssm_role"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "assume_role_policy" {

  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "http from anywhere"
    from_port   = 80
    to_port     = 80
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
    Name = "allow_http"
  }
}

