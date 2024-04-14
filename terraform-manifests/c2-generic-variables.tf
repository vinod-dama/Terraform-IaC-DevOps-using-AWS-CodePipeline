# Input Variables
# AWS Region
variable "aws_region" {
  description = "region in which aws instances needs to be spinned"
  type = string
  default = "us-east-1"
  
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "LOB" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "sap"
}

