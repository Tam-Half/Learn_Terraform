variable "public_azs" {
    type    = list(string)
 
}

variable "private_azs" {
    type    = list(string)
    default = ["ap-southeast-1a", "ap-southeast-1b"]
    
}
variable "aws_name_vpc" {
    description = "Name of VPC main"
    type = string
}

