variable "region" {}
variable "placement_group_name" {}
variable "placement_group_strategy" {}
variable "ami" {}
variable "ec2_instance_type" {}
variable "ec2_monitoring" {
  type = bool
}
variable "ec2_tier_type" {}
variable "sg_name" {}
variable "app_port" {}
variable "app_protocl" {}
variable "user_data_ec2" {
}
variable "max_instances" {}
variable "min_instances" {}
variable "desired_instances" {}