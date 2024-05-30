pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/your-username/your-laravel-repo.git'
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    docker.build('test-laravel')
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent(['your-ssh-credential-id']) {
                    sh '''
                    docker-compose down
                    docker-compose up -d --build
                    '''
                }
            }
        }
    }
}
