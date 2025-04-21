/* These input variables are placeholders for values that will be passed by the user
(via terraform.tfvars, CLI, or environment variable, or default values if specified)
In this case, the values will be provided from terraform.tfvars */

variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_private_subnet" {}
variable "cidr_public_subnet" {}
variable "us_availability_zone" {}