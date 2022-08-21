# data "aws_instance" "foo" {

#   filter {
#     name   = "tag:Stage"
#     values = ["Now"]
#   }
# }

######
# ELB
######
                                                # module "elb" {
                                                # source          = "terraform-aws-modules/elb/aws"

                                                # name            = "elb-example"

                                                # subnets         = module.vpc.private_subnets
                                                # security_groups = [module.eks.cluster_security_group_id]
                                                # internal        = false

                                                # listener = [
                                                #     {
                                                #     instance_port     = "8000"
                                                #     instance_protocol = "http"
                                                #     lb_port           = "8000"
                                                #     lb_protocol       = "http"

                                                #     #            Note about SSL:
                                                #     #            This line is commented out because ACM certificate has to be "Active" (validated and verified by AWS, but Route53 zone used in this example is not real).
                                                #     #            To enable SSL in ELB: uncomment this line, set "wait_for_validation = true" in ACM module and make sure that instance_protocol and lb_protocol are https or ssl.
                                                #     #            ssl_certificate_id = module.acm.acm_certificate_arn
                                                #     },
                                                # ]

                                                # health_check = {
                                                #     target              = "HTTP:8000/api/v1/healthz"
                                                #     interval            = 6
                                                #     healthy_threshold   = 2
                                                #     unhealthy_threshold = 2
                                                #     timeout             = 5
                                                # }

                                                # tags = {
                                                #     Owner       = "user"
                                                #     Environment = "dev"
                                                # }

                                                # # ELB attachments
                                                # #   number_of_instances = 2
                                                # instances           = ["i-021d15b0d2a676205"]
                                                # }




# Production Load Balancer
resource "aws_lb" "production" {
  name               = "django-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.all_worker_mgmt.id]
  subnets            = module.vpc.public_subnets
}

# Target group
resource "aws_alb_target_group" "default-target-group" {
  name     = "django-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/api/v1/healthz"
    port                = "8000"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
  }
}

# # Listener (redirects traffic from the load balancer to the target group)
# resource "aws_alb_listener" "ecs-alb-http-listener" {
#   load_balancer_arn = aws_lb.production.id
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.certificate_arn
#   depends_on        = [aws_alb_target_group.default-target-group]

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.default-target-group.arn
#   }
# }
