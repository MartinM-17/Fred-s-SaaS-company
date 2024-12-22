# Crear una VPC (Virtual Private Cloud) en AWS con un bloque CIDR de 10.0.0.0/16
# Esta VPC proporcionará un espacio de direcciones IP privadas para los recursos en la red de AWS.

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"  # Bloque de direcciones IP privadas para la VPC.
  enable_dns_support   = true  # Habilita el soporte DNS en la VPC.
  enable_dns_hostnames = true  # Permite la asignación de nombres DNS a las instancias dentro de la VPC.

  tags = {
    Name = var.vpc_name  # Nombre asignado a la VPC basado en la variable 'vpc_name'.
  }
}

# Crear una Gateway de Internet asociada a la VPC creada anteriormente.
# Esta gateway permite la comunicación entre la VPC y el Internet.

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id  # Asocia la gateway a la VPC previamente creada.

  tags = {
    Name = var.vpc_name  # Nombre asignado a la gateway basado en la variable 'vpc_name'.
  }
}

# Crear subredes públicas en la VPC. La cantidad de subredes es determinada por el parámetro 'count'.
# Cada subred tiene un bloque CIDR calculado dinámicamente y habilita la asignación de IP públicas a las instancias.

resource "aws_subnet" "public" {
  count                   = 2  # Se crean dos subredes públicas.
  vpc_id                  = aws_vpc.main.id  # Asociar las subredes a la VPC.
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)  # Asigna un bloque CIDR a cada subred.
  map_public_ip_on_launch = true  # Habilita la asignación automática de IP públicas a las instancias.

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"  # Nombre de la subred con un índice dinámico.
  }
}

# Crear una tabla de enrutamiento pública para la VPC.
# Esta tabla se usará para enrutar el tráfico de las subredes públicas a través de la Gateway de Internet.

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  # Asociar la tabla de enrutamiento a la VPC.

  tags = {
    Name = "${var.vpc_name}-public-route-table"  # Nombre asignado a la tabla de enrutamiento.
  }
}

# Crear una ruta predeterminada que enruta todo el tráfico (0.0.0.0/0) hacia la Gateway de Internet.

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id  # Asociar la ruta a la tabla de enrutamiento pública.
  destination_cidr_block = "0.0.0.0/0"  # Ruta predeterminada para todo el tráfico.
  gateway_id             = aws_internet_gateway.main.id  # Enrutar el tráfico a través de la gateway de internet.
}

# Asociar las subredes públicas a la tabla de enrutamiento pública para que el tráfico se enrute correctamente.

resource "aws_route_table_association" "public" {
  count          = 2  # Asociar la tabla de enrutamiento con cada subred pública (en este caso, dos).
  subnet_id      = aws_subnet.public[count.index].id  # Obtener la ID de cada subred pública.
  route_table_id = aws_route_table.public.id  # Asociar la tabla de enrutamiento pública con la subred.
}
