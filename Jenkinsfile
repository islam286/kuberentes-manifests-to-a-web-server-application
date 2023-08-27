pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = credentials('DockerHub-Credinitials')
        BACKEND_IMAGE_NAME = 'minighazal/backend'
        FRONTEND_IMAGE_NAME = 'minighazal/frontend'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Login to Dockerhub') {
            steps {
                sh 'echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('docker build') {
            steps {
                sh '''
                    docker images -a
                    docker build -t $BACKEND_IMAGE_NAME:$IMAGE_TAG .
                    docker images -a
                '''
            }
        }

        stage('Scan Image for Common Vulnerabilities and Exposures') {
            steps {
                sh 'trivy image $BACKEND_IMAGE_NAME:$IMAGE_TAG --output trivy-report.json'
            }
        }

        stage('Pushing to Dockerhub') {
            steps {
                sh 'docker push $BACKEND_IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Build and Push Frontend Image') {
            steps {
                script {
                    // Build frontend Docker image
                    docker.build("$FRONTEND_IMAGE_NAME:$IMAGE_TAG", '-f ./frontend/Dockerfile .')

                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        // Push the frontend image to the registry
                        docker.image("$FRONTEND_IMAGE_NAME:$IMAGE_TAG").push()
                    }
                }
            }
        }

        stage('Update Manifests') {
            steps {
                script {
                    // Read and update backend deployment manifest
                    def backendManifest = readFile('backend-deployment.yaml')
                    backendManifest = backendManifest.replace('minighazal/backend', "$BACKEND_IMAGE_NAME:$IMAGE_TAG")
                    writeFile file: 'backend-deployment.yaml', text: backendManifest

                    // Read and update frontend deployment manifest
                    def frontendManifest = readFile('frontend-deployment.yaml')
                    frontendManifest = frontendManifest.replace('minighazal/frontend:latest', "$FRONTEND_IMAGE_NAME:$IMAGE_TAG")
                    writeFile file: 'frontend-deployment.yaml', text: frontendManifest
                }
            }
        }
    }
}
