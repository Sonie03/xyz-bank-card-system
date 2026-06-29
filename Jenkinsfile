pipeline {
    agent any

    tools {
        jdk 'JDK21'
        maven 'Maven3'
    }

    environment {
        IMAGE_NAME = "sonie03e/xyz-bank-card-system"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('Sonarqube1') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs .'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Trivy Image Scan') {
    steps {
        sh """
trivy image \
--timeout 20m \
--scanners vuln \
--severity HIGH,CRITICAL \
--exit-code 1 \
sonie03e/xyz-bank-card-system:${BUILD_NUMBER}
"""
    }
}

        stage('Push Docker Image') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub1',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {

            sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $IMAGE_NAME:$IMAGE_TAG
            docker logout
            '''
        }
    }
}
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        always {
            cleanWs()
        }
    }
}
       