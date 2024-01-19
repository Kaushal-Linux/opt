data "aws_ami" "AmazonLinux" {
    most_recent = true
    filter {
        name   = "name"
        values = ["Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
}

resource "aws_instance" "Master" {
    ami = data.aws_ami.AmazonLinux.id
    instance_type = "t2.medium"
    subnet_id = "subnet-04f5e9d84c3aaab37"
    vpc_security_group_ids = "sg-0eb420b594579783c"
    associate_public_ip_address = "true"
    
    provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx"
    ]
  }
    key_name = "Ethans"
    tags = {
      Name = "Master-kube"
    }
}