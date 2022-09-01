resource "aws_security_group" "elb_sg" {
    name = "${var.name}-${var.environment}-priv"
    description = "Security Group ${var.name}-${var.environment}"
    vpc_id = "${var.vpc_id}"
    tags = {
      Name = "${var.name}-${var.environment}-elb"
      environment =  "${var.environment}"
    }
    # all access from security group

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }


  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.source_cidr_block}"]
  }
}

output "elb_sg_id" {
  value = "${aws_security_group.elb_sg.id}"
}
