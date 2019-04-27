#!/bin/bash

target_aspect=$1
path_script=/opt/HP/BSM/opr/bin
path_destination_policies=/home/user/scripts/Policies/

echo "--------------Elenco policies associate all'aspect $1---------"


result=$($path_script/opr-config-tool.sh -username user -password passwd -list_containment -type template -parent_type aspect -parent_name $target_aspect | cut -d "\"" -f2 > $path_destination_policies/Policies_$target_aspect.txt)

exit 0
