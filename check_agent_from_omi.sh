
#!/bin/bash

HOST=$1
#check_distrib=$2


echo "-------Esecuzione controlli sull'agente del server $HOST------"
echo "-------Inizio Check------"


#verifica presenza agente e delle sue cartelle

echo "-------Controllo sulla presenza dell'agente e delle sue cartelle------"

#check_OV_directory=$(ovdeploy -ovrg server -host $HOST -cmd “ls \/opt\/OV\/”)
#check_netstat=$(ovdeploy -ovrg server -host $HOST -cmd “netstat -tulpn | grep 383”)
#check_ps_OV=$(ovdeploy -ovrg server -host $HOST -cmd “ps -ef | grep OV”)
#check_ps_ovc=$(ovdeploy -ovrg server -host $HOST -cmd “ps -ef | grep ovc”)

#echo "$check_OV_directory\n$check_netstat\n$check_ps_OV\n$check_ps_ovc"

# verifica raggiungibilità e communicazione tra OMi e nodo target 

echo "------Controllo sulla raggiungibilità e la comunicazione tra OMi e il nodo $HOST------" 

check_ping=$(/opt/OV/bin/bbcutil -ping $HOST)
check_port_agent=$(telnet $HOST  383)
check_ssh=$(telnet $HOST  22)

echo "$check_ping\n$check_port_agent\n$check_ssh"

echo "------Controllo dello stato dei processi dell'agente------"
check_processes_agent=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/opcagt")

echo "$check_processes_agent"


#Verifica file aperti da un determinato processo dell’agente
#ps -ef | grep nome_processo_agent
#lsof -p  | wc -l



echo "--------Controllo della versione dell'agente-------------"
check_agent_version=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/opcagt -version")

echo "$check_agent_version"


echo "--------Controllo del coreid dell'agente---------------"

check_coreid=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovcoreid")

echo "$check_coreid"


echo "----Controllo dei certificati presenti sul nodo-----"

check_cert_list=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovcert -list")
check_cert_check=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovcert -check")


echo "$check_cert_list\n$check_cert_check"

echo "----Controllo delle policies attive sul nodo-----"

check_policies=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovpolicy -l")


echo "$check_policies"

#Verifica policies standard e non standard attive sul noodo

echo "----Controllo di chi controlla il nodo-----"

check_manager=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovconfget | grep MANAGER")


echo "----Controllo OPC_HOSTNAME E OPC_IP_ADDRESS--"

check_ip_and_address=$(ovdeploy -ovrg server -host $HOST -cmd "/opt/OV/bin/ovconfget | grep OPC")

echo "$check_ip_and_address"



echo "----Verifica generazione e ricezione evento di test "

check_test_event=$(/opt/HP/BSM/opr/support/sendEvent.sh -s warning -c TEST -t "test from $HOST" -nd $HOST)

echo "$check_test_event"



#/opt/OV/bin/opcmsg 

echo "-----Fine Check-----"


#if [ $check_distrib = "TRUE" ]

#then

#echo "----Distribuzione files di configurazione-----"

#/utility/distrib_config_files -n  $HOST

#fi

exit 0
