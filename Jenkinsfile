pipeline {
    agent any
    tools{
        maven 'maven-3.9.3'
        // dockerTool 'docker'
    }
    environment{
        DOCKERHUB_CREDENTIALS=credentials('635f714f-0de1-4726-b5cd-a6762965dc07')
        // BUILD_NUMBER = "${env.BUILD_NUMBER-SPRINGBOOT-SAMPLE}"
    }

    stages{
            stage('Build Maven'){
                steps{
                    checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Neysho/springboot-sample.git']])
                    sh 'mvn clean install'
                }
            }

            stage('SonarQube Analysis') {
                //    def mvn = tool 'Default Maven';
                   withSonarQubeEnv() {
                   sh "${maven}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=springboot-sample"
                 }
                }

             stage('Build docker image'){
                        steps{
                            script{
                                sh 'docker build -t neysho/springboot-sample:latest .'
                            }
                        }
                    }
             stage('Login to Docker Hub')
             {
                steps{
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
             }
             stage('Push image to Docker Hub')
             {
                steps{
                    sh 'docker push neysho/springboot-sample:latest'
                }
             }
           
        }

          post {
            always {
                script {
                    sh 'docker logout'
                    slackSend channel: '#jenkins-alerts', color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
           
               }
            }
            }
    }