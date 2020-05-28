
##### variables generales

variable "aws_region" {}


###### storage varibles



###### networking variables


variable "vpc_cidr" {}
variable "public_cidrs" {
	type = list
}
variable "private_cidrs" {
	type = list
}
variable "accessip" {}

