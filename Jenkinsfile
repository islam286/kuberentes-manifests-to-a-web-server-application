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


    }
}
