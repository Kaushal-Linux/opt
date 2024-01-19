resource "aws_instance" "Jenkins_EC2" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  subnet_id = "subnet-04f5e9d84c3aaab37"
  vpc_security_group_ids = ["sg-0eb420b594579783c"]
  associate_public_ip_address = "true"
  key_name = "Ethans"
  user_data = <<EOF

#!/bin/bash

sudo apt update
sudo apt install openjdk-11-jdk -y
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update 
sudo apt install jenkins
sudo systemctl enable --now jenkins

EOF
  tags = {
    Name = "Jenkins"
  }
  
}