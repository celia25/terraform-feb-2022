
resource "aws_instance" "web1" {
  ami           = "ami-03fa4afc89e4a8a09"
  instance_type = "t2.micro"

  tags = {
    Name = "Celia EC2"
  }
}



resource "aws_instance" "web2" {
  ami           = "ami-03fa4afc89e4a8a09"
  instance_type = "t2.micro"

  tags = {
    Name = "Celia EC2 2nd"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.web1.id
  vpc      = true
}

resource "aws_eip" "lb1" {
  instance = aws_instance.web2.id
  vpc      = true
}

resource "aws_elb" "bar" {
  name               = "celia-terraform-elb"
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.web1.id, aws_instance.web2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = var.timeout
  connection_draining         = true
  connection_draining_timeout = var.timeout

  tags = {
    Name = "foobar-terraform-elb"
  }
}
