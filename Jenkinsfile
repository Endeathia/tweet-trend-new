def registry = 'https://endaethia.jfrog.io/'
def imageName = 'endaethia.jfrog.io/valaxy-docker-local/ttrend'
def version   = '2.0.2'
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
      stage("Quality Gate"){
        steps {
            script {
          timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
      } 
      }

       stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"Jfrog"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }

    stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

     stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, 'Jfrog'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
    } 

    stage(" Deploy ") {
       steps {
         script {
            echo '<--------------- Helm Deploy Started --------------->'
            sh 'helm install ttrend ttrend-0.1.0.tgz'
            echo '<--------------- Helm deploy Ends --------------->'
         }
       }
     }
  }
}
    

