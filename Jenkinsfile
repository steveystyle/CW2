pipeline{  
  agent any
  stages{
    
    stage('Clone Git'){ 
      steps{
        git branch: 'main', credentialsId: 'GitHub', url: 'https://github.com/steveystyle/cw2.git'
      }
    }
    
    stage('Build Image'){
      steps{
        sh """
      docker build -t server_app .
      """
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
