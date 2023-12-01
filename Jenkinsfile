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
                sh 'mvn clean deploy -Dmaven.test.skip=true'
            }
        }
            stage ('Unit test') {
                steps {
                    sh 'mvn surefire-report:report'
                }
            }
        stage('SonarCloud Analysis') {
            environment {
            scannerHome = tool 'sonar'
            }
            steps {
             withSonarQubeEnv('sonar') {
               sh "${scannerHome}/bin/sonar-scanner"
    }
            }

        }
  }
}
    

