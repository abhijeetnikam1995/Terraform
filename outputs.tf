output "vpc_id" {
  value = "${module.vpc_subnets.vpc_id}"
}

output "public_subnets_id" {
  value = "${module.vpc_subnets.public_subnets_id}"
}

output "private_subnets_id" {
  value = "${module.vpc_subnets.private_subnets_id}"
}

output "ssh_sg_id" {
  value = "${module.ssh_sg.ssh_sg_id}"
}

output "web_sg_id" {
  value = "${module.web_sg.web_sg_id}"
}

output "priv_sg_id" {
  value = "${module.priv_sg.elb_sg_id}"
}


output "elb_dns_name" {
  value = "${module.elb.elb_dns_name}"
}

/*
output "ec2key_name" {
  value = "${module.ec2key.ec2key_name}"
}

*/
output "ec2_pub_id1" {
  value = "${module.ec2-public1.ec2_id}"
}
/*
output "ec2_pri_id1" {
  value = "${module.ec2-private1.ec2_id}"
}

output "ec2_pri_id2" {
  value = "${module.ec2-private2.ec2_id}"
}

*/
