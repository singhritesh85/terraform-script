#!/bin/bash
RUN_SCRIPT=`/opt/packer build template.json | tail -2`
AMI_ID=`echo $RUN_SCRIPT|cut -d ':' -f2`
echo $AMI_ID
echo 'variable "AMI_ID" { default = "'${AMI_ID//[[:blank:]]/}'" }' > newvariables.tf
