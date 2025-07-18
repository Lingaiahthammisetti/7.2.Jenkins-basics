pipeline {
    agent {
            label 'AGENT-1'
         }
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 30, unit: 'MINUTES')
       //  disableConcurrentBuilds()
         ansiColor('xterm')
    }
     parameters {
       string(name: 'appVersion', defaultValue: '1.2.0', description: 'What is the application version?')
     
       choice(name: 'action', choices: ['Apply', 'Destroy'], description: 'Pick something')

     }

    environment {
        def appVersion = '' //variable declaration here.
        nexusURl = 'nexus.lingaiah.online:8081'
    }
    stages {
        stage('Print the version') {
            steps {
                script {
                  echo "application version: ${params.appVersion}"
              }
            }
        }
         stage('Init') {
            steps {
                sh """
                  cd terraform
                  terraform init -upgrade
                """
              }
           }
         stage('Plan') {

           when {
                expression {
                 params.action == 'Apply'
                  }
                }
            steps {
                sh """
                  cd terraform
                  terraform plan -var="app_version=${params.appVersion}"
                  
                """
              }
         }
         stage('Deploy') {
             when {
                expression {
                  params.action == 'Apply'
                  }
                }
            steps {
                sh """
                  cd terraform
                  terraform apply -auto-approve -var="app_version=${params.appVersion}"
                  
                """
              }
         }
         stage('Destroy') {
                when {
                expression {
                  params.action =='Destroy'
                  }
                }
                steps {
                sh """
                cd terraform
                terraform destroy -auto-approve -var="app_version=${params.appVersion}"
                """
                }
             }

    }
      
     post { 
        always { 
            deleteDir()
            echo 'I will always say Hello Always!'
        }
        success { 
            echo 'I will always say Hello Success!'
        }
        failure{ 
            echo 'I will always say Hello failure!'
        } 
    }
    
}
