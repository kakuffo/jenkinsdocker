#!/bin/bash

JENKINS_URL="url"
JOB_NAME="job_name"
USER_NAME="user.name"
USER_TOKEN="secrettoken"
JOB_TOKEN="job_token"

QUEUE_URL=$(curl --silent "https://${JENKINS_URL}/job/${JOB_NAME}/build" \
  --user "${USER_NAME}:${USER_TOKEN}" \
  --data "token=${JOB_TOKEN}" -XPOST \
  --dump-header - \
  --output /dev/null \
  | grep Location \
  | awk '{print $2}' \
  | tr -d '\r\n'
)
echo "${QUEUE_URL}api/json"

sleep 5

BUILD_URL='null'
while [ "$BUILD_URL" == "null" ]
do
  BUILD_URL=$(
    curl --silent "${QUEUE_URL}api/json" \
    --user "${USER_NAME}:${USER_TOKEN}" | jq -r '.executable.url')
done

echo "${BUILD_URL}"

RESULT=''
while [ "$RESULT" != "SUCCESS" ]
do
        RESULT=$(curl --silent "${BUILD_URL}api/json" \
        --user "${USER_NAME}:${USER_TOKEN}" | jq -r '.result')
        sleep 1
done

curl --silent "$BUILD_URL/consoleText" \
  --user "${USER_NAME}:${USER_TOKEN}"






title="Select example"
prompt="Pick an option:"
options=("A" "B" "C")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do

    case "$REPLY" in

    1 ) echo "You picked $opt which is option $REPLY";;
    2 ) echo "You picked $opt which is option $REPLY";;
    3 ) echo "You picked $opt which is option $REPLY";;

    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
    *) echo "Invalid option. Try another one.";continue;;

    esac

done


while opt=$(zenity --title="$title" --text="$prompt" --list \
                    --column="Options" "${options[@]}"); do

    case "$opt" in
    "${options[0]}" ) zenity --info --text="You picked $opt, option 1";;
    "${options[1]}" ) zenity --info --text="You picked $opt, option 2";;
    "${options[2]}" ) zenity --info --text="You picked $opt, option 3";;
    *) zenity --error --text="Invalid option. Try another one.";;
    esac

done