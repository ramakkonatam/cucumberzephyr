pipeline {
    agent any

    environment {
        // Set the Node.js and npm installation
        NODEJS_HOME = tool 'NodeJS'
        PATH = "${NODEJS_HOME}/bin:${PATH}"
    }

    parameters {
        string(name: 'PROJECT_KEY',defaultValue:'BAC', description: 'Jira project key for tests')
        string(name: 'TOKEN', defaultValue:'a96113da-d857-4f50-83dd-1dfaa9cbb850',description: 'Public REST API token for Zephyr Scale')
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }
        //  stage('Download Feature Files'){
        //     steps {
        //         downloadFeatureFiles serverAddress: 'https://ramakonatam.atlassian.net',
        //             projectKey: params.PROJECT_KEY,
        //             targetPath:'/'
        //     }
        // }
        stage('Install Dependencies') {
            steps {
                // Install npm dependencies
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                // Run tests for your npm project
                sh 'npx wdio wdio.conf.ts'
            }
        }
        stage('Debug') {
        steps {
        sh 'ls -R .tmp/new'
       }
    }
       
        stage('Create Zip File') {
          steps {
        dir('Json/') {
            sh 'zip -r custom-results.zip .'
        }
        }
      }
     stage('Upload Results to Zephyr Scale') {
            steps {
                script {
                    // Check if parameters are provided
                    if (!params.PROJECT_KEY || !params.TOKEN) {
                        error "Some or all of the parameters are missing. Usage: jenkinsJob -DPROJECT_KEY=<projectKey> -DTOKEN=<token>"
                    }

                    // Set project key and token
                    def PROJECT_KEY = params.PROJECT_KEY
                    def TOKEN = params.TOKEN

                    // API URL
                    def URL = "https://api.zephyrscale.smartbear.com/v2/automations/executions/custom?projectKey=${PROJECT_KEY}&autoCreateTestCases=false"

                    // Upload results to Zephyr Scale
                    sh "cd Json/ && curl -X POST -F 'file=@custom-results.zip' -H 'Authorization: Bearer ${TOKEN}' $URL"
                    // sh "curl -o -X POST -F 'file=./test/reports/junit-results.zip' -H 'Authorization: Bearer ${TOKEN}' $URL"
                }
            }
        }
    }
     post {
        success {
            // Perform actions after a successful build
            echo 'Build successful!'

            // Example: Trigger another job or perform additional actions
            // build job: 'DeployJob', wait: false
        }

        failure {
            // Perform actions after a failed build
            echo 'Build failed!'

            // Example: Send a notification or trigger another job
            // emailext subject: 'Build Failed', body: 'The build failed.', recipientProviders: [developers()]
        }
    }
  //    post {
  //       always {
  //           publishTestResults serverAddress: 'https://krishnakr.atlassian.net',
  //           projectKey: 'BAC', 
  //           format: 'custom', 
  //           filePath: 'Json/zephyr.json', 
  //           autoCreateTestCases: false,
  //            customTestCycle: [
  //               name: 'Jenkins Build',
  //               description: 'Results from Jenkins Build'
  //               //jiraProjectVersion: '10001', 
  //               //folderId: '3040527', 
  //               //customFields: '{"number":50,"single-choice":"option1","checkbox":true,"userpicker":"5f8b5cf2ddfdcb0b8d1028bb","single-line":"a text line","datepicker":"2020-01-25","decimal":10.55,"multi-choice":["choice1","choice3"],"multi-line":"first line<br />second line"}'
  //             ]
  //   }
  // }
}
