import groovy.json.JsonSlurper

def getJobStatus(String jobName){
    def rx = httpRequest "https://jenkins.com/job/pipelines/job/$jobName/lastBuild/api/json --user datagenx:XXXXXX"
    def rxJson = new JsonSlurper().parseText(rx.getContent())
    return rxJson['result']
}



pipeline {
    agent { label 'jenkins-slave'  }

    stages {

        stage('check'){
            steps {
                script {
                    for(jobname in ['Sleep180', 'Auto_Git_PR']){
                        jobStatus = getJobStatus(jobName)
                        echo jobStatus
                        if(jobStatus == "SUCCESS" || jobStatus == "UNSTABLE"){
                            print "$jobname is $jobStatus"
                        }
                        else{
                            print "The status of $jobname is $jobStatus"
                        }
                    }
                }
            }
        }
    }
}
