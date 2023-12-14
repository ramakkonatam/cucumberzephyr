pipeline {
    agent any

    environment {
        // Set the Node.js and npm installation
        NODEJS_HOME = tool 'NodeJS'
        PATH = "${NODEJS_HOME}/bin:${PATH}"
    }

    parameters {
        string(name: 'PROJECT_KEY',defaultValue:'KAN', description: 'Jira project key for tests')
        string(name: 'TOKEN', defaultValue:'06611a22-fb19-4e84-9e04-63eff80de914',description: 'Public REST API token for Zephyr Scale')
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }
         stage('Download Feature Files'){
            steps {
                downloadFeatureFiles serverAddress: 'https://ramakonatam.atlassian.net',
                    projectKey: params.PROJECT_KEY,
                    targetPath:'/features'
            }
        }
        stage('Install Dependencies') {
            steps {
                // Install npm dependencies
                sh 'npm install'
            }
        }

        // stage('Build') {
        //     steps {
        //         // Build your npm project
        //         sh 'npm run build'
        //     }
        // }

        stage('Test') {
            steps {
                // Run tests for your npm project
                sh 'npx wdio wdio.conf.ts'
            }
        }
        stage('Debug') {
    steps {
        sh 'ls -R ./tmp/new'
    }
  }
        // stage('Create Zip File') {
        //     steps {
        //         // Create zip file
        //         sh 'zip -D ./test/reports/junit-results.zip ./test/reports/junit-results/'
        //     }
        // }
        stage('Create Zip File') {
          steps {
        dir('./tmp/new/') {
            sh 'zip -r cucumber-results.zip .'
        }
    }
}
        //  stage('Upload Results to Zephyr Scale') {
        //     steps {
        //         script {
        //             // Check if parameters are provided
        //             if (!params.PROJECT_KEY || !params.TOKEN) {
        //                 error "Some or all of the parameters are missing. Usage: jenkinsJob -DPROJECT_KEY=<projectKey> -DTOKEN=<token>"
        //             }

        //             // Set project key and token
        //             def PROJECT_KEY = params.PROJECT_KEY
        //             def TOKEN = params.TOKEN

        //             // API URL
        //             def URL = "https://api.zephyrscale.smartbear.com/v2/automations/executions/junit?projectKey=${PROJECT_KEY}&autoCreateTestCases=true"

        //             // Upload results to Zephyr Scale
        //             sh "cd ./tmp/new/ && curl -X POST -F 'file=@cucumber-results.zip' -H 'Authorization: Bearer ${TOKEN}' $URL"
        //             // sh "curl -o -X POST -F 'file=./test/reports/junit-results.zip' -H 'Authorization: Bearer ${TOKEN}' $URL"
        //         }
        //     }
        // }
    }
     post {
        always {
            publishTestResults serverAddress: 'https://ramakonatam.atlassian.net',
            projectKey: 'WEB', 
            format: 'Cucumber', 
            filePath: 'tmp/new/*.json', 
            autoCreateTestCases: false, 
        }
    }
    // post {
    //     success {
    //         // Perform actions after a successful build
    //         echo 'Build successful!'

    //         // Example: Trigger another job or perform additional actions
    //         // build job: 'DeployJob', wait: false
    //     }

    //     failure {
    //         // Perform actions after a failed build
    //         echo 'Build failed!'

    //         // Example: Send a notification or trigger another job
    //         // emailext subject: 'Build Failed', body: 'The build failed.', recipientProviders: [developers()]
    //     }
    // }
}
