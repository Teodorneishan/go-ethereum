resource "aws_security_group" "worker_group_one" {
  name_prefix = "worker_group_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/16"
    ]
  }
  ingress {
    from_port = 30304
    to_port   = 30304
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"] #
  }

  ingress {
    from_port = 8552
    to_port   = 8552
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port = 8553
    to_port   = 8553
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

