node{
    stage('git login'){
        git branch: 'main', url: 'https://github.com/DamithGit92/GitHub-Jenkins-Docker-Project.git'
    }
    
    stage('Build Docker image'){
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID . '
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID dockerdmsnew/$JOB_NAME:v1.$BUILD_ID'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID dockerdmsnew/$JOB_NAME:latest'
    }
    
    stage('Push Docker image to GitHub'){
        withCredentials([string(credentialsId: 'dockerpassword', variable: 'dockerpassword')]) {
            sh "docker login -u dockerdmsnew -p ${dockerpassword}"
            sh 'docker image push dockerdmsnew/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image push dockerdmsnew/$JOB_NAME:latest'
            
            sh 'docker image rm $JOB_NAME:v1.$BUILD_ID dockerdmsnew/$JOB_NAME:v1.$BUILD_ID dockerdmsnew/$JOB_NAME:latest'
        }
    }
    
    stage('Docker container deployment'){
        def docker_run = 'docker run -itd --name scriptedcontainer -p 9000:80 dockerdmsnew/project-1'
        def docker_rm_container = 'docker rm -f scriptedcontainer'
        def docker_rm_image = 'docker rmi -f dockerdmsnew/project-1'
        sshagent(['Web_server_testing']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.24.172 ${docker_rm_container}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.24.172 ${docker_rm_image}"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.24.172 ${docker_run}"
        }
    }
}
