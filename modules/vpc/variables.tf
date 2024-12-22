# Variable para el nombre de la VPC
# Esta variable permite especificar el nombre de la VPC que se está creando, lo que facilita su identificación.
variable "vpc_name" {
  description = "Name for the VPC"  # Descripción de la variable, explica su propósito.
  type        = string  # El tipo de la variable es una cadena de texto (string).
  default     = "SaaS_NAT_VPC"  # Valor por defecto: si no se proporciona un valor explícito, se usará "SaaS_NAT_VPC".
}
