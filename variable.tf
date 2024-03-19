variable "env" {

  default = "dev"
  type    = string

}

variable "instance_type" {

  default = "t2.micro"
  type    = string

}

variable "key_name" {

  default = "lamtech"
  type    = string

}

variable "subnet_ranges" {
  type = list(string)
  default = [ "subnet-08263c71360a4d479", "subnet-0a6d2304d5c83cec5", "subnet-0d5466f6bd46d7f35" ]
  
}


variable "subnet_id" {
  type = string
  default = "subnet-0d5466f6bd46d7f35"
}

variable "vpc_id" {
  type = string
  default = "vpc-048ab22d225dccc6b"
  
}

variable "zone_id" {
  type = string
  default = "Z06608133L7TF53XVG6X6"
}


variable "ebs_volume_size" {
  type = number
  default = 13
}

variable "root_volume_size" {
  type = number
  default = 10
}