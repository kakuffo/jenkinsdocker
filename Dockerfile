FROM python:3.9
LABEL "Domino"=TeamsNotifier-bcp/AXL767
EXPOSE 80/tcp
EXPOSE 80/udp

RUN git clone --branch bcp/AXL-767_MyBranch http://kwame.akuffo:zkV7bU5i6YHd37j@azra-rhodecode.dps.local/TeamsNotifier
WORKDIR /TeamsNotifier
ENTRYPOINT exec top -b
CMD['--webhook-url ${WebhookURL} --branch-name '${UPSTREAM_DISPLAY_NAME}' --build-url '${URL}' --status '${UPSTREAM_STATUS}' --status-image '${STATUS_IMAGE}' --changes-file ${changeListFileName}"']
