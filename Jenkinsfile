pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'ordinamento1'
        DOCKER_IMAGE_TAG = 'latest'
        DOCKER_CONTAINER_NAME = 'appord'
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
                        
                        # Se esiste già l'immagine, la rimuoviamo
                        $imageExists = docker images -q "${imageName}:${imageTag}"
                        if ($imageExists) {
                            docker rmi -f "${imageName}:${imageTag}"
                        }
                        
                        # Costruisci la nuova immagine Docker
                        docker build -t "${imageName}:${imageTag}" .
                    '''
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    powershell '''
                        # Definisci le variabili
                        $imageName = "${env:DOCKER_IMAGE_NAME}"
                        $imageTag = "${env:DOCKER_IMAGE_TAG}"
                        $containerName = "${env:DOCKER_CONTAINER_NAME}"
                        
                        # Se esiste già un container con lo stesso nome, lo fermiamo e rimuoviamo
                        $containerExists = docker ps -aq -f name="$containerName"
                        if ($containerExists) {
                            docker stop "$containerName"
                            docker rm "$containerName"
                        }
                        
                        # Esegui il nuovo container, mappando la porta 5002
                        docker run -d --name "$containerName" -p 5002:5002 "${imageName}:${imageTag}"
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
                    
                    docker rmi -f "${imageName}:${imageTag}"
                '''
            }
        }
    }
}
