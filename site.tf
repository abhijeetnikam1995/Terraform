# Provider spcific
# git updated from website
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
        name = "jenkins"
        environment = "dev"
        server_role = "web"
        ami_id = "ami-0a6b2839d44d781b2"
        key_name = "${module.ec2key.ec2key_name}"
        count1 = "1"
        security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
        subnet_id = "${module.vpc_subnets.public_subnets_id}"
        instance_type = "t2.medium"
        user_data = "${file("jenkins.sh")}"
}


module "ec2-public2" {
        source = "./modules/ec2"
        name = "sonar"
        environment = "dev"
        server_role = "web"
        ami_id = "ami-061dbd1209944525c"
        key_name = "${module.ec2key.ec2key_name}"
        count1 = "1"
        security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
        subnet_id = "${module.vpc_subnets.public_subnets_id}"
        instance_type = "t2.medium"
        user_data = "${file("sonar.sh")}"
}


module "ec2-public3" {
        source = "./modules/ec2"
        name = "eksctl"
        environment = "dev"
        server_role = "web"
        ami_id = "ami-0a6b2839d44d781b2"
        key_name = "${module.ec2key.ec2key_name}"
        count1 = "1"
        security_group_id = "${module.ssh_sg.ssh_sg_id},${module.web_sg.web_sg_id}"
        subnet_id = "${module.vpc_subnets.public_subnets_id}"
        instance_type = "t2.medium"
        user_data = "${file("installations.sh")}"
}



