
#########################################################
#
####    MODULO QUE ARRANCA TODOS LOS SERVICIOS  
#
#########################################################

Provider "aws" {
    region = var.region
}

# DEPLOY VPC and networking

module "networking" {
	
	source = "./vpc"
	vpc_cidr = var.vpc_cidr
	public_cidr = var.public_cidr
	private_cidr = var.private_cidr
	accessip var.accessip
}


# DEPLOY FRONT END




# DEPLOY BACKEND-APP




# DEPLOY STORAGE







# END of Root MODULE 
