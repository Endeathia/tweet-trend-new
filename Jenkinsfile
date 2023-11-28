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
    }
}q:




[A[3~[F[6~[2~[H[5~[B[B[B[B[B[B[B[B[B[B[B[B[B[B[B[B[B[B[B[A[B
 