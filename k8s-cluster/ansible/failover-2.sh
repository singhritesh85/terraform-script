#!/bin/bash

EIP=3.129.167.254
INSTANCE_ID=i-066cab7eb71dd0291
export AWS_DEFAULT_REGION="us-east-2"

/usr/bin/aws ec2 disassociate-address --public-ip $EIP
/usr/bin/aws ec2 associate-address --public-ip $EIP --instance-id $INSTANCE_ID
