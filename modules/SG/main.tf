# Crear un Security Group para permitir únicamente tráfico HTTPS entrante y todo el tráfico saliente.
# Este recurso asegura que la instancia asociada esté protegida y expuesta solo a conexiones seguras.

resource "aws_security_group" "https_only" {
  name   = "https_only_sg"  # Nombre del Security Group en AWS.
  vpc_id = var.vpc_id       # ID de la VPC donde se creará el Security Group.

  # Configuración de reglas de tráfico entrante (ingress).
  ingress {
    description = "Allow HTTPS traffic"  # Descripción de la regla.
    from_port   = 443                    # Puerto de inicio (443 para HTTPS).
    to_port     = 443                    # Puerto final (443 para HTTPS).
    protocol    = "tcp"                  # Protocolo TCP.
    cidr_blocks = ["0.0.0.0/0"]          # Permitir tráfico desde cualquier dirección IP (IPv4).
  }

  # Configuración de reglas de tráfico saliente (egress).
  egress {
    from_port   = 0                      # Permitir tráfico saliente desde cualquier puerto.
    to_port     = 0                      # Permitir tráfico saliente hacia cualquier puerto.
    protocol    = "-1"                   # Permitir todo tipo de tráfico (ICMP, TCP, UDP, etc.).
    cidr_blocks = ["0.0.0.0/0"]          # Permitir tráfico hacia cualquier dirección IP (IPv4).
  }

  # Etiquetas para identificar el recurso.
  tags = {
    Name = "https_only_sg"  # Etiqueta que asocia un nombre al Security Group.
  }
}
