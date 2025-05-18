# Currency Converter Project

## Project Overview
This is a Java Swing GUI application for currency conversion. The main entry point is the class `currencyConverter.CurrencyConverter`, which launches the main window (`MainWindow`).

## Running the Application - Step by Step Guide

### 1. Compile and Run Locally
- Compile the Java source files:
  ```
  javac src/currencyConverter/*.java
  ```
- Run the main class:
  ```
  java -cp src currencyConverter.CurrencyConverter
  ```

### 2. Build and Run with Docker
- Build the Docker image:
  ```
  docker build -t currency-converter:latest .
  ```
- Run the Docker container with X11 forwarding enabled:
  - On Linux:
    ```
    docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix currency-converter:latest
    ```
  - On Windows:
    - Ensure an X server (e.g., VcXsrv) is running and configured to allow connections.
    - Set the DISPLAY environment variable accordingly (e.g., `host.docker.internal:0`).
    - Run the container with the DISPLAY environment variable set:
      ```
      docker run -e DISPLAY=host.docker.internal:0 currency-converter:latest
      ```

### 3. Deploy to Kubernetes using Minikube
- Ensure Minikube is installed and running.
- Enable Minikube's Docker environment:
  ```
  minikube docker-env
  ```
- Build the Docker image inside Minikube's Docker environment:
  ```
  docker build -t currency-converter:latest .
  ```
- Update the image name in `k8s/deployment.yaml` if necessary.
- Apply the Kubernetes manifests:
  ```
  kubectl apply -f k8s/deployment.yaml
  kubectl apply -f k8s/service.yaml
  ```
- Ensure X11 forwarding is configured on your host and Minikube environment to support GUI apps.
- Verify the pod is running:
  ```
  kubectl get pods
  ```

### 4. Running Jenkins CI/CD Pipeline
- Set up Jenkins with Docker and Kubernetes CLI.
- Configure Jenkins credentials for Docker registry and Kubernetes.
- Use the provided `Jenkinsfile` to automate build, push, and deploy.
- Trigger the Jenkins pipeline to deploy the application.

## Notes
- This is a GUI Java Swing app, which requires X11 forwarding for display.
- Running GUI apps in Kubernetes is uncommon and requires additional setup.
- For production, consider adapting the app for headless operation or backend use.
