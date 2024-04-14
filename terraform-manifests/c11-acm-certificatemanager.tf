# ACM Module - To create and Verify SSL Certificates
/*
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id      = data.aws_route53_zone.mydomain.zone_id 

  subject_alternative_names = [
    "*.devopsincloud.com"
  ]
  tags = local.common_tags
}
*/

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = trimsuffix(data.aws_route53_zone.vinos.name, ".")
  zone_id      = data.aws_route53_zone.vinos.zone_id 

  validation_method = "DNS"

  subject_alternative_names = [
    var.dnsname
  ]

  wait_for_validation = true

  tags = local.common_tags

}

# Output ACM Certificate ARN
output "this_acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}



