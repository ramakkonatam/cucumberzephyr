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
        dir('.tmp/new/') {
            sh 'zip -r cucumber-results.zip .'
        }
        }
      }
    }
     post {
        always {
            publishTestResults serverAddress: 'https://ramakonatam.atlassian.net',
            projectKey: 'KAN', 
            format: 'Cucumber', 
            filePath: '.tmp/new/*.json', 
            autoCreateTestCases: false,
            customTestCycle: [
               
              ]
    }
  }
}
