pipeline {
    agent any

    environment {
        IMAGE_NAME = "myatbhonethet/finead-todo-app:latest"
    }

    stages {
        stage('Build & Containerise') {
            steps {
                script {
                    // Dockerfile handles frontend and backend build
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $IMAGE_NAME
                    '''
                }
            }
        }
    }
}
