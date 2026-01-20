resource "aws_sqs_queue" "main" {
  name = replace(local.name, "rtype", "sqs")

  tags = merge(
    local.common_tags,
    { name = replace(local.name, "rtype", "sqs") }
  )
}

// reference to a local value 
// syntax : local.local_value

// conditionsl expression 
// syntax : condition ? first_value : second_value 
// "apple" == "apple" ? "great" : "okay"
// >> "great"

// "grape" != "tomato" ? "5" : "10"
// >> "5"

resource "aws_db_instance" "main" {
  identifier                = replace(local.name, "rtype", "rds") // rds name
  allocated_storage         = 10
  db_name                   = "mydb" // database name inside the instance , identifier - name of the db 
  engine                    = "mysql"
  engine_version            = "8.0"
  instance_class            = "db.t3.micro"
  username                  = "admin"
  password                  = random_password.password.result // aws secrets manager for rds password 
  parameter_group_name      = "default.mysql8.0"
  skip_final_snapshot       = var.env != "prod" ? true : false // true = no snapshot , false = snapshot 
  final_snapshot_identifier = var.env != "prod" ? null : "${replace(local.name, "rtype", "final_snapshot")}-${formatedate("YYYY-MMDDHHmmss", timestamp())}"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "random_password" {
  value     = random_password.password.result
  sensitive = true
}
