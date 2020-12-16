module "echo-service" {
  source = "../../Resource_Build/EC2_build"
  region = "us-east-1"
  ami = "ami-04d29b6f966df1537"
  ec2_instance_type = "t2.micro"
  ec2_tier_type = "api.backend"
  app_port = "5000"
  app_protocl = "TCP"
  ec2_monitoring = true

  // Spread type placement group for redundancy and up to 7 EC2 instance per AZ.
  placement_group_name = "echo_service_app_pg"
  placement_group_strategy = "spread"
  sg_name = "echo_service_app_sg"

  // For redundancy and load issues
  desired_instances = "1"
  max_instances = "3"
  min_instances = "1"

  user_data_ec2 = base64encode(data.template_file.user_data_script.rendered)
}