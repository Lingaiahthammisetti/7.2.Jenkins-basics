pipeline {
      agent {
              label 'AGENT-1'
           }
    options {
       timeout(time: 30, unit: 'MINUTES')
    }
    stages {
        stage('Build') { 
            steps {
                sh 'echo This is build'
            }
        }
        stage('Test') { 
            steps {
                 sh 'echo This is Test'
            }
        }
        stage('Deploy') { 
            steps {
                sh 'echo This is Deploy' 
            }
        }
    }
}
