resource "aws_key_pair" "main" {
  key_name   = "AwsSessionKey"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  name        = "aws-session-sg"
  description = "Security group for aws session"

}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports)
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ingress_ports[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports[count.index]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 80]
}

resource "aws_instance" "first_ec2" {
  ami           = "ami-00a8151272c45cd8e"
  instance_type = "t2.micro"

  key_name               = aws_key_pair.main.id
  vpc_security_group_ids = [aws_security_group.main.id]

  depends_on = [aws_security_group.main]

  // file provisioner //
  provisioner "file" {
    source      = "./index.html"
    destination = "/tmp/index.html"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip //public IP of your instance
    private_key = file("~/.ssh/id_rsa")
  }
  // remote exec //

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip //public IP of your instance
      private_key = file("~/.ssh/id_rsa")
    }
  }
}


resource "aws_s3_bucket" "main" {
  bucket = "tf-session-aug-s3-bucket-iana"

}

resource "null_resource" "upload" {
  provisioner "local-exec" {
    command = "aws s3 cp ./local-exec.txt s3://${aws_s3_bucket.main.bucket}"
  }
}

