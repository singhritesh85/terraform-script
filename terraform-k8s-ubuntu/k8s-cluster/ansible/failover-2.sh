#!/bin/bash

EIP=3.19.122.154
INSTANCE_ID=i-00c56ff8634152b78
export AWS_DEFAULT_REGION="us-east-2"

/usr/bin/aws ec2 disassociate-address --public-ip $EIP
/usr/bin/aws ec2 associate-address --public-ip $EIP --instance-id $INSTANCE_ID
