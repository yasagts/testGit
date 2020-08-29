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
     echo 'Building Maven..."
     sh '''
                   BUILDID=$BUILD_NUMBER
                   Application_Name='HelloWorld'
        '''
     bat "mvn clean"
      }
 }

//Stage 3: Archive Ear into Jenkins Job
 stage('Archive EAR') { // for display purposes
  steps{
     //Archive Ear into Jenkins Job (so we would be able to download it from Jenkins job it self) 
     echo 'Archive the ear available in jenkins build page...'
     archiveArtifacts "${APPLICATION_NAME}/target/*.ear"
      }
 }
 
//Stage 4: Upload to Jfrog artifatory 
 stage('Upload to Jfrog') { // for display purposes
 steps{
         echo 'Jfrog Artifactory Upload...'
         sh "echo EAR Version - ${version}"
         def server = Artifactory.server('artifactory-1-1023070707')
         def uploadSpec = """{
                             "files": [
                               {
                                 "pattern": "${APPLICATION_NAME}/target/*.ear",
                                 "target": "generic-local-bw6-ms"
                               }
                             ]
                           }"""
         server.upload(uploadSpec)
     }
 }
 
//Stage 5: Deploy to SIT
 stage('Deploy') { // for display purposes
  steps{
      echo 'Deploying..."
      bat "mvn clean package"
       }
 }
 
//Stage 6: Regression Test
 stage('Regression Test') { // for display purposes
  steps{
      echo 'Regression Testing..$mvn -v"
      bat "mvn -v"
       }
 }
 
 //Stage 7: Create Promotion job
 stage('Promote') { // for display purposes
  steps{
          echo 'Create promotion job...'
          try{
	      	echo number
	      build job: "Promote_${APPLICATION_NAME}", parameters: [string(name: 'ApplicationName', value: APPLICATION_NAME), string(name: 'Version', value: Number)], propagate: false, wait: false
	  		}
	  	catch (e){
	  	throw e 
	  	}
      }
    }
  }
 
