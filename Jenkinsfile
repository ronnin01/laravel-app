pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/ronnin01/laravel-app.git'
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    docker.build('laravel-app')
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['d2147032-78a3-4105-929c-7786ed231b4c']) {
                    sh '''
                    ssh root@159.223.32.149 '
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
