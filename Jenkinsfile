pipeline {
    agent any

    environment {
        DB_CREDS = credentials('mysql-db-login-credentials') // Jenkins Username with password credential
        SSH_PUBLIC_KEY = credentials('ssh_public_key')       // Jenkins Secret Text credential
    }

    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy Terraform infrastructure')
    }

    stages {
        stage('Clone Repository') {
            steps {
                //deleteDir()
                git branch: 'main', url: 'https://github.com/KushalNishad/AWS-Flask-App-Infra-Setup.git'
                sh 'ls -lart'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]) {
                    dir('terraform-infra-setup') {
                        sh 'echo "=================Terraform Init=================="'
                        sh 'terraform init'
                        sh 'echo "====== Listing files in terraform-infra-setup directory ======"'
                        sh 'ls -lart'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { return params.PLAN_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]) {
                    dir('terraform-infra-setup') {
                        sh 'echo "=================Terraform Plan=================="'
                        sh '''
                            terraform plan \
                              -var="mysql_username=${DB_CREDS_USR}" \
                              -var="mysql_password=${DB_CREDS_PSW}" \
                              -var="public_key=${SSH_PUBLIC_KEY}"
                        '''
                        sh 'echo "====== Listing files in terraform-infra-setup directory ======"'
                        sh 'ls -lart'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { return params.APPLY_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]) {
                    dir('terraform-infra-setup') {
                        sh 'echo "=================Terraform Apply=================="'
                        sh '''
                            terraform apply -auto-approve \
                              -var="mysql_username=${DB_CREDS_USR}" \
                              -var="mysql_password=${DB_CREDS_PSW}" \
                              -var="public_key=${SSH_PUBLIC_KEY}"
                        '''
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.DESTROY_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-kushal']]) {
                    dir('terraform-infra-setup') {
                        sh 'echo "=================Terraform Destroy=================="'
                        sh '''
                            terraform destroy -auto-approve \
                              -var="mysql_username=${DB_CREDS_USR}" \
                              -var="mysql_password=${DB_CREDS_PSW}" \
                              -var="public_key=${SSH_PUBLIC_KEY}"
                        '''
                    }
                }
            }
        }
    }
}
