#!/bin/bash

# Log file path
LOGFILE=/data/apps/logs/UDMD/geoip/log_`date +%m-%d-%y--%H-%M-%S`
CHECK=0;

# Run  geoipupdate command, installed from GIT Source refer to http://dev.maxmind.com/geoip/geoipupdate/
geoipupdate -v >> $LOGFILE 2>&1

# Check the damage
ret_val=$?
if [ $ret_val -ne 0 ]; then
    CHECK=1;
    echo " Prod Error in running the Geo IP Update job  ${ret_val}."  >> $LOGFILE 2>&1
    cat  $LOGFILE | mailx -s " Maxmind DB Update Prod: Error in updating  "  -r noreply@unileversolutions.com dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
    exit $ret_val
fi

# Upload the files to s3
    echo "Uploading files to S3 Bucket." >> $LOGFILE 2>&1

# Upload GeoIPCity.dat file
aws s3 cp /usr/local/share/GeoIP/GeoIPCity.dat s3://udmd-p-geodatabase/geoipcity/GeoIPCity.dat >> $LOGFILE 2>&1

# Upload GeoIPDomain.dat file
aws s3 cp /usr/local/share/GeoIP/GeoIPDomain.dat s3://udmd-p-geodatabase/geoipdomain/GeoIPDomain.dat >> $LOGFILE 2>&1

# Upload GeoIPISP.dat file
aws s3 cp /usr/local/share/GeoIP/GeoIPISP.dat  s3://udmd-p-geodatabase/geoipisp/GeoIPISP.dat >> $LOGFILE 2>&1

# Upload GeoIPOrg.dat file
aws s3 cp /usr/local/share/GeoIP/GeoIPOrg.dat  s3://udmd-p-geodatabase/geoiporg/GeoIPOrg.dat >> $LOGFILE 2>&1

# Upload GeoIP2-City.mmdb file
aws s3 cp /usr/local/share/GeoIP/GeoIP2-City.mmdb  s3://udmd-p-geodatabase/geolitecity/GeoIP2-City.mmdb >> $LOGFILE 2>&1

if [ $CHECK == 0 ]; then
     echo " Prod GeoIp Update job " >> $LOGFILE 2>&1
     duration=$SECONDS
     echo " Prod Total time taken by the job: $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed." >> $LOGFILE 2>&1
     cat $LOGFILE | mailx -s " Maxmind DB Update Prod: Success " -r noreply@unileversolutions.com  dbhatt@sapient.com, gchaudhary@sapient.com, dsingh66@sapient.com
fi
