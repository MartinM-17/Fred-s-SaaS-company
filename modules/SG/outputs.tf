# Output para obtener el ID del Security Group creado.
# Este bloque muestra el ID del Security Group, lo cual es útil para referenciarlo
# en otros recursos o para consultar detalles en la consola de AWS.

output "sg_id" {
  value = aws_security_group.https_only.id  # Obtiene el ID del Security Group 'https_only'.
  
  # Este valor puede ser utilizado en otros módulos o scripts para asociar el Security Group a
  # instancias EC2, ELBs, o cualquier otro recurso que necesite ser configurado con un Security Group.
}
