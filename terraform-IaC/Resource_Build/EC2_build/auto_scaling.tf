resource "aws_launch_template" "echo_service_template" {
  name = "echo-service-lt"

  image_id = var.ami
  instance_type = var.ec2_instance_type
  placement {
    group_name = var.placement_group_name
  }
  monitoring {
    enabled = var.ec2_monitoring
  }
  tags = {
    tier = var.ec2_tier_type
  }
  vpc_security_group_ids = [aws_security_group.echo_service_sg.id]
  user_data =var.user_data_ec2
  depends_on = [aws_security_group.echo_service_sg]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "echo_service_asg" {
  max_size            = var.max_instances
  min_size            = var.min_instances
  desired_capacity    = var.desired_instances
  vpc_zone_identifier = data.aws_subnet_ids.all.ids
  launch_template {
    name = aws_launch_template.echo_service_template.name
  }
}