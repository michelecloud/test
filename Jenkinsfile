pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'ordinamento'
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
                        
                        # Rimuovi eventuali immagini non taggate <none>
                        docker images -f "dangling=true" -q | ForEach-Object { docker rmi -f $_ }

                        # Verifica se esiste già un'immagine con lo stesso nome e tag, la rimuoviamo se esiste
                        $existingImageId = docker images -q "$($imageName):$($imageTag)"
                        if ($existingImageId) {
                            docker rmi -f "$($imageName):$($imageTag)"
                        }
                        
                        # Costruisci la nuova immagine Docker e associala al nome e tag specificati
                        docker build -t "$($imageName):$($imageTag)" .
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
                        docker run -d --name "$containerName" -p 5002:5002 "$($imageName):$($imageTag)"
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                powershell '''
                    # Pulizia delle immagini Docker locali non utilizzate
                    docker system prune -f
                '''
            }
        }
    }
}
