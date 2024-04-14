# Terraform AWS Network Load Balancer (NLB)
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.8.0"
  
  name = "${local.name}-nlb"

  load_balancer_type               = "network"
  vpc_id                           = module.vpc.vpc_id
  dns_record_client_routing_policy = "availability_zone_affinity" 
  subnets            = module.vpc.public_subnets
  security_groups    = [ module.lb_sg.security_group_id ]

  # For example only
  enable_deletion_protection = false
  
  listeners = {
  #  TCP Listener 
     TCP_listner = {
       port     = 80
       protocol = "TCP"
       forward = {
         target_group_key = "mytg1"
      }
    }# End Listener-1: TCP Listener

     #  TLS Listener
     TLS_listner = {
       port            = 443
       protocol        = "TLS"
       certificate_arn = module.acm.acm_certificate_arn
       forward = {
         target_group_key = "mytg1"
       }
    }
  }
  # Target Groups 
   target_groups = {   
      mytg1 = {
        create_attachment = false  
        name_prefix          = "mytg1-"
        protocol             = "TCP"
        port                 = 80
        target_type          = "instance"
        deregistration_delay = 10
        health_check = {
          enabled             = true
          interval            = 30
          path                = "/app1/index.html"
          port                = "traffic-port"
          healthy_threshold   = 3
          unhealthy_threshold = 3
          timeout             = 6
       }
     }
    }
   tags = local.common_tags  
}