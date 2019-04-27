#!/bin/bash

path_script=$1
script=$2
path_text_file=$3
email="indirizzo_email"

case $script in

check_agent_ito.sh)

#Creazione e invio email per ogni host presente nella lista data come input

for HOST in $(cat $3/hosts.txt);do $1/check_agent_ito.sh $HOST | mailx -s "REPORT CHECK NODI" $email;done

exit 0


check_sem.sh)

#Creazione e invio email per ogni host presente nella lista data come input

$1/check_sem.sh | mailx -s "REPORT CHECK SEM EVERY DAY" $email

exit 0

esac
