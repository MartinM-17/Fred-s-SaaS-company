# Variable para la región de AWS
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Variable para el nombre del proyecto
variable "project_name" {
  description = "Project name for naming AWS resources"
  type        = string
  default     = "SaaS_ETLB"
}

# Variable para el archivo de despliegue Lambda
variable "lambda_file" {
  description = "Path to the Lambda deployment package"
  type        = string
  default     = "path/to/lambda.zip"
}

# Variable para el manejador de la función Lambda
variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
  default     = "index.handler"
}

# Variable para el entorno de ejecución Lambda
variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "nodejs14.x"
}
