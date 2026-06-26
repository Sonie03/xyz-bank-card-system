pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Sonie03/xyz-bank-card-system.git'
            }
        }

        stage('Build') {
            steps {
                 sh 'mvn clean package -DskipTests'
            }
     }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                       mvn sonar:sonar \
                       -Dsonar.projectKey=xyz-bank \
                       -Dsonar.projectName=xyz-bank
                        '''
                }
            }
        }

    }
}