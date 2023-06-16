pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker')
    }
    stages {
        stage('init'){
            steps {
                sh 'docker rm -f $(docker ps -aq)  || true'
            }
            }
        stage('build'){
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
                // sh 'docker run -d -p 5000:5000 --name mynginx nginx:latest'
                // sh "docker exec mynginx sh -c 'echo \"Howdy Leroy Jenkins! $SECRET_VAR\" > /usr/share/nginx/html/index.html' "
            }
            }
        stage('push'){
            steps {
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker tag trio-task-mysql:5.7 charliebrown44/trio-task-mysql-lab6:latest"
                sh "docker tag trio-task-flask-app charliebrown44/trio-task-flask-app-lab6:latest"
                sh "docker push charliebrown44/trio-task-mysql-lab6:latest"
                sh "docker push charliebrown44/trio-task-flask-app-lab6:latest"
                }
            }
    }
}