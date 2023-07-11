pipeline {
    agent any
    tools{
        maven 'Maven-3.9.3'
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
            //  stage('run image')
            //  {
            //     steps{
            //         sh 'docker run -d -p 8081:8081 neysho/springboot-sample:latest'
            //     }
            //  }
            // deployment stage to kubernetes

            //  stage('Deploying Spring Boot container to Kubernetes') {
            //     steps {
            //        script {
            //             kubernetesDeploy(configs: [kubeconfigFile(), 'deployment.yaml', 'service.yaml'])
            //           }
            //        }
            //    }
        }

          post {
            always {
                sh 'docker logout'
            }
            }
    }