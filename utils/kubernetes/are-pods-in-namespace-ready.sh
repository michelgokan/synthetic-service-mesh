#!/bin/bash
ROOTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd ../../ && pwd -P )"

if [ -z "$1" ]
then
   echo "Usage: are-pods-in-namespace-ready.sh <namespace-name>"
   echo "Error: Please enter the namespace name"
   exit 1
fi


kube_result=$($ROOTPATH/utils/kubernetes/get-pods-in-namespace.sh $1 | jq .items[].status.phase -r | grep -vE '(^Running$)|(^Succeeded$)')
if [ -z "$kube_result" ]
then
   echo "1"
else
   echo "0"
fi
