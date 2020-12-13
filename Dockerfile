FROM python:3.9
LABEL maintainer="kwame.akuffo@domino.co.uk"
LABEL "Domino"="TeamsNotifierAXL767"
EXPOSE 80/tcp
EXPOSE 80/udp

RUN git clone --branch bcp/AXL-767_MyBranch http://kwame.akuffo:zkV7bU5i6YHd37j@azra-rhodecode.dps.local/TeamsNotifier
VOLUME ["TeamsNotifier/", "/Users/kwame/Documents/workspace/domino/documents"]
WORKDIR TeamsNotifier
CMD ls
ENTRYPOINT exec top -b
#CMD['\
#--webhook-url ${WebhookURL} \
#--branch-name '${UPSTREAM_DISPLAY_NAME}' \
#--build-url '${URL}' \
#--status '${UPSTREAM_STATUS}' \
#--status-image '${STATUS_IMAGE}' \
#--changes-file ${changeListFileName} "']
