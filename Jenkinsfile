pipeline {
    agent any
 
    environment {
        // Variables d'environnement
        AWS_ACCOUNT_ID = '381492291819'
        AWS_DEFAULT_REGION = 'ca-central-1'
        ECR_REPOSITORY = 'public.ecr.aws/b3y8b3n1/authappecs'
        IMAGE_TAG = 'latest'
        ECS_CLUSTER_NAME = 'YopCluster01'
        ECS_SERVICE_NAME = 'YopJKSService01'
    }
 
    stages {
        stage('Cloner le dépôt') {
            steps {
                git 'https://github.com/yop388/Authentication-Container.git'
            }
        }
        stage('Construire l\'image Docker') {
            steps {
                script {
                    dockerImage = docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}")
                }
            }
        }
 
        stage('Se connecter à ECR') {
            steps {
                script {
                    sh """
                    aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
                    """
                }
            }
        }
 
        stage('Pousser l\'image Docker') {
            steps {
                script {
                    dockerImage.push()
                }
            }
        }
 
        stage('Mettre à jour le service ECS') {
            steps {
                script {
                    sh """
                    aws ecs update-service --cluster ${ECS_CLUSTER_NAME} --service ${ECS_SERVICE_NAME} --force-new-deployment
                    """
                }
            }
        }
    }
 
    post {
        always {
            cleanWs()
        }
    }
}