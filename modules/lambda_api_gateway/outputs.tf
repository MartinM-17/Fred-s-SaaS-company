# Output para obtener la URL de la API Gateway desplegada.
# Este bloque genera la URL completa de la API Gateway, incluyendo el ID de la API,
# la región, y el nombre del stage configurado.
output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.main.stage_name}"

  # La URL construida permite acceder directamente al endpoint de la API desplegada.
  # Ejemplo de salida: https://<api-id>.execute-api.us-east-1.amazonaws.com/prod
}

# Declaración de la variable 'region', utilizada para definir la región de AWS.
variable "region" {
  type    = string  # Tipo de la variable: cadena de texto.
  default = "us-east-1"  # Valor por defecto: la región 'us-east-1'.

  # Esta variable permite flexibilidad en el despliegue, ya que puedes sobreescribirla
  # al ejecutar Terraform con un archivo de variables o parámetros.
}
