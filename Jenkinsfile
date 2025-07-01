pipeline {
  agent any

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    TF_VAR_env = 'dev'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Validate IAM Config') {
      steps {
        sh 'terraform validate -target=aws_iam_role.ecsTaskExecutionRole'
      }
    }

    stage('Validate Security Group') {
      steps {
        sh 'terraform validate -target=aws_security_group.ecs_sg'
      }
    }

    stage('Validate EC2 Instance') {
      steps {
        sh 'terraform validate -target=aws_instance.my_ec2'
      }
    }

    stage('Plan IAM') {
      steps {
        sh 'terraform plan -target=aws_iam_role.ecsTaskExecutionRole -out=tfplan-iam'
      }
    }

    stage('Plan Security Group') {
      steps {
        sh 'terraform plan -target=aws_security_group.ecs_sg -out=tfplan-sg'
      }
    }

    stage('Plan EC2') {
      steps {
        sh 'terraform plan -target=aws_instance.my_ec2 -out=tfplan-ec2'
      }
    }

    stage('Apply IAM') {
      steps {
        sh 'terraform apply -auto-approve tfplan-iam'
      }
    }

    stage('Apply Security Group') {
      steps {
        sh 'terraform apply -auto-approve tfplan-sg'
      }
    }

    stage('Apply EC2') {
      steps {
        sh 'terraform apply -auto-approve tfplan-ec2'
      }
    }
  }

  post {
    failure {
      echo 'Terraform pipeline failed.'
    }
    success {
      echo 'All Terraform resources applied successfully.'
    }
  }
}
