# authentication
sample Django app for make inscription and authentication

1_: Pour Utiliser ce projet avec le Jenkinsfile ou le Jenkinsfile00 comme pipeline,
il faudrait disposer préalablement de : 

    - un compte AWS 

    - Un cluster ECS 

    - Un répertoire ECR privé dans lequel il faudra posser notre image docker comme suit : 
        ~> aws ecr get-login-password --region <AWS_DEFAULT_REGION> | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<AWS_DEFAULT_REGION>.amazonaws.com
        ~> docker build -t <ECR_REPOSITORY> .
        ~> docker tag <ECR_REPOSITORY>:latest <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/<ECR_REPOSITORY>:latest
        ~> docker push <AWS_ACCOUNT_ID>.dkr.ecr.ca-central-1.amazonaws.com/<ECR_REPOSITORY>:latest

    - Un service à l'intérieur du clusteur ECS

    - Un serveur Ubuntu sur lequel est installé :
        >> Jenkins
        >> docker-ce, docker-ce-cli, containerd.io, docker-buildx-plugin, docker-compose-plugin : 
            ~> lien d'installation pour Ubuntu : https://docs.docker.com/engine/install/ubuntu/#os-requirements
        >> AWS CLI

2_: Par la suite :

A/ l'utilisation du ficher Jenkinsfile comme script du pipeline nécessite :
    
    - La configuration de AWS CLI pour l'utilisateur jenkins; soit, une fois dans le terminale du serveur jenkins :
        ~> sudo su - jenkins
        ~> aws configure
        ~> AWS Access Key ID [None]: < à renseigner >
        ~> AWS Secret Access Key [None]: < à renseigner >
        ~> Default region name [None]: <AWS_DEFAULT_REGION>

B/ l'utilisation du ficher Jenkinsfile00 comme script du pipeline ne nécessite pas la configuration AWS CLI pour l'utilisateur jenkins mais plutot:
    - l'installation des plugins suivant via jenkins :
       > Tableau de bord > Administrer Jenkins > Plugins > Plugins disponibles :
        ~> AWS Credentials
        ~> Docker Pipeline
        ~> Amazon ECR 
        ~> AWS Steps

    - la création d'un credential pour AWS :
      > Tableau de bord > Administrer Jenkins > Identifiants > System > Identifiants globaux (illimité) > Add Credentials :
        ~> Type : AWS Credential
        ~> Portée : Global
        ~> ID : <Un_NOM_DE_VOTRE_CHOIX> (ce ID est à sauvegarder et sera utiliser dans le Jenkinsfile00)
        ~> Description : <Un_NOM_DE_VOTRE_CHOIX>
        ~> Access Key ID : <VOTRE_AWS_ACCES_KEY>
        ~> Secret Access Key : <VOTRE_AWS_SECRET_KEY>
        ~> Create
    NB: AWS CLI devra quand même etre installer sur le serveur jenkins

C/ Les variable d'environnement suivante devront être personnalisé en fonction votre Insfrastuctures AWS, ECR, ECS et Jenkins :
     AWS_ACCOUNT_ID="<AWS ACCOUNT ID>"
     AWS_DEFAULT_REGION="<D REGION>"
     CLUSTER_NAME="<REPLACE WITH CLUSTER NAME>"
     SERVICE_NAME="<REPLACE WITH SERVICE NAME>"
     TASK_DEFINITION_NAME="<REPLACE WITH TASK DEFINITION NAME>"
     IMAGE_REPO_NAME="<REPLACE WITH ECR REPO NAME>"
     registryCredential = "<REPLACE WITH NAME OF AWS CREDENTIAL ID>"
     JOB_NAME = "<REPLACE WITH JOB NAME>"
