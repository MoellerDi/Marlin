#/bin/bash

#####################################

YOUR_API_KEY= <add your own api key here>

REPOSRC=https://github.com/MoellerDi/Marlin.git
BRANCH=bugfix-1.1.x-HD-CR10

LOCALREPO=/tmp/CR10-Firmware

#####################################
### DO NOT MODIFY BELOW THIS LINE ###
#####################################
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    git clone -b $BRANCH $REPOSRC $LOCALREPO
    cd $LOCALREPO
else
    cd $LOCALREPO
    git pull
fi

# disconnect octoprint to allow programmer to connect
curl -s -H "Content-Type: application/json" -H "X-Api-Key: $YOUR_API_KEY" -X POST -d '{ "command":"disconnect" }' http://octopi.local/api/connection
sleep 2

# build and upload firmware to CR-10
pio run -e cr10 -t upload

# re-connect octoprint
sleep 5
curl -s -H "Content-Type: application/json" -H "X-Api-Key: $YOUR_API_KEY" -X POST -d '{ "command":"connect" }' http://octopi.local/api/connection
