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
