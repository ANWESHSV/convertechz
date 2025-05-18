pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your-docker-repo/currency-converter:latest"
        KUBECONFIG = "C:\\jenkins\\.kube\\config"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'javac src\\currencyConverter\\*.java'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Debug') {
            steps {
                script {
                    echo "KUBECONFIG: ${env.KUBECONFIG}"
                    bat 'type %KUBECONFIG%'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s\\deployment.yaml'
                bat 'kubectl apply -f k8s\\service.yaml'
            }
        }
    }
}
