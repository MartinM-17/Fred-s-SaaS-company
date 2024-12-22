# Proveedor AWS
provider "aws" {
  region = var.region  # Se configura la región de AWS utilizando la variable `region`.
}

# Módulo para la VPC
module "vpc" {
  source   = "./modules/vpc"  # Ruta relativa al módulo que define la VPC.
  vpc_name = var.project_name # Asigna el nombre de la VPC usando el nombre del proyecto.
}

# Módulo para el Security Group
module "security_group" {
  source = "./modules/SG"     # Ruta relativa al módulo que configura el Security Group.
  vpc_id = module.vpc.vpc_id  # Vincula el Security Group a la VPC creada en el módulo `vpc`.
}

# Módulo para la instancia EC2
module "ec2_instance" {
  source             = "./modules/Instance"      # Ruta relativa al módulo que configura la instancia EC2.
  vpc_id             = module.vpc.vpc_id         # Vincula la instancia a la VPC.
  public_subnet_id   = module.vpc.public_subnet_ids[0] # Selecciona la primera subred pública de la VPC.
  security_group_ids = [module.security_group.sg_id]   # Asigna el Security Group como una lista.
  project_name       = var.project_name          # Nombre del proyecto, usado para nombrar la instancia.
}

# Módulo para Lambda y API Gateway
module "lambda_api_gateway" {
  source         = "./modules/lambda_api_gateway" # Ruta al módulo que configura Lambda y API Gateway.
  project_name   = var.project_name               # Nombre del proyecto, usado para nombrar recursos.
  lambda_file    = var.lambda_file                # Ruta al archivo zip de Lambda.
  lambda_handler = var.lambda_handler             # Configuración del handler de la función Lambda.
  lambda_runtime = var.lambda_runtime             # Especifica el runtime de Lambda (e.g., nodejs18.x).
}

# Módulo para SNS y SQS
module "sns_sqs" {
  source       = "./modules/sns_sqs"  # Ruta relativa al módulo que configura SNS y SQS.
  project_name = var.project_name     # Nombre del proyecto, usado para nombrar recursos.
}

# Módulo para Cognito
module "cognito" {
  source       = "./modules/cognito" # Ruta relativa al módulo que configura Cognito.
  project_name = var.project_name    # Nombre del proyecto, usado para nombrar recursos.
}
