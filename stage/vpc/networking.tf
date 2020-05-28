#################################################################################
# Networking
#
#################################################################################


data "aws_availability_zones" "available" {}


# create the VPC

resource "aws_vpc" "VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

tags{
  Name = "Main_VPC"
  }

} # end resource

# create the Subnet Privada 1a

resource "aws_subnet" "VPC_Subnet_Privada_1a" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnetCIDRblockprivada1a
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZonea

tags = {
  Name = "Subnet_privada1a"
  }

} # end resource


# create the Subnet Privada 1b

resource "aws_subnet" "VPC_Subnet_Privada_1b" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnetCIDRblockprivada1b
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZoneb

tags = {
  Name = "Subnet_privada1b"
  }

} # end resource


# create the Subnet Publica 1a

resource "aws_subnet" "VPC_Subnet_Publica_1a" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnetCIDRblockpublica1a
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZonea


  tags = {
    Name = "Subnet_publica1a"
  }

} # end resource


# create the Subnet Publica 1b

resource "aws_subnet" "VPC_Subnet_Publica_1b" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.subnetCIDRblockpublica1b
  map_public_ip_on_launch = var.mapPublicIPt
  availability_zone       = var.availabilityZoneb

tags = {
  Name = "Subnet_publica1b"
  }

} # end resource


# Create the Elastic Ips for the Nat Gateways

resource "aws_eip" "nat1" {
  vpc      = true
}

resource "aws_eip" "nat2" {
  vpc      = true
}


# Create the Security Group

resource "aws_security_group" "VPC_Security_Group_Privada" {
  vpc_id       = aws_vpc.VPC.id
  name         = "Security Group_SAP_DEV Privada"
  description  = "Grupo Seguridad SAP Desarrollo Privada"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = ["10.100.3.135/32"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
     Name = "Security Group_SAP_DEV"
     Description = "Grupo Seguridad SAP Desarrollo"
  }

} 
# end resource


# create VPC Network access control list

resource "aws_network_acl" "VPC_Security_ACL" {
  vpc_id = aws_vpc.VPC.id

  # allow ingress all ports
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  # allow egress all ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0 
    to_port    = 0
  }
}


# Create the Internet Gateway

resource "aws_internet_gateway" "VPC_GW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "My VPC Internet Gateway"
  }
} # end resource


# Create the Nat Gateway az1

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.VPC_Subnet_Publica_1a.id

  tags = {
    Name = "gw NAT az1"
  }
}


# Create the Nat Gateway az2

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.VPC_Subnet_Publica_1b.id

  tags = {
    Name = "gw NAT az2"
  }
}


# Create the Route Table

resource "aws_route_table" "VPC_route_table" {
  vpc_id = aws_vpc.VPC.id
  
  tags = {
    Name = "VPC Route Table"
  }
}
# end resource


# Create the Route Table for private subnet 1A

resource "aws_route_table" "VPC_route_table_priv" {
  vpc_id = aws_vpc.VPC.id}

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
    }

  tags = {
        Name = "VPC Route Table private subnet 1A "
  }
} # end resource

# Create the Route Table for private subnet 1B

resource "aws_route_table" "VPC_route_table_priv2" {
  vpc_id = aws_vpc.VPC.id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat_gw_az2.id}"
    }

  tags = {
        Name = "VPC Route Table private subnet 1b "
  }
} # end resource





# Create the Internet Access

resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.VPC_GW.id
} # end resource


# Associate the Route Table with the Subnet

resource "aws_route_table_association" "My_VPC_association_Privada_1a" {
  subnet_id      = aws_subnet.VPC_Subnet_Privada_1a.id
  route_table_id = aws_route_table.VPC_route_table_priv.id
} # end resource


resource "aws_route_table_association" "My_VPC_association_Privada_1b" {
  subnet_id      = aws_subnet.VPC_Subnet_Privada_1b.id
  route_table_id = aws_route_table.VPC_route_table_priv2.id
} # end resource


resource "aws_route_table_association" "My_VPC_association_Publica_1a" {
  subnet_id      = aws_subnet.VPC_Subnet_Publica_1a.id
  route_table_id = aws_route_table.VPC_route_table.id
} # end resource


resource "aws_route_table_association" "My_VPC_association_Publica_1b" {
  subnet_id      = aws_subnet.VPC_Subnet_Publica_1b.id
  route_table_id = aws_route_table.VPC_route_table.id
} # end resource


# end vpc.tf

