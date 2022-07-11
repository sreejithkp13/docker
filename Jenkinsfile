pipeline{
    agent any
    environment {
        dockerhub = credentials('dockerhub')                                // retrive docker credentials from jenkins.
    }
    stages {
        stage('Builld') {                                                   // This stage will build a new docker image                     
            steps {
                echo "Creating new  docker image........."
                script {
                   sh('docker build -t yougovnginx .')                      // creating new image "yougovnginx"
                }
                echo "Successfully created new docker image"
            }
        }
        stage('Test') {                                                     // This stage will run vulnerability scan
            steps {
                echo "Vulnerability scan"
                script {
                    sh('echo $dockerhub_PSW | docker login -u  $dockerhub_USR --password-stdin')                //  login to dockerhub for running docker scan 
                    sh('docker scan yougovnginx:latest --severity high')                                        //  scanning docker images for vulnerabilities using docker scan
               //     sh('curl -s https://ci-tools.anchore.io/inline_scan-v0.6.0 | bash -s yougovnginx:latest')   //  scanning docker images for vulnerabilities using docker anchore
                }
                echo "Scan is Successful"
           }

        }
        stage('Deployment') {                                               // This stage will deploy statefulset and service     
            steps { 
                echo "Deploying.........."
                script {
                   sh('kubectl apply -f statefulset.yaml')
                }
                echo "Deployed"
            }
        }        
    }
}
