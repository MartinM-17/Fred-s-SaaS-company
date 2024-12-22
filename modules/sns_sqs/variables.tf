# Definición de la variable 'project_name', que se utiliza para nombrar los recursos de AWS.
# Esta variable facilita la personalización de los nombres de los recursos creados en AWS
# y permite un enfoque coherente y flexible para la creación de recursos dentro de un proyecto.

variable "project_name" {
  description = "Project name for resource naming"  # Descripción de la variable que explica su uso.
  type        = string  # El tipo de dato es 'string', es decir, una cadena de texto.
}
