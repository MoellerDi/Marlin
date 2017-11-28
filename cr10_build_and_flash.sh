#/bin/bash

LOCALREPO=/tmp/CR10-Firmware

REPOSRC=https://github.com/MoellerDi/Marlin.git
BRANCH=bugfix-1.1.x-HD-CR10

#####################################################################
# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    git clone -b $BRANCH $REPOSRC $LOCALREPO
    cd $LOCALREPO
else
    cd $LOCALREPO
    git pull $REPOSRC
fi

# run platformio to build firmware
pio run -e cr10

