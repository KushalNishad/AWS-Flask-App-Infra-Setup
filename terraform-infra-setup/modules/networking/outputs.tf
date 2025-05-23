output "proj_py_api_vpc_id" {
  value = aws_vpc.proj_python_flask_api.id
}

output "proj_py_api_public_subnets" {
  value = aws_subnet.proj_py_api_public_subnets.*.cidr_block
}

output "proj_py_api_public_subnets_id" {
  value = aws_subnet.proj_py_api_public_subnets.*.id
}

output "proj_py_api_private_subnets_id" {
  value = aws_subnet.proj_py_api_private_subnets.*.id
}