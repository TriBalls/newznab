#!/bin/sh
############################################
# Script based on newznab_screen.sh
# Updated by _R0N_
# Version 20130113-0843
# This script is part of a package scripts
# created for Centos to run as a service
############################################
set -e

export NEWZNAB_PATH="/opt/newznab/misc/update_scripts"
export NEWZNAB_SLEEP_TIME="600" # in seconds
export NEWZNAB_LOG1="/var/log/newznab_run.log"
export NEWZNAB_LOG2="/var/log/newznab_service.log"
LASTOPTIMIZE=`date +%s`

while :

 do
CURRTIME=`date +%s`
echo "----------------------------------" >> $NEWZNAB_LOG2
echo "Start Update: `date`" >> $NEWZNAB_LOG2
cd ${NEWZNAB_PATH}
/usr/bin/php ${NEWZNAB_PATH}/update_binaries.php > $NEWZNAB_LOG1
/usr/bin/php ${NEWZNAB_PATH}/update_releases.php >> $NEWZNAB_LOG1

DIFF=$(($CURRTIME-$LASTOPTIMIZE))
if [ "$DIFF" -gt 43200 ] || [ "$DIFF" -lt 1 ]
then
        LASTOPTIMIZE=`date +%s`
        /usr/bin/php ${NEWZNAB_PATH}/optimise_db.php >> $NEWZNAB_LOG1
        /usr/bin/php ${NEWZNAB_PATH}/update_tvschedule.php >> $NEWZNAB_LOG1
        /usr/bin/php ${NEWZNAB_PATH}/update_theaters.php >> $NEWZNAB_LOG1
fi

echo "waiting ${NEWZNAB_SLEEP_TIME} seconds..." >> $NEWZNAB_LOG1
echo "End Update: `date`" >> $NEWZNAB_LOG2
sleep ${NEWZNAB_SLEEP_TIME}

done
