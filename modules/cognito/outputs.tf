# Output: user_pool_id
output "user_pool_id" {
  value = aws_cognito_user_pool.main.id  # Devuelve el ID del User Pool creado
}

# Output: user_pool_client_id
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.main.id  # Devuelve el ID del Client del User Pool creado
}
