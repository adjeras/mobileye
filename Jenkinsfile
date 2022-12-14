pipeline {
    
    agent any
    
    tools{
        terraform 'terraform-127'
    }
    
    environment {
        registry = "394916145019.dkr.ecr.eu-central-1.amazonaws.com/mobileye-images"
    }
    
    stages {
        
        stage ('Terraform init') {
            steps {
                sh "pwd"
                dir('terraform'){
                    sh "pwd"
                    sh label: '', script: 'terraform init'
                }
                sh "pwd"
            }
        }
        
        stage ('Terraform apply ecr') {
            steps {
                sh "pwd"
                dir('terraform'){
                    sh "pwd"
                    sh label: '', script: 'terraform plan -target="aws_ecr_repository.mobileye-repository"'
                    //sh label: '', script: 'terraform apply -auto-approve -target="aws_ecr_repository.mobileye-repository"'
                }
                sh "pwd"
            }
        }

        stage ('Docker build') {
            steps {
                script {
                dockerImage = docker.build registry
                }
            }
        }
        
        stage ('Docker Push') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 394916145019.dkr.ecr.eu-central-1.amazonaws.com'
                    //sh 'docker push 394916145019.dkr.ecr.eu-central-1.amazonaws.com/mobileye-repo'
                    sh 'docker push 394916145019.dkr.ecr.eu-central-1.amazonaws.com/mobileye-images'
                }
            }
        }

        stage ('K8S delete deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8Snew', namespace: '', serverUrl: '']]) {
                    sh "kubectl delete deployment mobileyeapp"
                }
            }
        }        

        stage ('K8S Deploy') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8Snew', namespace: '', serverUrl: '']]) {
                    sh "kubectl apply -f manifests/deployment.yml"
                }
            }
        }        
    }
}
