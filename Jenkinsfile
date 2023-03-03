pipeline {
    agent any

    stages {
        stage('Checkout TA project') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/njartiana/Test_auto_izicap']]])
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t izicapta_robotframework .'
                    sh 'docker image ls'
                }
            }
        }
        stage('Run container'){
            steps{
                script{
                    sh 'docker container run -d --name test_auto_api izicapta_robotframework'
                }
            }
        }
        stage('Run test'){
            steps{
                script{
                    sh 'docker-compose run izicapta_robotframework'
                }
            }
        }
        stage('Delete all container'){
            steps{
                script{
                    
                    sh 'docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
                }
            }
        }
        stage('Delete all inused docker image'){
            steps{
                script{
                    sh 'docker rmi izicap.api izicapta_robotframework'
                }
            }
        }
    }
}
