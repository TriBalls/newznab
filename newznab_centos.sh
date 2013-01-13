#!/bin/sh
# call this script from within screen to get binaries, processes releases and
# every half day get tv/theatre info and optimise the database

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
