pipeline {
agent any
stages
{
  def mvnHome
  deleteDir()
  def APPLICATION_NAME = 'HelloWorld'
  def version
  def number = ''//env.BUILD_ID
//Stage 1: SCM - Fetch code from GitHub repository 
stage('SCM') { // for display purposes
steps{
     // Get some code from a GitHub repository
     echo 'SCM...'
     git credentialsId: 'd52862f1-3ded-47cf-be7b-3d7975ece96e', url: "https://github.com/yasagts/testGit.git" 
     // Get the Maven tool.
     // ** NOTE: This 'M3' Maven tool must be configured
     // **       in the global configuration.          
     mvnHome = tool 'LocalMaven'
       }
     }             
//Stage 2: Build Maven
stage('Build Maven') { // for display purposes
 steps{
     echo 'Building Maven...'
     // Run the maven build
        withEnv(["MVN_HOME=$mvnHome"]) {
                bat(/"%MVN_HOME%\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
 }
//Stage 3: Archive Ear into Jenkins Job
 stage('Archive EAR') { // for display purposes
  steps{
      echo 'Archive ear available in jenkins build page...'
     archiveArtifacts "${APPLICATION_NAME}/target/*.ear"
      }
 }