#!/bin/bash

status=$1

switchstatus=$([ "$status" == "true" ] && echo "TRUE" || ([ "$status" == "false" ] && echo "FALSE" || echo "DISABLED"))

echo "Your choice is ${switchstatus} and I did not execute anything else"

phymem=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
swpmem=$(awk '/^SwapTotal:/{print $2}' /proc/meminfo)
echo $swpmem
echo $phymem
