pipeline{  
  environment{
    registry = "steveystyle/server_app"
    registryCredential = 'dockerhub'
    dockerImage = ''
    testContainer = ''
    bNO = "$BUILD_NUMBER" + ".0" 
  }
  
  agent any
  
  stages{
    
    stage('Clone Git'){ 
      steps{
        git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/steveystyle/cw2.git'
      }
    }
    
    stage('Build Image'){
      steps{
        script{
          dockerImage = docker.build registry + ":$bNo" 
        }
      }
    }
    
    stage('Push Image'){
      steps{
        script{
          docker.withRegistry( '', registryCredential ){
            dockerImage.push()
          }
        }  
      }
    }
    
    stage('Build Test'){
      
      steps{
        script{
          dockerImage.inside
        }
      }
          
    stage('Clean'){      
      steps{
        sh "docker rmi $registry:$bNo"
      }
    }
  }
}
