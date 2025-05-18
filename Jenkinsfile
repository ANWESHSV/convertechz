pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your-docker-repo/currency-converter:latest"
        KUBE_CONFIG = credentials('kubeconfig') // Jenkins credential for kubeconfig
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'javac src/currencyConverter/*.java'
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

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
