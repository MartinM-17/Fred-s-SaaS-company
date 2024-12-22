# Crear un IAM Role para Lambda con la política necesaria para que pueda ser asumido por el servicio Lambda.
resource "aws_iam_role" "lambda_execution" {
  name               = "${var.project_name}_lambda_execution_role"  # Nombre del rol, basado en el nombre del proyecto.
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json  # Define quién puede asumir el rol.

  # Etiquetas asociadas al rol para facilitar su identificación.
  tags = {
    Name = "${var.project_name}_lambda_execution_role"
  }
}

# Definir la política IAM que permite a Lambda asumir el rol creado.
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]  # Acción necesaria para asumir el rol.
    principals {
      type        = "Service"  # Tipo de entidad que asume el rol.
      identifiers = ["lambda.amazonaws.com"]  # Identificador del servicio Lambda.
    }
  }
}

# Crear una función Lambda con los parámetros necesarios.
resource "aws_lambda_function" "main" {
  function_name = "${var.project_name}_lambda_function"  # Nombre de la función Lambda.
  handler       = var.lambda_handler  # Manejador definido en el código Lambda.
  runtime       = "nodejs18.x"  # Versión de Node.js. Asegúrate de usar una versión soportada.
  role          = aws_iam_role.lambda_execution.arn  # Rol IAM asociado a la función.
  filename      = "${path.module}/lambda.zip"  # Archivo ZIP con el código de la función.

  # Etiquetas para la función Lambda.
  tags = {
    Name = "${var.project_name}_lambda_function"
  }
}

# Crear una API Gateway REST API para interactuar con la función Lambda.
resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project_name}_api_gateway"  # Nombre de la API Gateway.

  tags = {
    Name = "${var.project_name}_api_gateway"
  }
}

# Crear un recurso en la API Gateway con una ruta específica.
resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id  # ID de la API REST.
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id  # ID del recurso raíz.
  path_part   = "resource"  # Nombre de la ruta.
}

# Definir el método GET en el recurso creado.
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.main.id  # ID de la API REST.
  resource_id   = aws_api_gateway_resource.main.id  # ID del recurso.
  http_method   = "GET"  # Método HTTP.
  authorization = "NONE"  # Sin autorización requerida.
}

# Integrar el método GET con la función Lambda utilizando AWS Proxy.
resource "aws_api_gateway_integration" "main" {
  rest_api_id              = aws_api_gateway_rest_api.main.id  # ID de la API REST.
  resource_id              = aws_api_gateway_resource.main.id  # ID del recurso.
  http_method              = aws_api_gateway_method.get_method.http_method  # Método HTTP.
  integration_http_method  = "POST"  # Método HTTP para la integración.
  type                     = "AWS_PROXY"  # Tipo de integración: proxy de AWS.
  uri                      = aws_lambda_function.main.invoke_arn  # ARN de invocación de Lambda.
}

# Crear una implementación de la API Gateway para desplegar los cambios.
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id  # ID de la API REST.

  # Desencadenar redeployment si el cuerpo de la API cambia.
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.main.body))
  }

  # Asegurarse de que la implementación nueva se cree antes de eliminar la antigua.
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.get_method,
    aws_api_gateway_integration.main
  ]
}

# Configurar un stage para la API Gateway, por ejemplo, "prod".
resource "aws_api_gateway_stage" "main" {
  stage_name    = "prod"  # Nombre del stage (puede ser 'dev', 'staging', etc.).
  rest_api_id   = aws_api_gateway_rest_api.main.id  # ID de la API REST.
  deployment_id = aws_api_gateway_deployment.main.id  # ID de la implementación.

  depends_on = [aws_api_gateway_deployment.main]
}

# Configurar permisos para que API Gateway pueda invocar la función Lambda.
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"  # ID del statement.
  action        = "lambda:InvokeFunction"  # Acción que se permite.
  function_name = aws_lambda_function.main.function_name  # Nombre de la función Lambda.
  principal     = "apigateway.amazonaws.com"  # Entidad que realiza la invocación.
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"  # ARN de la API Gateway.
}
