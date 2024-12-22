# Recurso: aws_cognito_user_pool
resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}_user_pool"  # Nombre del user pool basado en el nombre del proyecto

  # Política de contraseñas
  password_policy {
    minimum_length    = 8         # Longitud mínima de la contraseña
    require_lowercase = true      # Requiere al menos una letra minúscula
    require_numbers   = true      # Requiere al menos un número
    require_symbols   = true      # Requiere al menos un símbolo
    require_uppercase = true      # Requiere al menos una letra mayúscula
  }

  # Etiquetas para identificar el recurso
  tags = {
    Name = "${var.project_name}_user_pool"  # Etiqueta con el nombre del proyecto
  }
}

# Recurso: aws_cognito_user_pool_client
resource "aws_cognito_user_pool_client" "main" {
  name         = "${var.project_name}_user_pool_client"  # Nombre del cliente del user pool basado en el nombre del proyecto
  user_pool_id = aws_cognito_user_pool.main.id  # Asociando el user pool al cliente

  # Flujos de autenticación explícitos permitidos
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]  # Permite la autenticación por contraseña de usuario y el uso de tokens de refresco
}
