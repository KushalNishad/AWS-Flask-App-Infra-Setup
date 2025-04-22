bucket_name = "dev-proj-1-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "11.0.0.0/16"
vpc_name             = "dev-proj-api-infra"
cidr_private_subnet  = ["11.0.1.0/24", "11.0.3.0/24"]
cidr_public_subnet   = ["11.0.2.0/24", "11.0.4.0/24"]
us_availability_zone = ["us-east-2a", "us-east-2b"]

ec2_ami_id                   = "ami-04f167a56786e4b09"
domain_name                  = "kushalnishad.com"

# Generate keypair with command <ssh-keygen -t rsa>
# Public key gets appeneded in .ssh/auth_keys file inside the instance.