# Output: ID de la instancia EC2
output "instance_id" {
  # Este output devuelve el identificador único (ID) de la instancia EC2 creada.
  value = aws_instance.main.id
}

# Output: Dirección IP pública de la instancia EC2
output "public_ip" {
  # Este output devuelve la dirección IP pública asignada automáticamente a la instancia EC2.
  value = aws_instance.main.public_ip
}
