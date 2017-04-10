#!/bin/bash

# Update these for your environment

rvm_path= $HOME     # Typically in the $HOME of the user who installed RVM
RUNNER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner
LOADER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/4-storage/storage-loader
RUNNER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod.yml
RUNNER_ENRICHMENTS=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/enrichments
LOADER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod.yml
IGLU_RESOLVER=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/iglu_resolver_udmd.json
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
 #      exit $
# If all okay, run the storage load too
export BUNDLE_GEMFILE=${LOADER_PATH}/Gemfile
echo "Starting Storage Loader" >> $LOGFILE
/data/apps/SnowplowRealeases/r75/snowplow-master/4-storage/storage-loader/deploy/snowplow-storage-loader --config ${LOADER_CONFIG} >> $LOGFILE 2>&1

#check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
     echo "error in running the Storage Loader, exiting with return code${ret_val}." >> $LOGFILE 2>&1
     cat  $LOGFILE | mailx -s " Storage Loader Job failure "  -r  noreply@unileversolutions.com  dbhatt@sapient.com
     exit $ret_val
fi

echo " Storage Loader  Job completed Successfully" >> $LOGFILE 2>&1
