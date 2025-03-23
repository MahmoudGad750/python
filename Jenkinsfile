pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'yourdockerhubusername/library-mgmt'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/your-repo-name.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Docker image built and pushed to Docker Hub successfully!"
        }
        failure {
            echo "Something went wrong during the build."
        }
    }
}
