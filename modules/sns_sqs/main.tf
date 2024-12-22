# Crear un SNS Topic que se utilizará para enviar mensajes a una SQS Queue.
resource "aws_sns_topic" "main" {
  name = "${var.project_name}_sns_topic"  # Nombre del SNS Topic, se personaliza con el nombre del proyecto.

  # Etiquetas para identificar el recurso.
  tags = {
    Name = "${var.project_name}_sns_topic"  # Etiqueta que asocia un nombre al SNS Topic.
  }
}

# Crear una SQS Queue que recibirá los mensajes del SNS Topic.
resource "aws_sqs_queue" "main" {
  name = "${var.project_name}_sqs_queue"  # Nombre de la SQS Queue, se personaliza con el nombre del proyecto.

  # Etiquetas para identificar el recurso.
  tags = {
    Name = "${var.project_name}_sqs_queue"  # Etiqueta que asocia un nombre a la SQS Queue.
  }
}

# Crear una suscripción de SNS para que los mensajes del SNS Topic se envíen a la SQS Queue.
resource "aws_sns_topic_subscription" "main" {
  topic_arn = aws_sns_topic.main.arn  # ARN del SNS Topic que se suscribe.
  protocol  = "sqs"                   # El protocolo de la suscripción es 'sqs', es decir, la SQS Queue recibirá los mensajes.
  endpoint  = aws_sqs_queue.main.arn  # ARN de la SQS Queue que recibirá los mensajes del SNS Topic.
}
