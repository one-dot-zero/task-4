resource "aws_security_group" "sg" {
  name        = "sg_nginx"
  description = "Allow traffic on 31555"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "inbound"
    from_port   = 31555
    to_port     = 31555
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}