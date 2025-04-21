resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  associate_public_ip_address = var.enable_public_ip_address
  instance_type               = var.instance_type
  security_groups             = var.sg_for_ec2_instance
  subnet_id                   = var.subnet_id
  user_data                   = var.user_data_install_apache
  key_name                    = "aws_ec2_terraform"

  tags = {
    Name = var.tag_name
  }
}

resource "aws_key_pair" "ssh-keypair" {
  key_name   = "aws_ec2_terraform"
  public_key = var.public_key
}
