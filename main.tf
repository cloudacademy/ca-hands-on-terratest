resource "aws_security_group" "web" {
  name = "web"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "webserver" {
  ami                    = "ami-07dd19a7900a1f049"
  instance_type          = var.size
  vpc_security_group_ids = [aws_security_group.web.id]


  user_data = <<-EOF
                #!/bin/bash
                echo "Cloud Academy Labs Are Great!" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
    Name = "${var.servername}"
  }
}