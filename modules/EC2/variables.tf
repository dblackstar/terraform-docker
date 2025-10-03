variable "subnet_id" {
  description = "ID of the subnet"
  type = string
}

variable "security_group_id" {
  description = "ID pf the security group"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "instance_name" {
  description = "Name of the instance"
  type = string
}

variable "ami_id" {
  description = "AMI of the EC2"
  type = string
}

variable "user_data" {
  description = "script to run on EC2 instance"
  type = string
}