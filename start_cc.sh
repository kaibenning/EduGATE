#!/bin/bash

#
# set ROOT if not installed
#

# source ./local_root/root/bin/thisroot.sh

#
# Set simulation conigs via ROOT/GUI
#

(
cd ./edugate_src/Coincidence_Channel_2018/
root -l 'GenerateGateConfiguration.C( "Coin_Chan.txt" )'
)

#
# Perform EduGATE/GATE simulation
#

(
cd ./edugate_src/Coincidence_Channel_2018/

shell_paths="/cern/root-install/bin:/geant4/geant4.10.05-install/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/gate/gate_8.2-install/bin"
root="/cern/root-install/bin/thisroot.sh"
geant="/geant4/geant4.10.05-install/bin/geant4.sh"
mac="Coin_Chan.mac"

docker-compose run EduGATE /bin/bash -c "export PATH=$shell_paths && source $root && source $geant && cd /edugate_src/Coincidence_Channel_2018/ && Gate $mac"
docker-compose down
)

#
# Analyze/Visualize ROOT/GUI
#

(
cd ./edugate_src/Coincidence_Channel_2018/
root -l 'Coin_Chan.C'
)
