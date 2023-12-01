pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    environment {
        PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
    }
    stages {
        stage('Clone Code') {
            steps {
               git branch: 'main', url: 'https://github.com/Endeathia/tweet-trend-new.git'
            }
        }
        stage('buid') {
            steps{
                sh 'mvn clean deploy'
            }
        }
        stage('SonarCloud Analysis') {
            environment {
            scannerHome = tool 'sonar'
            }
            steps {
             withSonarQubeEnv('sonar') { // If you have configured more than one global server connection, you can specify its name
               sh "${scannerHome}/bin/sonar-scanner"
    }
            }

        }
  }
}
    

