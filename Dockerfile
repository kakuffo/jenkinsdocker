FROM python:3
RUN apt-get update && apt-get install -y \
    apt-get install php5-mcrypt
#RUN pip install requirement.txt
#RUN git clone 'https://github.com/kakuffo/jenkinsdocker/tree/master'
RUN ls
