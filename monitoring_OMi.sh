#Monitoraggio dell'infrastruttura OMi

#!/bin/bash

EMAIL=propria_email
PATH_LOG=nome_path
PATH_SCRIPT1=/opt/HP/BSM/opr/support
PATH_SCRIPT2=/var/opt/OV/bin/instrumentation
SERVER=$1;

date >> $PATH/opr-status.log

$PATH_SCRIPT1/opr-status.py >> $PATH_LOG/opr-status.log

$PATH_SCRIPT2/OMiSmSendNotification -t email -a "$EMAIL" -s "OMi Status Server: $SERVER" -f $PATH_LOG/opr-status.log

return 0;
