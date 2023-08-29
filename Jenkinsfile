pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = credentials('DockerHub-Credinitials')
        BACKEND_IMAGE_NAME = 'minighazal/backend'
        FRONTEND_IMAGE_NAME = 'minighazal/frontend'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Login to Dockerhub') {
            steps {
                sh "echo ${REGISTRY_CREDENTIALS_PSW} | docker login -u ${REGISTRY_CREDENTIALS_USR} --password-stdin"
            }
        }


        stage('docker build for backend') {
            steps {
                sh '''
                    docker images -a
                    docker build -t $BACKEND_IMAGE_NAME:$IMAGE_TAG ./backend/
                    docker images -a
                '''
            }
        }



        stage('Pushing backend image to Dockerhub') {
            steps {
                sh 'docker push $BACKEND_IMAGE_NAME:$IMAGE_TAG'
            }
        }



        stage('docker build for frontend') {
            steps {
                sh '''
                    docker images -a
                    docker build -t $FRONTEND_IMAGE_NAME:$IMAGE_TAG ./frontend/
                    docker images -a
                '''
            }
        }


        stage('Pushing frontend to Dockerhub') {
            steps {
                sh 'docker push $FRONTEND_IMAGE_NAME:$IMAGE_TAG'
            }
        }


        stage('Update Deployment Images') {
            steps {
                script {
                    // Update frontend deployment image reference
                    sh '''
                        sed -i 's|image: minighazal/frontend:.*|image: '"$FRONTEND_IMAGE_NAME:$IMAGE_TAG"'|' ./frontend-deployment.yaml
                    '''

                    // Update backend deployment image reference
                    sh '''
                        sed -i 's|image: minighazal/backend:.*|image: '"$BACKEND_IMAGE_NAME:$IMAGE_TAG"'|' ./backend-deployment.yaml
                    '''
                }
            }
        }
            stage('Rollout New Version') {
                steps {
                    script {
                        // Apply updated deployment manifests
                        sh 'kubectl apply -f frontend-deployment.yaml'
                        sh 'kubectl apply -f backend-deployment.yaml'

                        // Monitor the rollout status for both deployments
                        sh 'kubectl rollout status deployment/frontend-deployment'
                        sh 'kubectl rollout status deployment/backend-deployment'
                    }
                }
            }

    }
}
