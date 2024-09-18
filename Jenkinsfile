pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'ordinamento'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/michelecloud/test.git', branch: 'master'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    powershell '''
                        # Costruisci l'immagine Docker
                        docker build -t $env.DOCKER_IMAGE_NAME:$env.DOCKER_IMAGE_TAG .
                    '''
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    powershell '''
                        # Esegui un container per testare l'immagine
                        docker run --rm $env.DOCKER_IMAGE_NAME:$env.DOCKER_IMAGE_TAG
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Pulizia delle immagini Docker locali
                powershell '''
                    docker rmi $env.DOCKER_IMAGE_NAME:$env.DOCKER_IMAGE_TAG
                '''
            }
        }
    }
}


