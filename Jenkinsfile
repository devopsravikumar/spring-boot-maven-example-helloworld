pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('git clone'){
            steps{
                git 'https://github.com/devopsravikumar/spring-boot-maven-example-helloworld.git'
            }
        }
        stage("maven clean build"){
            steps
                def mavenHome = tool name: "Maven3.6.3", type: "maven"
                def mavenCMD = "${mavenHome}/bin/mvn "
                sh "${mavenCMD} clean package"
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t dockerravi79/springbootmavenexample:${DOCKER_TAG}"
        }
    }
        stage('Push Docker Image'){
            steps{
                withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                    sh "docker login -u dockerravi79 -p ${DOCKER_HUB_CREDENTIALS}"
                    sh "docker push dockerravi79/springbootmavenexample:${DOCKER_TAG}"
                }    
            }
        }
        stage('deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh"./changeTag.sh ${DOCKER_TAG}"
                sshagent(['Minikube']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ec2-user@172-31-17-61:/homr/ec2-user/"
                    script{
                        try{
                            sh "ssh ec2-user@172-31-17-61 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ec2-user@172-31-17-61 kubectl create -f ."
                        }    
                    }
                }
            }    
        }    
    }    }
