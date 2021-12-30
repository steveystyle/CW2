pipeline{  
  agent none
  stages{
    
    
    
    stage('Build Image'){
      agent{ dockerfile true }
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
