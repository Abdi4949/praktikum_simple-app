pipeline {
 agent any
 environment {
 IMAGE_NAME = 'youruser/simple-app'
 REGISTRY = 'https://index.docker.io/v1/'
 REGISTRY_CREDENTIALS = 'dockerhub-credentials'
 }
 stages {
 stage('Checkout') { steps { checkout scm } }
 stage('Build') {
 steps { sh 'echo "Mulai build aplikasi"' }
 }
 stage('Build Docker Image') {
 steps { script { docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}") } }
 }
 stage('Push Docker Image') {
 steps {
 script {
 docker.withRegistry(REGISTRY, REGISTRY_CREDENTIALS) {
 def tag = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
 docker.image(tag).push()
 docker.image(tag).push('latest')
 }
 }
 }
 }
 }
 post { always { echo 'Selesai build' } }
}