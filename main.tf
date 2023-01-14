resource "aws_instance" "CICD-SonarQube-Server"{
    ami = "ami-00ff962d94b87fe06"
    instance_type = "t2.medium"
    user_data = {var.sonar-setup}
}

resource "aws_instance" "CICD-Nexus-Server"{
    ami = "ami-09f129ee53d3523c0"
    instance_type = "t2.medium"
    user_data = {var.nexus-setup}
}

resource "aws_instance" "CICD-Jenkins-Server"{
    ami = "ami-00ff962d94b87fe06"
    instance_type = "t2.small"
    user_data = {var.jenkins-setup}
}

resource "aws_instance" "CICD-app01-staging-Server"{
    ami = "ami-00ff962d94b87fe06"
    instance_type = "t2.small"
}

resource "aws_instance" "CICD-be01-staging-Server"{
    ami = "ami-09f129ee53d3523c0"
    instance_type = "t2.micro"
    user_data = {var.backend-stack}
}

resource "aws_instance" "CICD-PROD-Server"{
    ami = "ami-00ff962d94b87fe06"
    instance_type = "t2.micro"
}

