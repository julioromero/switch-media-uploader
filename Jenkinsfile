pipeline { 
   agent any
   stages {
        // stage('SonarQube analysis') {
        //     def scannerHome = tool 'SonarScanner 4.0';
        //     withSonarQubeEnv() {
        //         sh "${scannerHome}/bin/sonar-scanner"
        //     }
        // }    
        stage('Setup') {
         steps {
            sh 'docker version'
            sh 'docker system prune'
         }
        }
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
                sh 'PATH=/google-cloud-sdk/bin:$PATH'
                sh 'gcloud container clusters get-credentials switch-uploader-cluster --zone us-east1-b --project vaulted-valor-278105'
                echo 'Deploy to cluster'
                //docker commands not working in dockerized jenkins, using  google container registry instead 
                sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.${BUILD_NUMBER} --namespace development' 
                // sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER} --namespace development'
            }
        }
   }
}