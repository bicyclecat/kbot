pipeline {
agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'windows', 'macos'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm', 'x86_64'], description: 'Pick ARCH')
    }
    
    environment {
        REPO = 'https://github.com/bicyclecat/kbot'
        BRANCH = 'jenkins'
    }
    
    stages {
        
        stage("clone") {
            steps {
              echo 'CLONE REPOSITORY'
              branch: "${BRANCH}", url: "${REPO}"
            }
        }
        
        stage("test") {
            steps {
                echo 'TEST EXECUTION STARTED'
                sh 'make test'
            }
        }
        
        stage("build") {
            steps {
                echo 'BUILD EXECUTION STARTED'
                sh 'make build'
            }
        }
        
        stage("image") {
            steps {
                echo 'BUILD EXECUTION STARTED'
                script {
                    sh 'make image'
                }
            }
        }
        
        stage("push") {
            steps {
                script {
                    docker.withRegistry( '', 'dockerhub') {
                    sh 'make push'
                    }
                }
            }
        }
    }
}