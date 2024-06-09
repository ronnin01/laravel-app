pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/ronnin01/laravel-app.git'
        DEPLOY_SERVER = 'app-server@192.168.1.11'
        DOCKER_IMAGE = 'laravel-app'
        SSH_CREDENTIALS = 'laravel-app'
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the code..."
                git env.REPO_URL
            }
        }
        stage('Build') {
            steps {
                echo "Building Docker image..."
                script {
                    docker.build(env.DOCKER_IMAGE, '.')
                }
            }
        }
        stage('Deploy') {
            steps {
                sshagent([env.SSH_CREDENTIALS]) {
                    echo "Deploying application..."
                    sh '''
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER "mkdir -p /laravel-app"

                    rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" ./ $DEPLOY_SERVER:/laravel-app/
                    
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER '
                    cd laravel-app
                    cp .env.example .env
                    docker-compose run php artisan key:generate
                    docker-compose up -d
                    '
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
