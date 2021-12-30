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
        
        def newImage = docke.build("server-app:${env.BUILD}")

      }
    }
    
    stage('Push'){
      
      steps{
        newImage.push('latest')
      }
    }
    
    stage('deploy'){
      
      steps{
        echo 'deploying the app..'
      }
    }
  }
}
