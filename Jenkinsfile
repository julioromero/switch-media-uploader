pipeline { 
   agent any
   stages {
        // stage('SonarQube analysis') {
        //     steps {
        //         sh "/sonar-scanner-4.3.0.2102-linux/bin/sonar-scanner --version"
        //         sh "/sonar-scanner-4.3.0.2102-linux/bin/sonar-scanner -Dsonar.projectKey=switch-uploader -Dsonar.sources=. -Dsonar.host.url=http://35.192.8.193:9000 -Dsonar.login=c0f1253b6f128181f186e6727742fec76e6d92a5"
        //     }
        // }
        stage('Setup') {
         steps {
            sh 'pwd'
            sh 'ls -ltr'
            sh 'docker version'
            sh 'docker system df'
            sh 'docker system prune -a -f'
            sh 'docker system df'
         }
        }
        stage('Create and Push New Image') {
         steps {
            withCredentials([string(credentialsId: 'docker_pw', variable: 'docker_pw')]) {
                sh 'echo docker pw $docker_pw'
                sh 'docker login -u luloromero19 -p $docker_pw'
                sh 'docker build -t luloromero19/switch-uploader:v0.${BUILD_NUMBER} .'
                sh 'docker push luloromero19/switch-uploader:v0.${BUILD_NUMBER}'
            }
         }
        }
        stage('Deploy to cluster') {
            steps {
                echo 'Login to cluster'
                sh '/google-cloud-sdk/bin/gcloud container clusters get-credentials switch-uploader-cluster --zone us-east1-b --project vaulted-valor-278105'
                echo 'Deploy to cluster'
                sh '/google-cloud-sdk/bin/kubectl set image deployment/switch-uploader-deployment switch-uploader=luloromero19/switch-uploader:v0.${BUILD_NUMBER} --namespace development' 
            }
        }
   }
}