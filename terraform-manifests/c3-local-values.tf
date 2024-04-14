# Define Local Values in Terraform
locals {
  owners = var.LOB
  env = var.environment
  name = "${var.LOB}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners = local.owners
    env = local.env
  }

    asg_tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = ""
      propagate_at_launch = true
    },
  ]
} 