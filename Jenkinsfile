pipeline{  
  enviroment{
    registry = "steveystyle/server_app"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  
  agent {dockerfile true}
  
  stages{  
    stage('Build Image'){
      steps{
        script{
          dockerImage = docker.build registry + ":$BUILD_NUMBER" 
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
    
    stage('deploy'){
      
      steps{
        echo 'deploying the app..'
      }
    }
  }
}
