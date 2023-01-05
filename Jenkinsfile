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
                    docker-compose up -d app --build
                    docker-compose up tester --build

                    check=0
                    docker logs test-tester-1 | grep -i failures || { check=1; }

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