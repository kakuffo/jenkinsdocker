#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [-hv] [-o[file]] args ...
#%
#% DESCRIPTION
#%    This is a script to remotely control Jenkins Jobs.
#%
#%
#% OPTIONS
#%    -o [file], --output=[file]    Set log file (default=/dev/null)
#%                                  use DEFAULT keyword to autoname file
#%                                  The default value is /dev/null.
#%    -t, --timelog                 Add timestamp to log ("+%y/%m/%d@%H:%M:%S")
#%    -x, --ignorelock              Ignore if lock file exists
#%    -h, --help                    Print this help
#%    -v, --version                 Print script information
#%
#% EXAMPLES
#%    ${SCRIPT_NAME} -o DEFAULT arg1 arg2
#%
#================================================================
#- IMPLEMENTATION
#-    version         ${SCRIPT_NAME} (www.domino.co.uk) 0.0.1
#-    copyright       Copyright (c) http://www.domino.co.uk
#-    license         GNU General Public License
#-    script_id       001
#-
#================================================================
#  HISTORY
#     14/12/2020 :
#
#
#================================================================
#  DEBUG OPTION
#    set -n  # Uncomment to check your syntax, without execution.
#    set -x  # Uncomment to debug this shell script
#
#================================================================
# END_OF_HEADER
#================================================================

TITLE="MST Jenkins Notifications"
PROMPT="SELECT:"
options=("Select last Build Of a Job" "Select last Build Number" "Select All Builds")
USERNAME='kwame'
TOKEN='11bf5e6a72393b1bf8ecbcd215c3a31aa8'
JENKINSURL='localhost:8080'
JOBNAME='Docker'
FORMAT='json?pretty'
JOBNUMBER='56'
echo "$TITLE"
PS3="$PROMPT"
select opt in "${options[@]}" "Quit"; do

    case "$REPLY" in

    1 ) curl -s http://$JENKINSURL/job/$JOBNAME/lastBuild/api/$FORMAT --user $USERNAME:$TOKEN $opt which is option $REPLY;;
    2 ) curl -s http://$JENKINSURL/job/$JOBNAME/$JOBNUMBER/api/$FORMAT --user $USERNAME:$TOKEN $opt which is option $REPLY;;
    3 ) curl -s http://$JENKINSURL/api/json?pretty=true --user $USERNAME:$TOKEN $opt which is option $REPLY;;

    $(( ${#options[@]}+1 )) ) echo "End!"; break;;
    *) echo "Invalid option. Try another one.";continue;;
    esac
done