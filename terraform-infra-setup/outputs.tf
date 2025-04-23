output "rds_endpoint" {
  value = module.rds_db_instance.rds_endpoint
}

output py_api_ec2_instance_public_ip {
    value = module.ec2-instance.py_api_ec2_instance_public_ip
}