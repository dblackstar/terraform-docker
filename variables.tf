variable "instance_type" {
  description = "the EC2 instance type"
  type        = string
}

variable "ami" {
  description = "the AMI of the EC2 instance"
  type        = string
}

variable "region" {
  description = "region of the AWS account"
  type        = string
}

variable "availability_zone" {
  description = "the availability zone for the resources"
  type        = string
}

variable "prefix" {
  description = "prefix for the resources"
  type        = string
}

variable "cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "local_ip" {
  description = "my local IP"
  type        = list(string)
}

variable "bucket_name" {
  description = "Bucket name"
  type        = string
}