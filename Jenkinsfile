pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/ronnin01/laravel-app.git' // change url repo you used
        DEPLOY_SERVER = 'app-server@192.168.1.8' // change your credentials here for ssh in your web-app server
        DOCKER_IMAGE = 'laravel-app' // location of docker image of your app
        SSH_CREDENTIALS = 'web-app-deploy' // the ssh credentials use make with the ssh private key
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
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER '
                    ls -a
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
