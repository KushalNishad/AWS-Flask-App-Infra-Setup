resource "aws_security_group" "ec2_sg_ssh_http" {
  name        = var.ec2_sg_name
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allows_ssh" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow remote SSH from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allows_http" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow HTTP request from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allows_https" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow HTTPS request from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "ec2_python_api_port_5000" {
  name        = var.ec2_sg_name_for_python_api
  description = "Enable the port 5000 for python api"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security Groups to allow 5000 port to access python api"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allows_5000_python_api" {
  security_group_id = aws_security_group.ec2_python_api_port_5000.id
  description       = "Allow 5000 port to access python api"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

resource "aws_security_group" "rds_mysql_sg" {
  name        = var.sg_name_for_rds
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security Groups to allow RDS from EC2 present in public subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_sg_pub1" {
  security_group_id = aws_security_group.rds_mysql_sg.id
  description       = "Allow access to RDS from EC2 present in public subnet 1"
  cidr_ipv4         = var.public_subnet_cidr_block[0]
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_sg_pub2" {
  security_group_id = aws_security_group.rds_mysql_sg.id
  description       = "Allow access to RDS from EC2 present in public subnet 2"
  cidr_ipv4         = var.public_subnet_cidr_block[1]
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

/*
resource "aws_vpc_security_group_ingress_rule" "rds_mysql_sg" {

    for_each          = toset(var.public_subnet_cidr_block)  
    # loop over the list using for_each as cidr_ipv4 allows only string and not a list

    security_group_id = aws_security_group.rds_mysql_sg.id
    description = "Allow access to RDS from EC2 present in public subnet"
    cidr_ipv4         = each.value
    from_port         = 3306
    ip_protocol       = "tcp"
    to_port           = 3306
}
*/
