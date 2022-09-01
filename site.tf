# Provider spcific
provider "aws" {
    region = "${var.aws_region}"
}

# Variables for VPC module
module "vpc_subnets" {
	source = "./modules/vpc_subnets"
	name = "upgrad-project"
	environment = "dev"
	enable_dns_support = true
	enable_dns_hostnames = true
	vpc_cidr = "172.16.0.0/16"
        public_subnets_cidr = "172.16.10.0/24,172.16.20.0/24"
        private_subnets_cidr = "172.16.30.0/24,172.16.40.0/24"
        azs    = "us-east-1a,us-east-1b"
}

module "ec2key" {
	source = "./modules/ec2key"
	key_name = "aug-30"
        public_key ="${module.ec2key.ec2key_name}"
}



module "ssh_sg" {
	source = "./modules/ssh_sg"
	name = "upgrad-project"
	environment = "dev"
	vpc_id = "${module.vpc_subnets.vpc_id}"
	source_cidr_block = "0.0.0.0/0"
}

module "web_sg" {
	source = "./modules/web_sg"
	name = "upgrad-project"
	environment = "dev"
	vpc_id = "${module.vpc_subnets.vpc_id}"
	source_cidr_block = "0.0.0.0/0"
}

module "priv_sg" {
	source = "./modules/elb_sg"
	name = "upgrad-project"
	environment = "dev"
	vpc_id = "${module.vpc_subnets.vpc_id}"
}

module "ec2-public1" {
	source = "./modules/ec2"
	name = "bastion"
	environment = "dev"
	server_role = "web"
	ami_id = "ami-05fa00d4c63e32376"
	key_name = "${module.ec2key.ec2key_name}"
	count1 = "1"
	security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
	subnet_id = "${module.vpc_subnets.public_subnets_id}"
	instance_type = "t2.medium"
	user_data = "#!/bin/bash\napt-get -y update\napt-get -y install nginx\n"
}


module "ec2-private1" {
        source = "./modules/ec2"
        name = "jenkins"
        environment = "dev"
        server_role = "web"
        ami_id = "ami-08d4ac5b634553e16"
        key_name = "${module.ec2key.ec2key_name}"
        count1 = "1"
        security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
        subnet_id = "${module.vpc_subnets.private_subnets_id}"
        instance_type = "t2.micro"
        user_data = "#!/bin/bash\napt-get -y update\napt-get -y install nginx\n"
}

module "ec2-private2" {
        source = "./modules/ec2"
        name = "app-server"
        environment = "dev"
        server_role = "web"
        ami_id = "ami-08d4ac5b634553e16"
        key_name = "${module.ec2key.ec2key_name}"
        count1 = "1"
        security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
        subnet_id = "${module.vpc_subnets.private_subnets_id}"
        instance_type = "t2.micro"
        user_data = "#!/bin/bash\napt-get -y update\napt-get -y install nginx\n"
}




module "elb" {
	source = "./modules/elb"
	name = "upgrad-project"
	environment = "dev"
	security_groups = "${module.priv_sg.elb_sg_id}"
	availability_zones = "us-east-1a,us-east-1b"
	subnets = "${module.vpc_subnets.public_subnets_id}"
	instance_id = "${module.ec2-public1.ec2_id}"
}

