FROM python:3

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install git -y && \
RUN mkdir /home/notify/
RUN cd /home/notify
RUN git clone https://github.com/kakuffo/jenkinsdocker/tree/master

