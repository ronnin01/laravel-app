pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps {
                echo "CLONING REPO"
                git 'https://github.com/ronnin01/laravel-app.git'
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    echo "BUILD DOCKER IMAGE"
                    docker.build('laravel-app')
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "DEPLOYING"
                // Use the withCredentials block to inject username and password
                withCredentials([usernamePassword(credentialsId: 'd2147032-78a3-4105-929c-7786ed231b4c', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
                    sh '''
                    sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no $SSH_USER@159.223.32.149 '
                    cd laravel-app
                    docker-compose down
                    docker-compose up -d --build
                    '
                    '''
                }
            }
        }
    }
}
