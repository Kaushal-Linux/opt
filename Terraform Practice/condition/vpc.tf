resource "aws_vpc" "myprod" {
    cidr_block = "10.10.0.0/16"
    count = var.istest == "true" ? 1:0
}

resource "aws_vpc" "mydev" {
    cidr_block = "20.20.0.0/16"
    count = var.istest == "false" ? 1:0
}
variable "istest" {}