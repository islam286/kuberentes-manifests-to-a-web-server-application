pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = credentials('DockerHub-Credinitials')
        BACKEND_IMAGE_NAME = 'minighazal/backend'
        FRONTEND_IMAGE_NAME = 'minighazal/frontend'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build and Push Backend Image') {
            steps {
                script {
                    // Build backend Docker image
                    docker.build("${BACKEND_IMAGE_NAME}:${IMAGE_TAG}", '-f ./simple-ruby-web-app/Dockerfile .')

                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        // Push the backend image to the registry
                        docker.image("${BACKEND_IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }

        stage('Build and Push Frontend Image') {
            steps {
                script {
                    // Build frontend Docker image
                    docker.build("${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}", '-f ./frontend/Dockerfile .')

                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        // Push the frontend image to the registry
                        docker.image("${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }

        stage('Update Manifests') {
            steps {
                script {
                    // Read and update backend deployment manifest
                    def backendManifest = readFile('backend-deployment.yaml')
                    backendManifest = backendManifest.replace('minighazal/backend', "${BACKEND_IMAGE_NAME}:${IMAGE_TAG}")
                    writeFile file: 'backend-deployment.yaml', text: backendManifest

                    // Read and update frontend deployment manifest
                    def frontendManifest = readFile('frontend-deployment.yaml')
                    frontendManifest = frontendManifest.replace('minighazal/frontend:latest', "${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}")
                    writeFile file: 'frontend-deployment.yaml', text: frontendManifest
                }
            }
        }
    }
}
