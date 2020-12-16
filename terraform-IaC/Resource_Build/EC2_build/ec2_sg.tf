resource "aws_security_group" "echo_service_sg" {
  name = var.sg_name
  vpc_id = data.aws_vpc.default.id
  tags = {
    tier = var.ec2_tier_type
  }
}

resource "aws_security_group_rule" "inbound_allow_app_port" {
  description = "Allowing Port 5000 from all over the world"
  type = "ingress"
  from_port = var.app_port
  protocol = var.app_protocl
  to_port = var.app_port
  security_group_id = aws_security_group.echo_service_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.echo_service_sg.id
}