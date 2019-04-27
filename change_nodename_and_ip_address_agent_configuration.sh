#!/bin/bash

HOST=$1

hostname=$(ovdeploy -ovrg server -host $HOST -cmd "hostname" )

ind_ip=$(nslookup $HOST | grep | cut -d "" -f2 )


echo "---------Cambio hostname nel file di configurazione ovconfget dell'agente $HOST con quello corretto--------------""

ovdeploy -ovrg server -host -cmd “/opt/OV/bin/ovconfchg -ns eaagt -set OPC_NODENAME $hostname”


echo "--------Cambio indirizzo IP nel file di configurazione ovconfget dell'agente $HOST con quello corretto----------- "

/opt/OV/bin/ovdeploy -ovrg server -host $HOST -cmd “/opt/OV/bin/ovconfchg -ns eaagt -set OPC_IP_ADDRESS $ind_ip”


/opt/OV/bin/opcagt -restart
