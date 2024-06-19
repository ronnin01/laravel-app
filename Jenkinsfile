pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/ronnin01/laravel-app.git' // change url repo you used
        DEPLOY_SERVER = 'app-server@192.168.1.8' // change your credentials here for ssh in your web-app server
        DOCKER_IMAGE = 'laravel-app' // location of docker image of your app
        SSH_CREDENTIALS = 'laravel-app' // the ssh credentials use make with the ssh private key
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
                    rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" ./ $DEPLOY_SERVER:/laravel-app/
                    
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER '
                    cd laravel-app
                    cp .env.example .env
                    docker exec -it laravel-app php artisan key:generate
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
