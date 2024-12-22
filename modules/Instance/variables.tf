# Variable: ID de la VPC
variable "vpc_id" {
  description = "ID de la VPC para la instancia EC2"
  type        = string
}

# Variable: ID de la Subred Pública
variable "public_subnet_id" {
  description = "ID de la subred pública para la instancia EC2"
  type        = string
}

# Variable: IDs de Grupos de Seguridad
variable "security_group_ids" {
  description = "Lista de IDs de grupos de seguridad para la instancia"
  type        = list(string)
}

# Variable: Configuración de NAT
variable "is_nat" {
  description = "Indica si la instancia es un NAT (true o false)"
  type        = bool
  default     = false
}

# Variable: Nombre del Proyecto
variable "project_name" {
  description = "Nombre del proyecto para los recursos"
  type        = string
}
