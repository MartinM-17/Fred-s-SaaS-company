# Salida del ID de la VPC creada
# Esto permite obtener el ID de la VPC que se ha creado en este módulo para usarlo en otros módulos o recursos.
output "vpc_id" {
  value = aws_vpc.main.id  # El ID de la VPC creada se asigna como valor de esta salida.
}

# Salida de los IDs de las subredes públicas
# Esto devolverá una lista de los IDs de las subredes públicas creadas en la VPC.
output "public_subnet_ids" {
  value = aws_subnet.public[*].id  # Usamos la expansión de lista para obtener los IDs de todas las subredes públicas creadas.
}
