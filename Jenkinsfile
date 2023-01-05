pipeline{
    agent any

    options {
        timestamps()
        gitLabConnection('my-repo')  
    }
    tools {
        maven 'my-work-maven'
        jdk 'java-8-work'
    }
    environment{
        def res="not work"
    }
    stages{
        stage("CHEKOUT"){
            steps{
                echo "===============================================Executing CHEKOUT==============================================="
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                //  echo "===================================================================================Executing deleteDir()==================================================================================="
                deleteDir()
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                // echo "===================================================================================Executing checkout scm==================================================================================="
                checkout scm
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
            }
        }
        

        stage("is all"){
            when{
                anyOf {
                        branch "main"
                        branch "feature/*"
                        branch "master"
                }
            } 
            
            steps{
                script{
                    echo "======================================================================================================================================================================"
                    //toxictypoapp:1.0-SNAPSHOT
                    configFileProvider([configFile(fileId: 'my_settings.xml', variable: 'set')]) {
                    sh "mvn -s ${set} verify"
                    }
                    echo "======================================================================================================================================================================"

                    
                    // sh "docker run -d --name app --network ubuntu_default -p 8083:8080 toxictypoapp:1.0-SNAPSHOT "
                    
                    // sh "docker build -t testing-img ./src/test/" 
                    // sh "docker run --rm --name testing --network ubuntu_default testing-img"
                }
            }
        }
        // stage("is deploy to prod"){
        //     when{
        //         anyOf {
        //                 branch "main"
        //                 branch "master"
        //         }
        //     }
        //     steps{
        //         script{
        //             sh "docker tag toxictypoapp:1.0-SNAPSHOT shoval_toxi:toxictypoapp"
        //             docker.withRegistry("http://644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi", "ecr:eu-west-3:644435390668") {
        //             docker.image("shoval_toxi:toxictypoapp").push()
        //             }
        //         }
        //     } 

        // }
        // stage("is main"){
        //     when{
        //         anyOf {
        //                 branch "main"
        //                 branch "master"
        //         }
        //     }
        //     steps{
        //         script{
        //             sh """ 
        //                 ssh ubuntu@43.0.10.85 "docker rm -f prod"
        //                 ssh ubuntu@43.0.10.85 "aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-3.amazonaws.com"
        //                 ssh ubuntu@43.0.10.85 "docker run -d --name prod -p 80:8080  644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi:toxictypoapp"
        //             """
        //             }
               
        //     } 

        // }

    }
    post{
        always{
            sh "docker rm -f app "
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}