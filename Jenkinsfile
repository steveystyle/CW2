pipeline{
  
  environment {
    registry = "steveystyle/server_app"
    registryCredential = 'dockerhub'
  }
  
  agent any
  
  stages{
    
    stage('Clone Git'){ 
      steps{
        git 'https://github.com/steveystyle/cw2.git/'
      }
    }
    
    stage('Build Image'){
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }  
      }
    }
    
    stage('test'){
      
      steps{
        echo 'testing the app..'
      }
    }
    
    stage('deploy'){
      
      steps{
        echo 'deploying the app..'
      }
    }
  }
}
