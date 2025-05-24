pipeline {
      agent {
              label 'AGENT-1'
           }
    options {
       timeout(time: 1, unit: 'SECONDS')
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
