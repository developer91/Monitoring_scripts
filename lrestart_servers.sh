#Script per estrazione servers in base al servizio e restart di ogni agente 

#!/bin/bash

path_script=/opt/HP/BSM/opr/bin
path_text_file=/home/user/Scripts_monitoraggio


for SERVICE in $(cat $path_text_file/servizi.txt);do $path_script/opr-node.sh -list_nodes -view_name $SERVICE -username user -password passwd | grep Primary > servers_$SERVICE.txt

for HOST in $(cat $path_text_file/servers_$SERVICE.txt | cut -d "=" -f2);do $path_text_file/test_restart_agent_2.0.sh $HOST; done
