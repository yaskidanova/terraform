module "sg" {
  source      = "../../modules/sg" // where the module is , could be local or remote
  name        = "dev-sg"
  description = "This is a dev security group"
}

module "ec2" {
  source = "../../modules/ec2"

  ami                    = "ami-00a8151272c45cd8e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.sg.security_group_id]
  env                    = "dev"
}

