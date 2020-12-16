provider "aws" {
  region = var.region
}

resource "aws_placement_group" "echo_service_pg" {
  name = var.placement_group_name
  strategy = var.placement_group_strategy
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.ec2_instance_type
  monitoring = var.ec2_monitoring
  placement_group = aws_placement_group.echo_service_pg.name
  depends_on = [aws_placement_group.echo_service_pg]
  user_data = join("", list(var.user_data_ec2))
  vpc_security_group_ids = [aws_security_group.echo_service_sg.id]

  tags = {
    tier = var.ec2_tier_type
  }
}
