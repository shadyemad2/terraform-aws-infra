resource "aws_lb" "public_alb" {
    name = "public-alb"
    load_balancer_type = "application"
    security_groups = [var.alb_sg_id]
    subnets = var.public_subnet_ids
    internal = false
    tags = {
      Name ="public_alb"
    }
}

resource "aws_lb_target_group" "proxy_target_group" {
    name = "proxy-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
      path = "/"
      protocol = "HTTP"
      matcher = 200
      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    tags = {
      Name ="proxy-target-group"
    }
}

resource "aws_lb_listener" "proxy_listener_http" {
    load_balancer_arn = aws_lb.public_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.proxy_target_group.arn
    }
  
}