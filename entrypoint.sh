#!/bin/sh
echo "Server is being started"
echo "**************************"
jmeter-server -Dserver.rmi.localport=50000 -Dserver_port=1099 -Dserver.rmi.ssl.disable=true
echo "**************************"
echo "Execution has been completed, please check the artifacts to download the results."

