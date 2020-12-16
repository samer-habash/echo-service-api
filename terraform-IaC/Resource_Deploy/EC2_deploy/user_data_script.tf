data "template_file" "user_data_script" {
  template = <<EOF
    #!/bin/bash
    sudo su
    yum update -y
    amazon-linux-extras install docker
    systemctl enable docker.service
    systemctl start docker.service
    usermod -a -G docker ec2-user
    docker run -d --name=echo-service -p5000:5000 -v /var/log:/app/log samer1984/echo-service:latest
  EOF
}
