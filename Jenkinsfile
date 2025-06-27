pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'anweshsv19/convertechz:latest'
        KUBECONFIG_PATH = 'C:\\jenkins\\.kube\\config'
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
                bat "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                    bat "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Debug Kubeconfig') {
            when {
                expression { fileExists(env.KUBECONFIG_PATH) }
            }
            steps {
                echo "KUBECONFIG: ${env.KUBECONFIG_PATH}"
                bat "type ${env.KUBECONFIG_PATH}"
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression { fileExists(env.KUBECONFIG_PATH) }
            }
            steps {
                bat "kubectl --kubeconfig=${env.KUBECONFIG_PATH} apply -f k8s/deployment.yaml"
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed! Check logs above."
        }
        success {
            echo "Pipeline completed successfully!"
        }
    }
}
