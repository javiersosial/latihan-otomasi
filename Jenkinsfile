pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-nginx'          // Nama image yang akan digunakan
        IMAGE_TAG = 'latest'             // Tag untuk image
        DOCKER_CREDENTIALS = 'javiersosial' // Nama kredensial yang telah dibuat di Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out the code from repository...'
                // Menarik kode dari repositori Git
                git 'https://github.com/javiersosial/latihan-otomasi.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image for Nginx...'
                script {
                    // Membangun image Docker
                    sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo 'Logging in to Docker Hub...'
                script {
                    // Login ke Docker Hub dengan kredensial Jenkins
                    docker.withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    // Push image ke Docker Hub
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Menghapus container dan image setelah pipeline selesai
            sh 'docker system prune -af || true'
        }
    }
}
