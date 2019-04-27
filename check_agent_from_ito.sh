#Script per Monitoraggio macchine specifiche e controlli sugli agenti di monitoraggio (dal manager server ITO)

#!/bin/bash

datetime=$(date)
HOST=$1
check_distrib=$2
gw_server_prod=nome_gw_di_prod
gw_server_test=nome_gw_di_test
id_manager_omi_prod=$(ovdeploy -host $gw_server_prod -cmd "/opt/OV/bin/ovconfget | grep MANAGER_ID")
id_manager_omi_system=$(ovdeploy -host $gw_server_test -cmd "/opt/OV/bin/ovconfget | grep MANAGER_ID")

HOSTNAME=$(ovdeploy -host $HOST -cmd "hostname")
OPC_NODENAME=$(ovdeploy -host $HOST -cmd "/opt/OV/bin/ovconfget eaagt OPC_NODENAME")
OPC_IP_ADDRESS=$(ovdeploy -host $HOST -cmd "/opt/OV/bin/ovconfget eaagt OPC_IP_ADDRESS")
#IP_ADDRESS=$(nslookup $HOST | grep "Address" | cut -d "#" -f4 | cut -d ":" -f2| cut -d " " -f2)
IP_ADDRESS=$(nslookup $HOST | grep "Address" | cut -d "#" -f4 | cut -c10-22 | tr -d "\n")



if [ -z "$OPC_IP_ADDRESS" ]

then

OPC_IP_ADDRESS=0

fi


if [ "$OPC_NODENAME" == "" ]

then

OPC_NODENAME="null"

fi

echo "-------Inizio Check in Data: $datetime------------"

printf "\n"
echo "-------Server controllato: $HOST---------------- "

printf "\n"

echo "------Controllo dello stato dei processi dell'agente------"
ovdeploy -host $HOST -cmd "/opt/OV/bin/opcagt"


echo "-------------Controllo dei certificati presenti sul nodo---------------"

ovdeploy -host $HOST -cmd "/opt/OV/bin/ovcert -list"


echo "-------------Controllo delle policies attive sul nodo------------------"

ovdeploy -host $HOST -cmd "/opt/OV/bin/ovpolicy -l"

echo "-------------Core ID attuale presente sull'agente----------------------"

ovdeploy -host $HOST -cmd "/opt/OV/bin/ovcoreid"


echo "-------------Controllo quale manager  controlla il nodo--------------"
printf "\n"

ovdeploy -host $HOST -cmd "/opt/OV/bin/ovconfget | grep MANAGER"

echo "-------------Controllo dell'id del manager se corrisponde a quello corretto------"

MANAGER_ID=$(ovdeploy -host  $HOST -cmd "/opt/OV/bin/ovconfget | grep MANAGER_ID")


echo "ID_file_Manager:$MANAGER_ID"
echo "ID_manager_OMI_System: $id_manager_omi_system"


#if [ $MANAGER_ID = $id_manager_omi_prod ]

#then

#echo "Nel file di configurazione dell'agente è configurato l'id del manager OMi di Produzione,Id_file_manager:$MANAGER_ID,Id_manager_prod:$id_manager_omi_prod"

#else if [ $MANAGER_ID = $id_manager_omi_system  ]

#then 

#echo "Nel file di configurazione dell'agente è configurato l'id del manager OMi di System-Test, Id_file_manager:$MANAGER_ID,Id_manager_system:$id_manager_omi_system"

#else 

#echo "Nel file di configurazione dell'agente è configurato un id che non corrisponde al manager OMi nè di Produzione nè di System-Test, Id_file_manager:$MANAGER_ID"

#fi

printf "\n"

echo "---------------Controllo OPC_HOSTNAME E OPC_IP_ADDRESS--------------------"

#ovdeploy -host $HOST -cmd "/opt/OV/bin/ovconfget | grep OPC"

#Verifica dell'hostname

if [ "$OPC_NODENAME" ==  "$HOSTNAME" ]

then


echo "hostname not changed"

else

echo "hostname has changed, new value: $OPC_NODENAME"

fi

#Verifica dell'indirizzo IP

if [ "$OPC_IP_ADDRESS" ==  "$IP_ADDRESS" ] 

then

echo "ip address not changed"

printf "\n"

else

echo "ip address has changed, new value: $OPC_IP_ADDRESS"
printf "\n"

fi

echo "-----Fine Check-----"


#if [ "$check_distrib" = "TRUE" ]

#then

#echo "----Distribuzione files di configurazione-----"

#/utility/distrib_config_files -n  $HOST


#fi

exit 0
