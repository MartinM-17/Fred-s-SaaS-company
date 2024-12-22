resource "aws_instance" "main" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 Free Tier
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.is_nat ? "nat_instance" : "app_instance"
  }

  # Configuración condicional de user_data para NAT Instance
  user_data = var.is_nat ? file("${path.module}/nat_instance_user_data.sh") : null

  # Asociar a los security groups especificados
  vpc_security_group_ids = var.security_group_ids
}
