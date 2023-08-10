#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if required arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 TARGET_IQN TARGET_PORTAL"
    exit 1
fi

TARGET_IQN=$1
TARGET_PORTAL=$2

# Logout of the iSCSI session
/host-sbin/iscsiadm -m node --targetname=$TARGET_IQN --portal=$TARGET_PORTAL -u

# Delete iSCSI target from database
/host-sbin/iscsiadm -m node -o delete --targetname=$TARGET_IQN --portal=$TARGET_PORTAL

echo "Deleted iSCSI session for target"