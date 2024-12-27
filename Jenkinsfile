pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "usuroor/my-app:latest"
        KUBE_NAMESPACE = "my-app"
        HELM_CHART_PATH = "./helm/my-app/Chart.yaml"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the repository
                    checkout scm
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    echo "Building Docker image..."
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub and push the image
                    echo "Pushing Docker image to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the Docker image to Kubernetes using Helm
                    echo "Deploying to Kubernetes using Helm..."
                    sh 'helm upgrade --install python-app $HELM_CHART_PATH --namespace $KUBE_NAMESPACE'
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Clean workspace after build
                    echo "Cleaning up workspace..."
                    cleanWs()
                }
            }
        }
    }

    post {
        always {
            // Ensure that the workspace is cleaned after each run
            cleanWs()
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed, please check the logs!"
        }
    }
}

