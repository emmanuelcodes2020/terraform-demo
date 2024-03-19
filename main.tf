locals {
  name = "major-application"
}

resource "aws_instance" "major-app" {
  ami                  = "ami-093cb9fb2d34920ad"
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_id            = var.subnet_id
  //count                = 1
  security_groups      = [aws_security_group.major_application_sg.id]
  //user_data            = file("${path.module}/docker-compose-userdata.sh")
  iam_instance_profile = aws_iam_instance_profile.iam_profile.id



  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
    tags = {

      Name = "${local.name}-root-volume"
    }
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = var.ebs_volume_size
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
    tags = {

      Name = "${local.name}-ebs-volume"
    }
  }


  tags = {

    //Name = "major-application-${count.index + 1}.${var.env}"
    Name = "${local.name}-1.dev"

  }

}

# resource "aws_ebs_volume" "root" {
#   availability_zone = "eu-west-2a"
#   size              = 13

#   tags = {
#     Name = "root-volume"
#   }

# }


# resource "aws_ebs_volume" "additional" {
#   availability_zone = "eu-west-2a"
#   size              = 14

#   tags = {
#     Name = "extra-volume"
#   }

# }