#################### variables de region

variable "region" {
     default = "eu-west-1"
}

variable "availabilityZone" {
     default = "eu-west-1a"
}

variable "availabilityZoneb" {
     default = "eu-west-1b"
}


################## variables de networking





variable "dnsSupport" {
    default = true
}

variable "dnsHostNames" {
    default = true
}

variable "vpcCIDRblock" {
    default = "10.100.16.0/22"
}

variable "subnetCIDRblockprivada1a" {
    default = "10.100.16.0/24"
}

variable "subnetCIDRblockprivada1b" {
    default = "10.100.17.0/24"
}

variable "subnetCIDRblockpublica1a" {
    default = "10.100.18.0/24"
}

variable "subnetCIDRblockpublica1b" {
    default = "10.100.19.0/24"
}

variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}

variable "ingressCIDRblock" {
    type = "list"
    default = [ "0.0.0.0/0" ]
}

variable "egressCIDRblock" {
    type = "list"
    default = [ "0.0.0.0/0" ]
}

variable "mapPublicIP" {
    default = false
}

variable "mapPublicIPt" {
    default = true
}



######################## VARIABLES de Instancias

variable "ami" {
   description = "lista de AMIs utilizadas"
   type = "map"
}

variable "instance_type_dev" {
   default = "r4.xlarge"
}

variable "key" {
   description = "public_ssh_key"
   type = "string"
}

variable "instanceTenancy" {
    default = "default"
}

variable "typedisk" {
	default = "gp2"
} 

variable "keyname" {
	default = "Oracle_dev"
} 


# end of variables.tf
