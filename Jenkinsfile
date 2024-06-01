pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo "Checkout..."
                git 'https://github.com/ronnin01/laravel-app.git'
            }
        }
        stage('Build') {
            steps {
                echo "Building..."
                script {
                    docker.build('laravel-app', '.')
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['jenkinsadmin']) {
                    echo "Deploying..."
                    sh '''
                    ssh -o StrictHostKeyChecking=no root@159.223.46.170 '
                    cd laravel-app
                    git pull
                    git push
                    docker-compose up -d
                    '
                    '''
                }
            }
        }
    }
}
