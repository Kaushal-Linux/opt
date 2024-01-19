output "public_ip" {
    description = "Public Ip Of The EC2 Instance"
    value = aws_instance.Jenkins_EC2.public_ip
  
}