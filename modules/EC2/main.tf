resource "aws_instace" "ec2_instance" {
    ami                     = var.ami_id
    instance_type           = var.instance_type
    vpc_security_groups_ids = [var.security_group_id]
    subnet_id               = var.subnet_id
    user_data               = var.user_data

    tags = {
        Name = var.instance_name
    }
}