#!/bin/bash

# Configure Additional Nic's
echo "Starting NIC Configuration for 2 NIC Deployment" >> /var/log/onboardnic.log

## Set DB Variables to allow for multi nic
    tmsh modify sys db provision.1nic value forced_enable
    tmsh modify sys db provision.1nicautoconfig value disable
    bigstart restart
## Check bigstart tmm status in a while loop here instaed of a static sleep, but will use this for now
    sleep 180

## Modify this to loop based on parameter above based on # of NIC's
    tmsh create net vlan external interfaces add { 1.0 { untagged }}
    tmsh create net self external_ip address 10.0.1.5/24 vlan external allow-service default
    tmsh create net route default gw 10.0.1.1
    tmsh save sys config

#reboot
echo "Ending NIC Configuration for 2 NIC Deployment" >> /var/log/onboardnic.log

exit
