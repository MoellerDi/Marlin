#/bin/bash

#####################################

YOUR_API_KEY= <add your own api key here>

REPOSRC=https://github.com/MoellerDi/Marlin.git
BRANCH=bugfix-2.0.x-HD-TronxyX5S

LOCALREPO=/tmp/TronxyX5S-Firmware-$BRANCH

OCTOPIHOST=octopi-x5s.local

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
    git diff
fi

# push a msg to printers display and disconnect octoprint to allow programmer to connect
curl -s -H "Content-Type: application/json" -H "X-Api-Key: $YOUR_API_KEY" -X POST -d '{ "commands": ["M503", "M117 upgrading Firmware"] }' http://$OCTOPIHOST/api/printer/command
curl -s -H "Content-Type: application/json" -H "X-Api-Key: $YOUR_API_KEY" -X POST -d '{ "command":"disconnect" }' http://$OCTOPIHOST/api/connection

# Update PlatformIO packages
platformio update

# build firmware and upload to Tronxy X5S
platformio run -e melzi_optiboot -t upload --upload-port /dev/ttyUSB0

# re-connect octoprint
sleep 5
curl -s -H "Content-Type: application/json" -H "X-Api-Key: $YOUR_API_KEY" -X POST -d '{ "command":"connect" }' http://$OCTOPIHOST/api/connection
