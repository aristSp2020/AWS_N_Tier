######
# EC2 instances
######

resource "aws_instance" "saperpdes" {

  ami                    = "${var.ami["oracle7"]}"
  instance_type          = "${var.instance_type_dev}"
  subnet_id              = "${aws_subnet.VPC_Subnet_Privada_1a.id}"
  key_name               = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.VPC_Security_Group_Privada.id}"]

  tags = {
	Name = "saperpdes"
  } 
}

resource "aws_ebs_volume" "ebs_so" {
  availability_zone = "${var.availabilityZone}"
  size              = 100
  type		= "${var.typedisk}"

  tags = {
    Name = "ebs_so"
  }
}

resource "aws_ebs_volume" "ebs_bbdd" {
  availability_zone = "${var.availabilityZone}"
  size              = 475
  type		= "${var.typedisk}"

  tags = {
    Name = "ebs_bbdd"
  }
}

resource "aws_ebs_volume" "ebs_sap" {
  availability_zone = "${var.availabilityZone}"
  size              = 30
  type		= "${var.typedisk}"

  tags = {
    Name = "ebs_sap"
  }
}

resource "aws_volume_attachment" "ebs_att_so" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.ebs_so.id}"
  instance_id = "${aws_instance.saperpdes.id}"
}

resource "aws_volume_attachment" "ebs_att_bbdd" {
  device_name = "/dev/xvdc"
  volume_id   = "${aws_ebs_volume.ebs_bbdd.id}"
  instance_id = "${aws_instance.saperpdes.id}"
}

resource "aws_volume_attachment" "ebs_att_sap" {
  device_name = "/dev/xvdd"
  volume_id   = "${aws_ebs_volume.ebs_sap.id}"
  instance_id = "${aws_instance.saperpdes.id}"
}


