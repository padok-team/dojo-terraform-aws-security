
// Random string so each student can find its resources
resource "random_string" "unique_id" {
  length  = 8
  special = false
}


// Create a SSH key pair to connect to the instances
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${random_string.unique_id.id}-${var.environment}-keypair"
  public_key = tls_private_key.private_key.public_key_openssh

}

// Define the image that will be used by the instances
data "aws_ami" "webserver_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}
/*
PRODUCTION ENVIRONMENT
*/

// An instance is a virtual machine on AWS

resource "aws_instance" "webserver" {

  // Define the image
  ami           = data.aws_ami.webserver_ami.id

  // Define the type of instance. t2.micro is a small machine
  instance_type = "t2.micro"

  // Define the SSH key pair
  key_name                    = aws_key_pair.key_pair.key_name

  // Create a public IP adress for the instance
  associate_public_ip_address = true

  // Define a bash script that will be executed at boot
  user_data = templatefile(
    "./web/install_apache.sh.tpl",
    {
      environment = "${var.environment}"
    }
  )

  // Define in which subnet the instance is
  subnet_id         = module.vpc.private_subnets[0]

  // Define which security group is associated to the instance
  vpc_security_group_ids = [
    aws_security_group.allow_priv.id
  ]
}

resource "aws_lb" "webserver_lb" {
  name               = "${random_string.unique_id.id}-${var.environment}-webserver-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_pub.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false
}
resource "aws_lb_target_group" "webserver_lb_tg" {
  name     = "${random_string.unique_id.id}-${var.environment}-webserver-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "webserver_lb_listener" {  
  load_balancer_arn = "${aws_lb.webserver_lb.arn}"  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_lb_target_group.webserver_lb_tg.arn}"
    type             = "forward"  
  }
}

resource "aws_lb_target_group_attachment" "webserver_lb_tg_attachment" {
  target_group_arn = "${aws_lb_target_group.webserver_lb_tg.arn}"
  target_id        = "${aws_instance.webserver.id}"  
  port             = 80
}
