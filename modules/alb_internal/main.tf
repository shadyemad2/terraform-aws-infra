resource "aws_alb" "private_alb" {
    name = "private-alp"
    load_balancer_type = "application"
    security_groups = [var.alb_id_sg]
    subnets = var.private_subnets_ids
    internal = true
    tags = {
      Name ="private_alp"
    }
}

resource "aws_lb_target_group" "backend_target_group" {
    name = "backend-target-group"
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
      Name ="backend-target-group"
    }
}

resource "aws_lb_listener" "backend_listener_http" {
    load_balancer_arn = aws_alb.private_alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.backend_target_group.arn
    }
    
  
}

