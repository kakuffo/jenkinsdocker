FROM python:3
RUN whoami
RUN cd /app
RUN apt-get update && apt-get install -y \
    php5-mcrypt \
    python-pip
#RUN pip install requirement.txt
RUN cd ~/home
RUN mkdir /notify/
RUN cd ~/notify
RUN git clone https://github.com/kakuffo/jenkinsdocker/tree/master
RUN cd /home/notify/jenkinsdocker

COPY /requirements.txt /app/requirements.txt
