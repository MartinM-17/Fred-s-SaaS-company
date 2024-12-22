# Outputs para la VPC
output "vpc_id" {
  value = module.vpc.vpc_id
  description = "ID de la VPC creada en el módulo VPC."
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
  description = "Lista de IDs de las subredes públicas creadas en la VPC."
}

# Output para el Security Group
output "sg_id" {
  value = module.security_group.sg_id
  description = "ID del Security Group creado en el módulo SG."
}

# Outputs para la instancia EC2
output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
  description = "ID de la instancia EC2 creada en el módulo Instance."
}

output "ec2_public_ip" {
  value = module.ec2_instance.public_ip
  description = "Dirección IP pública de la instancia EC2."
}

# Output para la URL del API Gateway
output "api_gateway_url" {
  value = module.lambda_api_gateway.api_gateway_url
  description = "URL pública del API Gateway vinculado a la función Lambda."
}

# Outputs para SNS y SQS
output "sns_topic_arn" {
  value = module.sns_sqs.sns_topic_arn
  description = "ARN del tópico SNS creado en el módulo SNS+SQS."
}

output "sqs_queue_url" {
  value = module.sns_sqs.sqs_queue_url
  description = "URL de la cola SQS creada en el módulo SNS+SQS."
}

# Outputs para Cognito
output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
  description = "ID del User Pool de Cognito creado en el módulo Cognito."
}

output "cognito_user_pool_client_id" {
  value = module.cognito.user_pool_client_id
  description = "ID del cliente asociado al User Pool de Cognito."
}
