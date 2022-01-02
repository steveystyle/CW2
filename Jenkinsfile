
  
  post{ 
    success{
      withKubeConfig([credentialsId: 'mykubeconfig']) {
        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'
        sh 'chmod u+x ./kubectl'
        sh "./kubectl set image deployments/server-app server-app=$registry:$bNo"
      }
      sh "docker rmi $registry:$bNo" 
    }
    failure{
        sh "docker rmi $registry:$bNo"      
    }
  }
}
