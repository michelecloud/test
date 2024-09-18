pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'ordinamento1'
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
                        # Definisci le variabili
                        $imageName = "${env:DOCKER_IMAGE_NAME}"
                        $imageTag = "${env:DOCKER_IMAGE_TAG}"
                        
                        # Costruisci l'immagine Docker
                        docker build -t "${imageName}:${imageTag}" .
                    '''
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    powershell '''
                        # Esegui un container per testare l'immagine
                        $imageName = "${env:DOCKER_IMAGE_NAME}"
                        $imageTag = "${env:DOCKER_IMAGE_TAG}"
                        
                        docker run --rm "${imageName}:${imageTag}"
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                powershell '''
                    # Pulizia delle immagini Docker locali
                    $imageName = "${env:DOCKER_IMAGE_NAME}"
                    $imageTag = "${env:DOCKER_IMAGE_TAG}"
                    
                    docker rmi "${imageName}:${imageTag}"
                '''
            }
        }
    }
}
