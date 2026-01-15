resource "aws_instance" "main" {
  count                  = 5
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = merge(
    var.tags,
    { "Name" = "aws-session-instance-${count.index}" },
    { "Count" = count.index }
  )
}
