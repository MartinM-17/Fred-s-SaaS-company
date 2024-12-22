# Variable para especificar el ID de la VPC donde se asociará el Security Group.
# Este parámetro es crucial para asegurar que el Security Group se cree en la VPC correcta.

variable "vpc_id" {
  description = "VPC ID to associate with the security group"  # Descripción de la variable.
  type        = string  # Tipo de dato: cadena de texto (string).
}
