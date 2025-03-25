pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mahmoudgad750/python'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/MahmoudGad750/python.git'
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
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                    echo "Updating deployment image to tag ${BUILD_NUMBER}..."
                    sed -i '' "s|image: mahmoudgad750/python:.*|image: mahmoudgad750/python:${BUILD_NUMBER}|" deployment.yaml

                    echo "Applying Kubernetes manifests to EKS..."
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }
    }

    post {
        success {
            echo "Docker image deployed to EKS successfully!"
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
