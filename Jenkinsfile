pipeline { 
   agent any
   stages {
        // stage('SonarQube analysis') {
        //     steps {
        //         withSonarQubeEnv(credentialsId: 'ebea7a45-495c-4751-8a71-616ace7593fc') {
        //             // def scannerHome = tool 'SonarScanner 4.0';
        //             sh "/bin/sonar-scanner"
        //         }
        //     }
        // }    
        stage('Setup') {
         steps {
            sh 'ls -ltr'
            sh 'docker version'
            sh 'docker system df'
            sh 'docker system prune -a -f'
            sh 'docker system df'
         }
        }
        // stage('Unit Tests') {
        //  steps {
        //     sh 'pip3 install -r dependencies/libs.txt'
        //     sh 'python3 ./telegram_unit_test.py'
        //  }
        // }
        stage('Create and Push New Image') {
         steps {
            withCredentials([string(credentialsId: 'docker_pw', variable: 'docker_pw')]) {
                sh 'echo docker pw $docker_pw'
                sh 'docker login -u luloromero19 -p $docker_pw'
                sh 'docker build -t luloromero19/switch-uploader:v0.${BUILD_NUMBER} .'
                sh 'docker push luloromero19/switch-uploader:v0.${BUILD_NUMBER}'
                // sh 'gcloud builds submit . -t gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER}'
            }
         }
        }
        stage('Deploy to cluster') {
            steps {
                echo 'Login to cluster'
                sh '/google-cloud-sdk/bin/gcloud container clusters get-credentials switch-uploader-cluster --zone us-east1-b --project vaulted-valor-278105'
                echo 'Deploy to cluster'
                sh '/google-cloud-sdk/bin/kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.${BUILD_NUMBER} --namespace development' 
                // sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER} --namespace development'
            }
        }

        stage('Run API tests - newman') {
            steps {
                sh 'docker run -v ./:/etc/newman -t postman/newman:alpine run switch-media-uploader.postman_collection.json' 
            }
        }
   }
}