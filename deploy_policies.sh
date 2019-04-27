#!/bin/bash

host=$1
aspect=$2

#ritorno l'aspect spefico desiderato

Aspect_ID=$(/opt/HP/BSM/opr/bin/opr-assign.sh -username user -password passwd -list_aspect | grep "$aspect" | cut -d '"' -f3)

echo "-----inizio deploying policies per monitoraggio standard Linux-----"

#assegno gli aspects trovati al nodo target
ci_id=$(/opt/HP/BSM/opr/bin/opr-ci-list -username user -password passwd -node_list $host | grep "ID" | cut -d ":" -f2)

/opt/HP/BSM/opr/bin/opr-assign.sh -username user -password passwd -create_assignment_by_aspect $ci_id $Aspect_ID

echo "-----fine deploying policies per monitoraggio standard Linux-----"

exit 0
