module "networking" {
  source               = "./modules/networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  cidr_private_subnet  = var.cidr_private_subnet
  us_availability_zone = var.us_availability_zone
}

module "security-groups" {
  source                     = "./modules/security-groups"
  vpc_id                     = module.networking.proj_py_api_vpc_id
  ec2_sg_name                = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  ec2_sg_name_for_python_api = "Allow port 5000 for rest-api"
  sg_name_for_rds            = "RDS sg"
  public_subnet_cidr_block   = tolist(module.networking.proj_py_api_public_subnets)
}

module "ec2-instance" {
  source                   = "./modules/ec2-instance"
  ami_id                   = var.ec2_ami_id
  instance_type            = "t2.medium"
  tag_name                 = "Ubuntu Linux EC2"
  public_key               = var.public_key
  subnet_id                = tolist(module.networking.proj_py_api_public_subnets_id)[0]
  sg_for_ec2_instance      = [module.security-groups.sg_ec2_ssh_http_id, module.security-groups.sg_py_api_5000] #From security-groups/outputs.tf
  enable_public_ip_address = true
  user_data_install_apache = templatefile("./modules/user-data-script/application-installer.sh", {})

}

module "lb_target_group" {
  source                   = "./modules/load-balancer-target-group"
  lb_target_group_name     = "flask-lb-target-group"
  lb_target_group_port     = 5000
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.proj_py_api_vpc_id
  ec2_instance_id          = module.ec2-instance.ec2_instance_id
}

module "alb" {
  source                          = "./modules/load-balancer"
  lb_name                         = "dev-flask-alb"
  is_external                     = false
  lb_type                         = "application"
  sg_enable_ssh_https             = [module.security-groups.sg_ec2_ssh_http_id, module.security-groups.sg_py_api_5000]
  subnet_ids                      = tolist(module.networking.proj_py_api_public_subnets_id)
  tag_name                        = "dev-flask-alb"
  lb_target_group_arn             = module.lb_target_group.dev_flask_lb_target_group_arn
  ec2_instance_id                 = module.ec2-instance.ec2_instance_id
  lb_listner_port                 = 80
  lb_listner_protocol             = "HTTP"
  lb_listner_default_action       = "forward"
  lb_https_listner_port           = 443
  lb_https_listner_protocol       = "HTTPS"
  lb_target_group_attachment_port = 5000
  certificate_arn                 = module.aws_ceritification_manager.dev_flask_acm_arn
}


module "hosted_zone" {
  source = "./modules/hosted-zone"
  # depends_on = [module.alb]  # Ensure this module runs after ALB is created
  domain_name     = var.domain_name
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id
}

module "aws_ceritification_manager" {
  source         = "./modules/certificate-manager"
  domain_name    = var.domain_name
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

module "rds_db_instance" {
  source                = "./modules/rds"
  db_subnet_group_name  = "dev_flask_rds_subnet_group"
  private_subnet_groups = tolist(module.networking.proj_py_api_private_subnets_id)
  rds_mysql_sg_id       = module.security-groups.sg_rds_mysql
  mysql_db_identifier   = "mydb"
  mysql_username        = var.mysql_username
  mysql_password        = var.mysql_password
  mysql_dbname          = "devprojdb"
}