variable "dnsname" {
  type = string
  description = "dns name variablization as per environment"
  
}


# DNS Registration 
resource "aws_route53_record" "vinos" {
  zone_id = data.aws_route53_zone.vinos.zone_id 
  name    = var.dnsname
  type    = "A"
  alias {
    name                   = module.nlb.dns_name
    zone_id                = module.nlb.zone_id
    evaluate_target_health = true
  }  
}