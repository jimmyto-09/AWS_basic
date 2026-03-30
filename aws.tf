resource "aws_instance" "mi_ec2" {
  ami           = "ami-08f9a9c699d2ab3f9"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Hola Jimmy Bemvindo</h1>" > /usr/share/nginx/html/index.html
              EOF

  subnet_id              = aws_subnet.main.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.mi_sg.id]

  tags = {
    Name = "mi-ec2"
  }
}

resource "aws_s3_bucket" "mi_bucket" {
  bucket = "mi-bucket-jimmyro12345"

  tags = {
    Name = "mi-bucket"
  }
}