#!/bin/bash

HOST=nome_host

#Script per verificare l'utilizzo dei semafori da parte dei processi di sistema di un server remoto e con l'invio di una email di report

#Esecuzione script per generazione log

ssh $HOST "/opt/OV/contrib/OpC/semwho.sh >> /var/opt/OV/log/semwho.log"

output_semlog=$(ssh $HOST  "tail -31 /var/opt/OV/log/semwho.log")


echo "$output_semlog"

#Esecuzione commando per visualizzare lo stato attuale dei semafori

limit_sem=$(ssh $HOST "ipcs -s -l")

echo "$limit_sem"

state_sem=$(ssh $HOST "ipcs -s -u")

echo "$state_sem"
