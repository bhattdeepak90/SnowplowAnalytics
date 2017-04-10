#!/bin/bash

LOADER_PATH=/data/apps/R69/snowplow-master/4-storage/storage-loader


DATAMODELLING_PATH=/data/apps/DataModelling
LOGFILE=/data/apps/logs/UDMD/cleanup/DMlog_`date +%d-%m-%y--%H-%M-%S`

export PATH=$PATH:${rvm_path}/bin:/home/ubuntu
#source ${rvm_path}/scripts/rvm


echo "  checking if enricher or reshift  storage is still running or not "  >> $LOGFILE 2>&1
status=`ps -efww | grep -w "[U]DMD_r64_r75.sh" | awk -vpid=$$ '$2 != pid { print $2 }'`
if [ ! -z "$status" ]; then
    echo "UDMD Enricher job is still  running"  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " data clean up& modelling failure "  -r noreply@unileversolutions.com dbhatt195@sapient.com
    exit 1;
fi

export BUNDLE_GEMFILE=${LOADER_PATH}/Gemfile
echo "Starting Data clean up and data modelling" >> $LOGFILE
  exec ${DATAMODELLING_PATH}/sql-runner -playbook /data/apps/DataModelling/webincrementalprod_r75  >> $LOGFILE 2>&1


#/usr/local/bin/aws s3 sync s3://udmd-p-archive/processing/RawLog_10-08-15--05-43-40/ s3://udmd-p-prodtouat/oct/ >> $LOGFILE 2>&1
        ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error in moving th running the data cleanup n modelling, exiting with return code ${ret_val}. "  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " data clean up n modelling failure "  -r noreply@unileversolutions.com  dbhatt@sapient.com
    exit $ret_val
fi
