#!/bin/bash

LOGFILE=/data/apps/logs/UDMD/backup_`date +%m-%d-%y--%H-%M-%S`
date=`date +%m-%d-%y`
NAME="Prod $date"
InstanceId="i-5b11b0bd"
InRegion="eu-west-1"
CrossRegion="eu-central-1"

echo "Starting same region backup Production" >> $LOGFILE 2>&1
echo "Name of today's AMI --  $NAME" >> $LOGFILE 2>&1

AMINAME="Prod $(date -d "-1 days" +%m-%d-%y)"
echo "Yesterday AMI name is: " $AMINAME >> $LOGFILE 2>&1

C1=0;
echo "Taking AMI backup" >> $LOGFILE 2>&1
aws ec2 create-image  --instance-id $InstanceId  --no-reboot --name "$NAME" --description "Automated Backup" --region $InRegion > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

res1=`grep -ir "error" /tmp/logtest`
echo "RESULT is $res1" >> $LOGFILE 2>&1

if [[ $res1 == *"error"*  ]]; then
  echo "Backup Failed" >> $LOGFILE 2>&1
  C1=1;
else
  TAMIID="$(grep -i ImageId  $LOGFILE | head -1 | awk '{print $2}' | cut -f1 -d"," | cut -f2 -d'"')"
  echo "Ami ID for today's AMI is : $TAMIID" >> $LOGFILE 2>&1
  echo "Backup Taken successfully" >> $LOGFILE 2>&1
fi

echo "Finding Yesterday's AMI and deregistering it" >> $LOGFILE 2>&1
aws ec2 describe-images --filters "Name=name, Values=$AMINAME" --region $InRegion > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

AMIID="$(grep -i ImageId /tmp/logtest | tail -1 | awk '{print $2}' | cut -f1 -d"," | cut -f2 -d'"')"
echo "AMI ID to find is: " $AMIID >> $LOGFILE 2>&1

echo "Deregistering an AMI ID" >> $LOGFILE 2>&1
aws ec2 deregister-image --image-id $AMIID --region $InRegion > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

res2=`grep -ir "error" /tmp/logtest`
echo "RESULT is $res2" >> $LOGFILE 2>&1

C2=0;
if [[ $res2 == *"error"*  ]]; then
  echo "Deregistration Failed" >> $LOGFILE 2>&1
  C2=1;
else
  echo "Deregistration Successful" >> $LOGFILE 2>&1
fi

echo "Sleep the script for 5 min" >> $LOGFILE 2>&1
sleep 2m

echo "Cross Region Backup Start.." >> $LOGFILE 2>&1
CNAME="ProdC $date"
CAMINAME="ProdC $(date -d "-1 days" +%m-%d-%y) "
echo "Cross AMI Name $CNAME, Yesterday Cross AMINAME $CAMINAME" >> $LOGFILE 2>&1

aws ec2 copy-image --source-image-id $TAMIID  --source-region $InRegion  --region $CrossRegion  --name "$CNAME" > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

res3=`grep -ir "error" /tmp/logtest`
echo "RESULT is $res3" >> $LOGFILE 2>&1

C3=0;
if [[ $res3 == *"error"*  ]]; then
  echo "Cross Region Backup Failed" >> $LOGFILE 2>&1
  C3=1;
else
  CAMIID="$(grep -i ImageId  $LOGFILE | tail -1 | awk '{print $2}' | cut -f1 -d"," | cut -f2 -d'"')"
  echo "Ami ID for today's AMI Cross Region is : $CAMIID" >> $LOGFILE 2>&1
  echo "Cross Region Backup Taken successfully.." >> $LOGFILE 2>&1
fi

aws ec2 describe-images --filters "Name=name, Values=$CAMINAME" --region $CrossRegion  > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

CAMIID="$(grep -i ImageId  /tmp/logtest | tail -1 | awk '{print $2}' | cut -f1 -d"," | cut -f2 -d'"')"
echo "AMI ID to find is: " $CAMIID >> $LOGFILE 2>&1

echo "Deregistering an AMI ID" >> $LOGFILE 2>&1
aws ec2 deregister-image --image-id $CAMIID --region $CrossRegion  > /tmp/logtest 2>&1
cat /tmp/logtest >> $LOGFILE 2>&1

res4=`grep -ir "error" /tmp/logtest`
echo "RESULT is $res4" >> $LOGFILE 2>&1

C4=0;
if [[ $res4 == *"error"*  ]]; then
  echo "Cross Region Deregistration Failed" >> $LOGFILE 2>&1
  C4=1;
else
  echo "Cross Region Deregistration Successful" >> $LOGFILE 2>&1
fi

duration=$SECONDS >> $LOGFILE 2>&1
echo " UAT Total time taken by the job: $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed." >> $LOGFILE 2>&1

SUB1=""
echo "Value of C1 --> $C1, Value of C2 --> $C2, Value of C3 --> $C3, Value of C4 --> $C4" >> $LOGFILE 2>&1
if [[ $C1 -eq 1 && $C2 -eq 1 ]];  then
  SUB1="AMI Backup and Deregistation of AMI Failure"
elif [[ $C1 -eq 1 || $C2 -eq 1 ]];  then
  if [[ $C1 -eq 1 ]];    then
    SUB1="AMI Backup Failure, Deregistration Successful"
  else
    SUB1="Deregistration Failure, AMI Backup Successful"
  fi
else
  SUB1="Backup and Deregistration Successful"
fi
if [[ $C3 -eq 1 && $C4 -eq 1 ]];  then
  SUB="$SUB1 ,Cross Region Backup and Deregistation of AMI Failure"
  cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com dsingh66@sapient.com,gchaudhary@sapient.com, dbhatt@sapient.com
  #cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com  dbhatt@sapient.com
elif [[ $C3 -eq 1 || $C4 -eq 1 ]];  then
  if [[ $C3 -eq 1 ]];    then
    SUB="$SUB1 ,Cross Region Backup Failure, Deregistration Successful"
  else
    SUB="$SUB1 ,Cross Region Deregistration Failure, AMI Backup Successful"
  fi
  cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com  dsingh66@sapient.com,gchaudhary@sapient.com,dbhatt@sapient.com
 # cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com  dbhatt@sapient.com
else
  SUB="$SUB1 ,Cross Region Backup and Deregistration Successful"
  cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com  dsingh66@sapient.com,gchaudhary@sapient.com,dbhatt@sapient.com
  #cat  $LOGFILE | mailx -s "$SUB"  -r UDMD@unileversolutions.com  dbhatt@sapient.com
fi
