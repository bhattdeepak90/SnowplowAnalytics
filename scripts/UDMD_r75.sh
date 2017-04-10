#!/bin/bash

# Update these for your environment

#rvm_path= $HOME     # Typically in the $HOME of the user who installed RVM
RUNNER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner
LOADER_PATH=/data/apps/SnowplowRealeases/r75/snowplow-master/4-storage/storage-loader
RUNNER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod.yml
RUNNER_ENRICHMENTS=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/enrichments
LOADER_CONFIG=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/emr-etl-runner/config/combined_prod.yml
IGLU_RESOLVER=/data/apps/SnowplowRealeases/r75/snowplow-master/3-enrich/config/iglu_resolver_udmd.json
# Load the RVM environment
#export PATH=$PATH:${rvm_path}/bin:/home/ubuntu
#source ${rvm_path}/scripts/rvm

LOGFILE=/data/apps/logs/UDMD/log_`date +%m-%d-%y--%H-%M-%S`
RAWLOGFOLDER=FailedRawLog_`date +%m-%d-%y--%H-%M-%S`
PROCESSINGRAWLOG=RawLog_`date +%m-%d-%y--%H-%M-%S`

# checking if the bucket for global raw collection is empty

count=`s3cmd ls udmd-global-p-raw-logs | wc -l`

#if [[ $count -gt 0 ]]; then
 #       echo "Global raw collection bucket udmd-global-raw-logs is not empty" 2>&1
 #      cat  $LOGFILE | mailx -s "Bucket :  udmd-global-raw-logs is prod not empty "  -r noreply@unileversolutions.com ssingh195@sapient.com
 #      exit $ret_val
#fi

echo "Starting the Global raw Logs Collection " >> $LOGFILE 2>&1

echo "Moving the Raw Logs of EU Region " >> $LOGFILE 2>&1
/usr/local/bin/aws s3 mv  s3://elasticbeanstalk-eu-west-1-872626332308/resources/environments/logs/publish/e-x7425zb2tv/  s3://udmd-global-p-raw-logs/ --recursive --exclude "*catalina*" --exclude "*error_log*"  --exclude "*elasticbeanstalk*" >> $LOGFILE 2>&1
# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error in moving the Raw logs of EU Region, exiting with return code ${ret_val}. "  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r noreply@unileversolutions.com dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
#   cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r noreply@unileversolutions.com UnileverUDMDSupport@sapient.com
    exit $ret_val
fi

echo "Moving the Raw Logs of US Region " >> $LOGFILE 2>&1
/usr/local/bin/aws s3 mv  s3://elasticbeanstalk-us-east-1-872626332308/resources/environments/logs/publish/e-msbtx27rcd/  s3://udmd-global-p-raw-logs/ --recursive --exclude "*catalina*" --exclude "*error_log*" --exclude "*elasticbeanstalk*" >> $LOGFILE 2>&1
# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error in moving the Raw logs of US Region, exiting with return code ${ret_val}. "  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com  dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
#     cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com  UnileverUDMDSupport@sapient.com
    exit $ret_val
fi

echo "Moving the Raw Logs of APAC Region " >> $LOGFILE 2>&1
/usr/local/bin/aws s3 mv  s3://elasticbeanstalk-ap-southeast-1-872626332308/resources/environments/logs/publish/e-zqgq2zzfjn/  s3://udmd-global-p-raw-logs/ --recursive --exclude "*catalina*" --exclude "*error_log*" --exclude "*elasticbeanstalk*"  >> $LOGFILE 2>&1
# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error in moving the Raw logs of APAC Region, exiting with return code ${ret_val}. "  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
#    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com UnileverUDMDSupport@sapient.com
   exit $ret_val
fi


echo "Global Raw Logs Collection completed successfully " >> $LOGFILE 2>&1
echo "taking backup of raw logs which are to be processed" >> $LOGFILE 2>&1
/usr/local/bin/aws s3 sync s3://udmd-global-p-raw-logs/ s3://udmd-p-archive/processing/$PROCESSINGRAWLOG/ --recursive >> $LOGFILE 2>&1
# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    echo "Error in taking backup of Processing Raw logs, exiting with return code ${ret_val}. "  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r noreply@unileversolutions.com dbhatt@sapient.com, dsingh66@sapient.com, gchaudhary@sapient.com
#    cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r noreply@sapient.com UnileverUDMDSupport@sapient.com
    exit $ret_val
fi


echo "#############################################################################################################################################################################" >> $LOGFILE 2>&1


echo "Starting EmrEtlRunner " >> $LOGFILE 2>&1

# Run the ETL job on EMR
#export BUNDLE_GEMFILE=${RUNNER_PATH}/Gemfile
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
           cat  $LOGFILE | mailx -s "EMR ETL Job Failure "  -r  noreply@unileversolutions.com dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
#           cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com  UnileverUDMDSupport@sapient.com
           exit $ret_val
fi

# If all okay, run the storage load too
#export BUNDLE_GEMFILE=${LOADER_PATH}/Gemfile
echo "Starting Storage Loader" >> $LOGFILE
/data/apps/SnowplowRealeases/r75/snowplow-master/4-storage/storage-loader/deploy/snowplow-storage-loader --config ${LOADER_CONFIG} >> $LOGFILE 2>&1

#check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
     echo "error in running the Storage Loader, exiting with return code${ret_val}." >> $LOGFILE 2>&1
     cat  $LOGFILE | mailx -s "Storage Loader Job Failure "  -r  noreply@unileversolutions.com  dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
#     cat  $LOGFILE | mailx -s " Global Raw Log Collection Failure "  -r  noreply@unileversolutions.com   UnileverUDMDSupport@sapient.com
     exit $ret_val
fi

echo " Storage Loader  Job completed Successfully" >> $LOGFILE 2>&1
echo "Removing the  raw Logs from the bucket udmd-global-p-raw-logs " >> $LOGFILE 2>&1
/usr/local/bin/aws s3 rb s3://udmd-global-p-raw-logs/ --force >> $LOGFILE 2>&1
/usr/local/bin/aws s3 mb s3://udmd-global-p-raw-logs >> $LOGFILE 2>&1
echo "EMRETL job completed successfully " >> $LOGFILE 2>&1
