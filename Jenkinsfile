pipeline{
  
  def app
  
  
  
  stages{
    
    stage('Clone Git'){ 
      checkout scm
    }
    
    stage('Build Image'){
      app = docker.build("steveystyle/server_app")
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
