#!/usr/bin/env groovy
import java.util.concurrent.CompletionStage //nueva
pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
            stage('Tests') {
              
            failFast true // skip if true 
            parallel {
        stage('Clean-test'){
//           when { expression { false } } 
            steps {
              echo 'Testing...'
                withGradle {
                    sh './gradlew clean test '
                }
            }
        }
           stage('Test-mutation'){
            steps {
                dir("service/") {
                    ansiColor("xterm") { sh "mvn test pitest:mutationCoverage" }
                }
              }
            }
               stage('test-pitest'){
          when { expression { false } } 
            steps {
              echo 'Testing pitest'
                withGradle {
                    sh './gradlew pitest'
                }
              } 
             post {
                always {
                    junit 'build/test-results/test/TEST-*.xml'
                    jacoco execPattern:'build/jacoco/*.exec'
                    recordIssues(enabledForFailure: true, tool: pit(pattern:"build/reports/pitest/**/*.xml"))
                }
             }
           }
         }
      }
	stage('Analysis') {
		parallel {
			stage('SonarQube Analysis') {
			    when { expression { false } }
			    steps {
				withSonarQubeEnv('local') {
				    sh "./gradlew sonarqube"
				}
			    }
			}
			stage('QA') {
			    when { expression { false } }
			    steps {
				withGradle {
				    sh './gradlew check'
				}
			    }
			    post {
				always {
				    recordIssues(
					tools: [
					    pmdParser(pattern: 'build/reports/pmd/*.xml'),
					    spotBugs(pattern: 'build/reports/spotbugs/*.xml', useRankAsPriority: true)
					]
				    )
				}
			    }
			}
		}
	}
        stage('Build') {
            steps {
                echo '\033[34mConstruyendo\033[0m \033[33mla\033[0m \033[35mimagen\033[0m'
                sh 'docker-compose build'
            }
        }
        stage('Security') {
            steps {
                echo 'Security analysis...'
                sh 'trivy image --format=json --output=trivy-image.json hello-final:latest'
            }
            post {
                always {
                    recordIssues(
                        enabledForFailure: true,
                        aggregatingResults: true,
                        tool: trivy(pattern: 'trivy-*.json')
                    )
                }
            }
        }
/*
        stage('Publish') {
            steps {
                tag 'docker tag hello-final:latest 10.250.14.1:5050/gerardod/hello-final:TESTING-1.0.${BUILD_NUMBER}'
                withDockerRegistry([url:'http://10.250.14.1:5050', credentialsId:'Docker-gitlab' ]) {
                    sh 'docker push 10.250.14.1:5050/gerardod/hello-final/hello-final:latest'
                    sh 'docker push 10.250.14.1:5050/gerardod/hello-final:TESTING-1.0.${BUILD_NUMBER}'
		}
            }
        }
        stage('Deploy') {
            steps {
               echo 'Desplegando servicio...'
               sshagent(credentials:['appkey']){
                   sh '''
                   ssh -o StrictHostKeyChecking=no app app@10.250.14.1 'cd hello-final && docker-compose pull && docker-compose up -d'
                   '''
                }
            }
        }    
*/
        stage('Deploy') {
            steps {
                echo '\033[34mEjecutando\033[0m \033[33mla\033[0m \033[35maplicación\033[0m'
                /*sh '''./gradlew bootRun --args='--server.port=5000' '''*/
                /*sh '''docker-compose build
                docker-compose up -d'''*/
            }
        }
    }
}
