pipeline {
    agent {dockerfile true}
    stages{
        stage ('Example') {
            steps{

            }

        }

    }

    post {
        always {
            script
                    {
                        sh './send_message.py --webhook-url ${https://outlook.office.com/webhook/bcb689a9-f9da-4b65-a14a-36989f27f306@57ad0b87-a463-4ff8-9496-e198bc92f64c/IncomingWebhook/5b53493e90df4d0cb08fa9f2ecb8c7a5/3e77e9a7-ea2e-4399-a666-583ceba90a7b}'
                    }
        }
    }

}