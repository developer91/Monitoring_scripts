#!/bin/bash

host_from_execute=gw_or_dps_server
EMAIL=propria_email

#restituisco i 14 processi presenti sul server remoto relativo all'agente HP che sono in stato Running e me li conta
services_status=$(/opt/OV/bin/ovrc -ovrg server -host $host_from_execute -status | head -n 14 | grep Running | wc -l)

#restituisce l'esito del commando eseguito precedentemente
result=$?

if [ $result -eq 0 ]; then

        echo "Non sono stati rilevati problemi di communicazione con l'agente HP sul server remoto..."


        #restituisco i processi con stato diverso da Running (totale sono 14 processi), quindi conto le righe dei processi che hanno lo stato diverso da Running, se c'è almeno un processo non in Run 
                if [ $services_status -ne  14 ]; then

                        echo "Warning! L'agente ha almeno un processo non in stato Running..."

                        services_restart=$(/opt/OV/bin/ovdeploy -ovrg server -host $host_from_execute -cmd "/opt/OV/bin/opcagt -restart")

                        #controllo dei processi dopo l'operazione di riavvio
                        check_services_restart=$(/opt/OV/bin/ovrc -ovrg server -host $host_from_execute -status | head -n 14 | grep -v Running | wc -l)

			if [ $check_services_restart -ne 0 ]; then

                        echo "Stato Processi sul server $host_from_execute:\n $(/opt/OV/bin/ovrc -ovrg server -host $host_from_execute -status | head -n 14 | grep -v Running)" | mailx -s "Operazione di restart di tutti i processi non completata correttamente, ci sono ancora dei processi non attivi....\n" $EMAIL
				
				mailx -s "Riavvio di tutti i processi dell'agente HP sul server $host_from_execute completato correttamente..." $EMAIL
                        fi

        #in caso contratio, se non ci sono righe, vuol dire che tutti i processi sono in Running
                else
                        mailx -s "OK: L'agente HP del server $host_from_execute, ha tutti i processi attivi" $EMAIL

                fi

else
        echo "ERROR: Problemi di comunicazione con l'agent del server $host_from_execute..."
fi
