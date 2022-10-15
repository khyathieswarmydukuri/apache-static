resource "aws_instance" "helm-server" {
    subnet_id = "subnet-0fbdc8ebc5b53a0fb"
    instance_type = "c5.xlarge" 
    ami = "ami-0f924dc71d44d23e2"
    vpc_security_group_ids =[aws_security_group.helm-sg.id]
    key_name = aws_key_pair.helm-key.id
    user_data = <<EOF
#!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
    yum upgrade -y
    amazon-linux-extras install java-openjdk11
    yum install jenkins -y
    systemctl enable jenkins
    systemctl start jenkins
EOF
 tags = {
    Name = "helm-server"
  }
}
