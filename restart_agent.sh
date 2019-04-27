#!/bin/bash

HOST=$1


echo "--------Inizio stop agente------"

ovdeploy -host $HOST -cmd "/opt/OV/bin/opcagt -stop"
ovdeploy -host $HOST -cmd "/opt/perf/bin/ovpa -stop"
ovdeploy -host $HOST -cmd "/opt/perf/bin/pctl -stop"
ovdeploy -host $HOST -cmd "/opt/perf/bin/ttd -k"
ovdeploy -host $HOST -cmd "/opt/perf/bin/midaemon -T"

echo "-------Inizio restart agente------"

ovdeploy -host $HOST -cmd "/opt/perf/bin/ovpa -start"
ovdeploy -host $HOST -cmd "/opt/OV/bin/opcagt -start"


echo "---------Fine procedura--------------------"


exit 0
