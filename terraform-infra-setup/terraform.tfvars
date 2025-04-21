bucket_name = "dev-proj-1-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "11.0.0.0/16"
vpc_name             = "dev-proj-api-infra"
cidr_private_subnet  = ["11.0.1.0/24", "11.0.3.0/24"]
cidr_public_subnet   = ["11.0.2.0/24", "11.0.4.0/24"]
us_availability_zone = ["us-east-1a", "us-east-1b"]

ec2_ami_id                   = "ami-04b4f1a9cf54c11d0"
ec2_user_data_install_apache = ""
domain_name                  = "kushalnishad.com"

# Generate keypair with command <ssh-keygen -t rsa>
# Below public key gets appeneded in .ssh/auth_keys file inside the instance.
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqYiRkAYEcxUKt66K5jTz0FHX4UrElmEgZJUtGz6aRxJwX6F4kzoRMm+38/uqR+IJAFsR9NpXW+VPCSlJivlBw3970s/c1C1apPwA/JkVmWWJ2VNmVGcZ5Yf+/vMnoO3LR1Deztt4WcnYi/gxsLoLIIX9bLCxUn6OL6vq3mrGXHZju/tjMWT8tmQsJyPZTUIbqmc79lijRIRUdvS46ta/gZGGtqJsbggGg+sVazrGnomcuXtAGR98S0crt9NL0rxUGICQVRVvD45JVVhf46FZnHpwRT+m3OdGBzFgYQ+o7CU+m7Ie4G9EkSunetNsZZDuTE3P/ATE/Hb0sBGgKaSSEVKuZyY7yWTYdX4k/LJLpQTB8fp1N8IqUUy5bGQGS1r8EDUyYyTkRvdQZbBaRijerTAeVAQxsMWjbkFWQErUCbwtkqDxZ/HyRjUQViiPqvmq8iUETiIuI3HZmRdkJY4+k2NW9pClCfIWhLmkiv4c6KUEfPFiaozSmU1iisrUfvOE= kushal@Kushal"