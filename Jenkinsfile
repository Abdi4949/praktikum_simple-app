pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        IMAGE_NAME = "abdieeuh/simple-app"
        REGISTRY = "https://index.docker.io/v1/"
        REGISTRY_CREDENTIALS = "dockerhub-credentials"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Melakukan checkout dari SCM..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Mulai build aplikasi"
                sh 'echo "Build selesai ✅"'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Membangun Docker image..."
                    def app = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                    echo "Image berhasil dibuat: ${app.imageName()}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Push image ke Docker Hub..."
                    docker.withRegistry(REGISTRY, REGISTRY_CREDENTIALS) {
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}").push('latest')
                    }
                    echo "Push selesai ✅"
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
