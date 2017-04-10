#!/bin/bash

# Update these for your environment

rvm_path= $HOME     # Typically in the $HOME of the user who installed RVM
RUNNER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner
LOADER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/4-storage/storage-loader
RUNNER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod_recover.yml
RUNNER_ENRICHMENTS=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/enrichments
LOADER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod_recover.yml
IGLU_RESOLVER=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/iglu_resolver_uat.json
# Load the RVM environment
export PATH=$PATH:${rvm_path}/bin:/home/ubuntu
source ${rvm_path}/scripts/rvm

LOGFILE=/data/apps/logs/UDMD/log_`date +%m-%d-%y--%H-%M-%S`
RAWLOGFOLDER=FailedRawLog_`date +%m-%d-%y--%H-%M-%S`
PROCESSINGRAWLOG=RawLog_`date +%m-%d-%y--%H-%M-%S`

# checking if the bucket for global raw collection is empty

count=`s3cmd ls udmd-global-p-raw-logs | wc -l`

#if [[ $count -gt 0 ]]; then
 #       echo "Global raw collection bucket udmd-global-raw-logs is not empty" 2>&1
 #      cat  $LOGFILE | mailx -s "Bucket :  udmd-global-raw-logs is prod not empty "  -r noreply@unileversolutions.com ssingh195@sapient.com
 #      exit $re


echo "Starting EmrEtlRunner " >> $LOGFILE 2>&1

# Run the ETL job on EMR
export BUNDLE_GEMFILE=${RUNNER_PATH}/Gemfile
/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/deploy/snowplow-emr-etl-runner --skip elasticsearch --config ${RUNNER_CONFIG} --enrichments ${RUNNER_ENRICHMENTS} --resolver ${IGLU_RESOLVER} >> $LOGFILE 2>&1


# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error running EmrEtlRunner, exiting with return code ${ret_val}. StorageLoader not run"  >> $LOGFILE 2>&1
    echo "Copying the Failed Raw logs from processing folder s3://udmd-p-etl/processing/ to  s3://udmd-p-archive/failedRawLogs/ " >> $LOGFILE 2>&1
    /usr/local/bin/aws s3 mv  s3://udmd-p-etl/processing/ s3://udmd-p-archive/failedRawLogs/$RAWLOGFOLDER/ --recursive  >> $LOGFILE 2>&1
         #check the damage
            ret_val=$?
            if [ $ret_val -ne 0 ]; then
            echo "error in copying the processing raw logs to failed raw logs, exiting with return code${ret_val}." >> $LOGFILE 2>&1
            fi
           cat  $LOGFILE | mailx -s " EmrEtl Job failure "  -r  noreply@unileversolutions.com  ssingh195@sapient.com
          exit $ret_val
fi

# If all okay, run the storage load too
export BUNDLE_GEMFILE=${LOADER_PATH}/Gemfile
echo "Starting Storage Loader"-completed only etl >> $LOGFILE
