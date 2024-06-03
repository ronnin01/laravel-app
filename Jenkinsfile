pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/ronnin01/laravel-app.git'
        DEPLOY_SERVER = 'root@159.223.46.170'
        DOCKER_IMAGE = 'laravel-app'
        SSH_CREDENTIALS = 'jenkinsadmin'
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the code..."
                git url: env.REPO_URL
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
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER '
                    cd laravel-app
                    git pull
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
        cleanup {
            echo 'Cleaning up...'
            script {
                // Add cleanup steps if necessary
            }
        }
    }
}
