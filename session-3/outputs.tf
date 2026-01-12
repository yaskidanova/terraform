output "public_ip" {
  value       = aws_instance.main.public_ip
  description = "The public IP address of the main instance."
}
