resource "aws_lb" "alb" {
  name               = "ganesh"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id] //create SG for alb accordingly
  subnets            = aws_subnet.public.*.id
  enable_http2       = false
  enable_deletion_protection = true

  tags = {
    Name = "ganesh-alb"
  }
}

# Target group for the alb
resource "aws_lb_target_group" "alb_tg" {
  name     = "ganesh-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id //mention vpc ID
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

// for lambda attachment use this after creating the Load balancer

# Find the target group
data "aws_lb_target_group" "alb_tg" {
  name = "alb-tg"
}

# Attach lambda to the target group 
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = ${aws_alb_target_group.main.arn}"
  target_id        = ${aws_lambda_function.lambda.arn}"
  
}

// use this in the Load balancer .tf file if lambda is created in prior
resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = "${aws_alb_target_group.alb_tg.arn}"
  target_id        = "${aws_lambda_function.lambda.arn}"
  depends_on       = [] //mention lambda name here as depends_on
}


// add SG for alb

resource "aws_security_group" "alb" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol  = -1     //mention sg rules accordingly.
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-default-security-group"
  }
}