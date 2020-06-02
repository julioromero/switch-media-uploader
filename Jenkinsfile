pipeline {
   agent any
   stages {
      stage('Create New Image') {
         steps {
            sh 'echo Creating new image for build: ${BUILD_NUMBER}'
            // sh 'sudo docker push luloromero19/switch-uploader:v0.${BUILD_NUMBER}'
            sh 'gcloud builds submit . -t gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER}'
         }
      }
      stage('Deploy to cluster') {
         steps {
            echo 'Login to cluster'
            sh 'gcloud container clusters get-credentials vaulted-valor-278105-gke --region us-east1 --project vaulted-valor-278105'
            echo 'Deploy to cluster'
            // sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.${BUILD_NUMBER}'
            sh 'kubectl set image deployment/switch-uploader-deployment switch-uploader=gcr.io/vaulted-valor-278105/switch-uploader:v0.${BUILD_NUMBER} --namespace development'
            // sh 'kubectl set image deployment/events-external-deployment events-external=gcr.io/dtc-user120/external:v1.0.${BUILD_NUMBER} --namespace demo'
         }
      }
   }
}