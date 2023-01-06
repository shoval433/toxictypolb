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
                    sh """
                    cd src/test
                    docker-compose up -d --build app

                    docker-compose up --build tester

                    check=0
                    docker logs test_tester_1 | grep -i failures || { check=1; }

                    if [ \$check = 0 ] 
                    then
                    echo "tests faild"
                    exit 1
                    fi
                    """
                    


                    // Server is set to app:8081
                    // Test level is set to e2e
                    // Wait time is set to 7
                    // Waiting 7 seconds before starting to send test messages...
                    // Traceback (most recent call last):
                    //   File "e2e_test.py", line 68, in <module>
                    //     results = pool.map(ptest, testCases)
                    //   File "/usr/local/lib/python2.7/multiprocessing/pool.py", line 253, in map
                    //     return self.map_async(func, iterable, chunksize).get()
                    //   File "/usr/local/lib/python2.7/multiprocessing/pool.py", line 572, in get
                    //     raise self._value
                    // requests.exceptions.ConnectionError: HTTPConnectionPool(host='app', port=8081): Max retries exceeded with url: /api/suggest/accuseomed (Caused by NewConnectionError('<urllib3.connection.HTTPConnection object at 0x7fecebccee10>: Failed to establish a new connection: [Errno 111] Connection refused',))

                }
            }
        }
        stage("deploy to ecr"){
            when{
                anyOf {
                        branch "main"
                        branch "master"
                }
            }
            steps{
                script{
                    sh "docker tag toxictypoapp:1.0-SNAPSHOT shoval_toxi:toxictypo-alb"
                    docker.withRegistry("http://644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi", "ecr:eu-west-3:644435390668") {
                    docker.image("shoval_toxi:toxictypo-alb").push()
                    }
                }
            } 

        }
        stage("Prod"){
            when{
                anyOf {
                        branch "main"
                        branch "master"
                }
            }
            steps{
                script{
                    sh """ 
                        scp init_prod.sh ubuntu@43.0.10.85:/home/ubuntu/
                        ssh ubuntu@43.0.10.85 "bash init_prod.sh"

                        scp init_prod.sh ubuntu@43.0.20.244:/home/ubuntu/
                        ssh ubuntu@43.0.20.244 "bash init_prod.sh"

                        
                    """
                    }
               //
            } 

        }

    }
    post{
        always{
            sh "docker rm -f test_tester_1 test_app_1 "
            echo "========always========"
        }
        success{
           script{
                script{
                    emailext to: 'shoval123055@gmail.com',
                    subject: 'Congratulations!', body: 'Well, this time you didnt mess up',  
                    attachLog: true
                }     
            
            
                gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                    echo "that good"
                }
            }
        }
        failure{
               script{
                // emailext   recipientProviders: [culprits()],
                // subject: 'YOU ARE BETTER THEN THAT !!! ', body: 'Dear programmer, you have broken the code, you are asked to immediately sit on the chair and leave the coffee corner.',  
                // attachLog: true
                emailext   to: 'shoval123055@gmail.com',
                subject: 'YOU ARE BETTER THEN THAT !!! ', body: 'Dear programmer, you have broken the code, you are asked to immediately sit on the chair and leave the coffee corner.',  
                attachLog: true
            }      
           
            gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                echo "ahh"
            }

        }
    }
}