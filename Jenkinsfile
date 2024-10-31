pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = "dockerhub-credentials"
        DOCKER_HUB_USERNAME = "siddharth3121997@gmail.com"
        IMAGE_NAME = "sid3121997/petclinic-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/nawab312/k8s-microservices-gitops.git'
                sh 'git submodule update --init --recursive'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS,
                                                      usernameVariable: 'USERNAME',
                                                      passwordVariable: 'PASSWORD')]) {
                            sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                                                      }
                }
            }
        }
        stage('Push Image to DockerHUb') {
            steps {
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
}