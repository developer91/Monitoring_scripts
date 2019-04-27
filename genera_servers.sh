#!/bin/bash

path_text_file=/home/user/Scripts_monitoraggio/data
path_script=/opt/HP/BSM/opr/bin


echo "Script per generazione servers dei servizi indicati"

for SERVICE in $(cat $path_text_file/servizi.txt);do $path_script/opr-node.sh -list_nodes -view_name $SERVICE -username user -password passwd | grep Primary > $path_text_file/servers_$SERVICE.txt;done

echo "Fine script"
