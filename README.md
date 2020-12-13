# MST Jenkins Notifications

# Jenkins Docker

```Gerken
As an engineer delivering code to the Ax on Linux code base
I want to receive a teams message to the build failures channel
And develop build fails,
So that I have improved awareness of the 
health of develop
```
## Working Examples

``` shell
CMD [ "python","./send_message.py" 
--webhook-url,
--branch-name,
--build-url,
--status,
--status-image, 
--changes-file,
]
```
```dtd

init_argparse()
        populate_message
        validate_args(args)
        get_message_template()
        load_json(file_path)
        populate_message(args, payload)
        populate_message_with_changes(changes_file, payload)
        format_as_list(items)
main()

```
```textmate
Run Paramater for send_messaage.py

--webhook-url 
--branch-name 
--build-url 
--status 
--status-image 
--changes-file
```
```tree

.
├── Jenkinsfile
├── Jenkinsfile-trigger
├── message-template.json
└── send_message.py
```

```groovy

pipeline {
    agent {
        label params.AGENT == "any" ? "" : params.AGENT 
    }

    parameters {
        choice(name: "AGENT", choices: ["any", "docker", "windows", "linux"]) 
    }

    stages {
        stage("Build") {
            steps {
                echo "Hello, World!"
            }
        }
    }
}
```

One can also trigger a job via remote call (e.g. script)

Trigger job on multiple nodes:

```javascript
curl --silent -u USER:PASSWORD --show-error --data 'json={"parameter":[{"name":"PARAMNAME","value":["node1","node2"]}]}&Submit=Build' http://localhost:8080/job/remote/build?token=SECTOKEN
Although the first format also supports passing just one node name as parameter in the list, the plugin also supports to pas a simple key/value parameter to trigger the job on  single node only:

curl --silent -u USER:PASSWORD --show-error --data 'json={"parameter":[{"name":"PARAMNAME","value":"master"}]}&Submit=Build' http://localhost:8080/job/remote/build?token=SECTOKEN
If you have a 'label' parameter (instead of a 'node' parameter), then the request should look like this:

curl --silent -u USER:PASSWORD --show-error --data 'json={"parameter":[{"name":"PARAMNAME","label":"mylabel"}]}&Submit=Build' http://localhost:8080/job/remote/build?token=SECTOKEN
It is also possible to pass the parameter via GET (example: NODENAME is a 'Node' parameter defined on the job):

 http://localhost:8080/jenkins/job/MyJob/buildWithParameters?NODENAME=node1
```
Dockerfile
```Groovy
FROM python:3.9
LABEL "Domino"=TeamsNotifier-bcp/AXL767
EXPOSE 80/tcp
EXPOSE 80/udp

RUN git clone --branch bcp/AXL-767_MyBranch http://kwame.akuffo:zkV7bU5i6YHd37j@azra-rhodecode.dps.local/TeamsNotifier
WORKDIR /TeamsNotifier
ENTRYPOINT exec top -b
CMD['\
--webhook-url ${WebhookURL} \
--branch-name '${UPSTREAM_DISPLAY_NAME}' \
--build-url '${URL}' \
--status '${UPSTREAM_STATUS}' \
--status-image '${STATUS_IMAGE}' \
--changes-file ${changeListFileName} "']

```

## Jenkins Configurations

```dtd

GOTO: Jenkins > Manage Jenkins > Configure Global Security and enable 
        Prevent Cross SiteRequest Forgery exploits.
```

#### Build Job By Name
```json
curl -H ".crumb:<crumb_string>" -X POST http://<jenkinsUrl>/job/docker/build --user <userName>:<token>

```
#### Get Build Status
```json    
curl -s http://<jenkinsUrl>/job/<jobNname>/<buildNumber>/api/json --user <userName>:<token>
```
#### Get Last Build
```json
curl -s http://<jenkinsUrl>/job/<jobNname>/lastBuild/api/json --user <userName>:<token>
```
#### Get Last Successful Build
```json
curl -s http://<jenkinsUrl>/job/<jobNname>/lastSuccessfulBuild/api/json --user <userName>:<token>
```

#### Get Last Failed Build
```json
curl -s http://<jenkinsUrl>/job/<jobNname>/lastFailedBuild/api/json --user <userName>:<token>
```

#### 
#### Specify Build To Get By Build number result timestamp
```json
curl -s http://<jenkinsUrl>/job/<jobNname>/lastBuild/api/json\?tree\=number,building,result,timestamp --user <userName>:<token>

```

#### Get Atributes All Running Jobs

```json
curl -s http://<jenkinsUrl>/api/xml?tree=jobs[name,url,color]&xpath=/hudson/job[ends-with(color/text(),%22_anime%22)]&wrapper=jobs --user <userName>:<token>"

```