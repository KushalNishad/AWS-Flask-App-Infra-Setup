pipeline {
    agent any

    environment {
    DB_CREDS = credentials('mysql-db-login-credentials') // This sets DB_CREDS_USR and DB_CREDS_PSW
    SSH_PUBLIC_KEY = credentials('ssh_public_key') // Only if you're using it
  }

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/KushalNishad/AWS-Flask-App-Infra-Setup.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]){
                            dir('terraform-infra-setup') {
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]){
                            dir('terraform-infra-setup') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh '''
                                    terraform plan \
                                    -var="mysql_username=${DB_CREDS_USR}" \
                                    -var="mysql_password=${DB_CREDS_PSW}" \
                                    -var="public_key=${SSH_PUBLIC_KEY}"  # Optional if used
                                '''
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]){
                            dir('terraform-infra-setup') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh '''
                                    terraform apply -auto-approve
                                    -var="mysql_username=${DB_CREDS_USR}" \
                                    -var="mysql_password=${DB_CREDS_PSW}" \
                                    -var="public_key=${SSH_PUBLIC_KEY}"  # Optional if used
                                '''
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]){
                            dir('terraform-infra-setup') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}