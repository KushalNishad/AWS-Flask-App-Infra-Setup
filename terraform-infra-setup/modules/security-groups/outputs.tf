output "sg_ec2_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "sg_py_api_5000" {
  value = aws_security_group.ec2_python_api_port_5000.id
}

output "sg_rds_mysql" {
  value = aws_security_group.rds_mysql_sg.id
}