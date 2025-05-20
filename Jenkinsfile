pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        APP_NAME = 'sample-app'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                sh 'npm install' // Change if you're not using Node
            }
        }

        stage('Static Code Analysis') {
            steps {
                echo 'Running static code analysis...'
                sh './scripts/run-scan.sh || true' // Optional scan stage
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'npm run build' // Replace with your build tool (e.g., Maven, Docker, etc.)
            }
        }

        stage('Deploy to Dev') {
            when {
                branch 'develop'
            }
            steps {
                echo "Deploying ${APP_NAME} to Dev..."
                sh './scripts/deploy.sh dev'
            }
        }

        stage('Deploy to Prod') {
            when {
                branch 'main'
            }
            steps {
                input message: "Approve deployment to production?"
                echo "Deploying ${APP_NAME} to Prod..."
                sh './scripts/deploy.sh prod'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Please check logs.'
        }
        always {
            cleanWs()
        }
    }
}
