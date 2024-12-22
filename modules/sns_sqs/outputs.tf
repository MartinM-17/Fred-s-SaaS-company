# Output para obtener el ARN del SNS Topic creado.
# Este bloque devuelve el ARN del SNS Topic, lo cual es útil si se necesita referenciarlo
# en otros módulos o en la configuración de otros recursos dentro de AWS.

output "sns_topic_arn" {
  value = aws_sns_topic.main.arn  # Obtiene el ARN del SNS Topic 'main'.
  
  # Este valor puede ser utilizado en otros módulos o recursos para referenciar el SNS Topic
  # o realizar configuraciones adicionales, como suscripciones o integraciones con otros servicios.
}

# Output para obtener la URL de la SQS Queue creada.
# Este bloque devuelve la URL de la SQS Queue, que es necesaria para interactuar con la cola,
# como enviar o recibir mensajes a través de la API de SQS.

output "sqs_queue_url" {
  value = aws_sqs_queue.main.id  # Obtiene el ID de la SQS Queue 'main', que se utiliza como su URL.

  # Este valor es útil para interactuar con la cola SQS, por ejemplo, para enviar o recibir mensajes.
  # Puede ser utilizado en otros módulos o herramientas que necesiten acceder a la cola.
}
