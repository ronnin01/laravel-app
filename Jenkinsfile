pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ronnin01/laravel-app.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.build('laravel-app', '.')
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['jenkinsadmin']) {
                    sh '''
                    ssh root@159.223.46.170 '
                    cd laravel-app
                    git pull
                    docker-compose up -d --build
                    '
                    '''
                }
            }
        }
    }
}
