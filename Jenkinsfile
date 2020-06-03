pipeline {
   agent any
   stages {
        // stage('SonarQube analysis') {
        //     def scannerHome = tool 'SonarScanner 4.0';
        //     withSonarQubeEnv() {
        //         sh "${scannerHome}/bin/sonar-scanner"
        //     }
        // }
        stage('Create New Image') {
         steps {
            sh 'echo Creating new image for build: ${BUILD_NUMBER}'
            //docker commands not working in dockerized jenkins, using  google container registry instead
            sh 'docker build -t switch-uploader:v0.${BUILD_NUMBER} .'
            sh 'docker push luloromero19/switch-uploader:v0.${BUILD_NUMBER}'
            // sh 'gcloud builds submit . -t gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER}'
         }
        }
        stage('Deploy to cluster') {
            steps {
                echo 'Login to cluster'
                sh 'gcloud container clusters get-credentials switch-uploader-cluster --zone us-east1-b --project vaulted-valor-278105'
                echo 'Deploy to cluster'
                //docker commands not working in dockerized jenkins, using  google container registry instead 
                sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.${BUILD_NUMBER} --namespace development' 
                //kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.01 --namespace development
                // sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER} --namespace development'
            }
        }
   }
}