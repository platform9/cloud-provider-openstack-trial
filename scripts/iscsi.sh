#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if required arguments are provided
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 TARGET_IQN TARGET_PORTAL INITIATOR_NAME"
    exit 1
fi

TARGET_IQN=$1
TARGET_PORTAL=$2
INITIATOR_NAME=$3

# Set the InitiatorName
echo "InitiatorName=$INITIATOR_NAME" > /etc/iscsi/initiatorname.iscsi

# Perform iSCSI discovery
iscsiadm -m discovery --type sendtargets --portal $TARGET_PORTAL

# Log in to the target
iscsiadm -m node --targetname=$TARGET_IQN --portal $TARGET_PORTAL --login

echo "iSCSI configuration and login completed."
