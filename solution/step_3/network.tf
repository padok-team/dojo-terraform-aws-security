data "aws_availability_zones" "available" {}

/* 
Security group define which traffic is allowed on the instance level
It is different from Network ACL which define which traffic is allowed on the subnet level
*/
resource "aws_security_group" "allow_pub" {
  name        = "${random_string.unique_id.id}-${var.environment}-allow_ssh_pub"
  description = "Allow SSH inbound traffic"

  // VPC in which the subnet will be
  vpc_id      = var.vpc_id

  // Ingress rules. This allow everything. Very secure
  ingress {
    description = "Allow Ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.ip_whitelist == [] ? ["0.0.0.0/0"] : var.ip_whitelist
  }

  // Egress rules. This allow everything. Very secure
  egress {
    description = "Allow Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

/* 
Security group define which traffic is allowed on the instance level
It is different from Network ACL which define which traffic is allowed on the subnet level
*/
resource "aws_security_group" "allow_priv" {
  name        = "${random_string.unique_id.id}-${var.environment}-allow_ssh_priv"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  // Ingress rules. This allow everything. Very secure
  ingress {
    description = "Allow Ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  }

  // Ingress rules. This allow everything. Very secure
  egress {
    description = "Allow Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
