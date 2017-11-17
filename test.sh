#!/bin/bash

status=$1

switchstatus=$([ "$status" == "true" ] && echo "TRUE" || ([ "$status" == "false" ] && echo "FALSE" || echo "DISABLED"))

echo "Your choice is ${switchstatus} and I did not execute anything else"

