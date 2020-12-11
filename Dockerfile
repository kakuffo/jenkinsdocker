FROM python:3

RUN apt-get update && \
    apt-get upgrade -y && \

RUN mkdir /home/notify/
RUN cd /home/notify
RUN git clone: 'bcp/AXL-767_MyBranch',userRemoteConfigs: [[url: 'http://zra-rhodecode.dps.local/TeamsNotifier'],[credentialsId: 'JenkinsOnRhodecode']]
RUN pip3 install git