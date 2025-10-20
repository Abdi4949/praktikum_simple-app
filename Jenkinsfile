pipeline {
  agent any

  environment {
    IMAGE_NAME = "abdieeuh/simple-app"
    REGISTRY = "https://index.docker.io/v1/"
    // ID credential Docker Hub harus sudah dibuat di Jenkins credentials
    REGISTRY_CREDENTIALS = "dockerhub-credentials"
    DOCKER_CLI = "/usr/local/bin/docker"
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
          sh "${DOCKER_CLI} build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
          echo "Image berhasil dibuat: ${IMAGE_NAME}:${env.BUILD_NUMBER}"
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          echo "Push image ke Docker Hub..."
          // Ambil username/password dari Jenkin credentials (kind: Username with password)
          withCredentials([usernamePassword(credentialsId: env.REGISTRY_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            // login
            sh "${DOCKER_CLI} login -u \"$DOCKER_USER\" -p \"$DOCKER_PASS\" ${REGISTRY}"
            // push tag dan latest
            sh "${DOCKER_CLI} push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            sh "${DOCKER_CLI} tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${IMAGE_NAME}:latest || true"
            sh "${DOCKER_CLI} push ${IMAGE_NAME}:latest"
            // logout (opsional)
            sh "${DOCKER_CLI} logout ${REGISTRY} || true"
          }
          echo "Push selesai ✅"
        }
      }
    }
  }

  post {
    always {
      echo "Selesai build 🏁"
    }
  }
}
