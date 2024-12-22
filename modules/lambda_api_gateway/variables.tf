# Variable para definir el nombre del proyecto.
# Se utiliza para nombrar recursos de manera consistente en AWS.
variable "project_name" {
  description = "Project name for resource naming"  # Descripción de la variable.
  type        = string  # Tipo de dato: cadena de texto.
}

# Variable para especificar el manejador de la función Lambda.
# El manejador define el punto de entrada de la función Lambda.
variable "lambda_handler" {
  description = "Handler for the Lambda function"  # Descripción de la variable.
  type        = string  # Tipo de dato: cadena de texto.
  default     = "index.handler"  # Valor por defecto: archivo `index.js` y función `handler`.
}

# Variable para configurar el entorno de ejecución de Lambda.
# Esto determina el lenguaje y la versión del entorno en el que se ejecutará la función.
variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"  # Descripción de la variable.
  type        = string  # Tipo de dato: cadena de texto.
  default     = "nodejs18.x"  # Valor por defecto: Node.js versión 18.x.
}

# Variable para especificar la ruta al paquete de despliegue de Lambda.
# Este paquete debe contener el código fuente de la función y sus dependencias.
variable "lambda_file" {
  description = "Path to the Lambda deployment package"  # Descripción de la variable.
  type        = string  # Tipo de dato: cadena de texto.
}
