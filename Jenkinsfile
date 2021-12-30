pipeline{  
  agent{ dockerfile true }
  stages{
    
    
    
    stage('Build Image'){
      steps{
        script{
          def newImage = docker.build "server-app:${env.BUILD}"
        }
      }
    }
    
    stage('Push'){
      steps{
        script{
          newImage.push('latest')
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
