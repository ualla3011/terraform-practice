pipeline {
    agent any

    environment {
        TF_VAR_region = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/ualla3011/terraform-practice.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                script {
                    def userInput = input(
                        id: 'ConfirmApply',
                        message: 'Do you want to apply Terraform changes?',
                        parameters: [choice(choices: 'Yes\nNo', description: 'Approve apply?', name: 'Approve')]
                    )
                    if (userInput != 'Yes') {
                        error("Aborted by user. No changes applied.")
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
