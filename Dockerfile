FROM python:3

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y -r requirements.txt
    apt-get install -y git
RUN mkdir /home/notify/
RUN cd /home/notify
RUN git clone https://github.com/kakuffo/jenkinsdocker/tree/master

#RUN python