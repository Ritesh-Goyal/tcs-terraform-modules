#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo Begin: user-data

echo Begin: update and install packages
yum update -y
yum install -y aws-cli
yum install -y jq
echo End: update and install packages

echo Begin: start EC2
export AWS_DEFAULT_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
export AWS_REGION=$AWS_DEFAULT_REGION
export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
export AWS_ENV=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=environment" --region=$AWS_DEFAULT_REGION --output=json | jq -r .Tags[0].Value)


HOSTNAME="$AWS_ENV-server"
hostname $HOSTNAME
echo End: start EC2