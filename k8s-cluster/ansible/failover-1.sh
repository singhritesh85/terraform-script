#!/bin/bash

EIP=18.220.46.18
INSTANCE_ID=i-03c596cbc64cf0bfe
export AWS_DEFAULT_REGION="us-east-2"

/usr/bin/aws ec2 disassociate-address --public-ip $EIP
/usr/bin/aws ec2 associate-address --public-ip $EIP --instance-id $INSTANCE_ID
