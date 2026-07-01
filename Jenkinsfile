pipeline {
    agent any

    tools {
        jdk 'JDK21'
        maven 'Maven3'
    }

    environment {
    IMAGE_NAME = "sonie03e/xyz-bank-demo"
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
        sh '''
            docker build -t $IMAGE_NAME:$BUILD_NUMBER .
            docker tag $IMAGE_NAME:$BUILD_NUMBER $IMAGE_NAME:latest
        '''
    }
}

        stage('Trivy Image Scan') {
    steps {
        sh '''
            echo "IMAGE_NAME=$IMAGE_NAME"
            echo "BUILD_NUMBER=$BUILD_NUMBER"

            trivy image \
              --timeout 20m \
              --scanners vuln \
              --severity HIGH,CRITICAL \
              --format table \
              -o trivy-image-report.txt \
              $IMAGE_NAME:$BUILD_NUMBER
        '''

        archiveArtifacts artifacts: 'trivy-image-report.txt'
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
                docker push $IMAGE_NAME:$BUILD_NUMBER
                docker push $IMAGE_NAME:latest
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
       