pipeline {
    agent any
    environment {
        IMAGE_NAME = 'abdieeuh/simple-app'
        REGISTRY = 'https://index.docker.io/v1/'
        REGISTRY_CREDENTIALS = 'dockerhub-credentials'
        PATH = "/usr/local/bin/docker" // tambahkan ini!
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Melakukan checkout dari SCM...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Mulai build aplikasi'
                sh 'echo "Build selesai ✅"'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Membangun Docker image...'
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
                    echo "Image berhasil dibuat: ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Push image ke Docker Hub...'
                    docker.withRegistry(REGISTRY, REGISTRY_CREDENTIALS) {
                        sh "docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Selesai build 🏁'
        }
    }
}
