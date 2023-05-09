declare -a array=("qb-adminmenu" "qb-ambulancejob" "qb-apartments" "qb-atms" "qb-banking" "qb-bankrobbery" "qb-busjob" "qb-cityhall" "qb-clothing" "qb-commandbinding" "qb-core" "qb-crypto" "qb-diving" "qb-doorlock" "qb-drugs" "qb-fitbit" "qb-garages" "qb-garbagejob" "qb-hotdogjob" "qb-houserobbery" "qb-houses" "qb-hud" "qb-input" "qb-interior" "qb-inventory" "qb-jewelery" "qb-keyminigame" "qb-lapraces" "qb-loading" "qb-lockpick" "qb-management" "qb-mechanicjob" "qb-menu" "qb-multicharacter" "qb-newsjob" "qb-pawnshop" "qb-phone" "qb-policejob" "qb-prison" "qb-radialmenu" "qb-recyclejob" "qb-scoreboard" "qb-scrapyard" "qb-shops" "qb-skillbar" "qb-smallresources" "qb-spawn" "qb-storerobbery" "qb-streetraces" "qb-target" "qb-taxijob" "qb-towjob" "qb-traphouse" "qb-truckerjob" "qb-truckrobbery" "qb-tunerchip" "qb-vehiclefailure" "qb-vehiclekeys" "qb-vehiclesales" "qb-vehicleshop" "qb-vineyard" "qb-weapons" "qb-weathersync" "qb-weed" )

arraylength=${#array[@]}

if [ -d "/source/[QBCore]" ] 
then
    echo "QBCore main folder exist"
else
    echo "Create QBCore main folder"
    mkdir /source/[QBCore]
fi

if [ -d "/fivem/server-data/resources/[QBCore]" ] 
then
    echo "QBCore symlink exist"
else
    echo "Create QBCore symlink"
    ln -s /source/[QBCore] /fivem/server-data/resources/
fi


installed=0
updated=0

for (( i=0; i<${arraylength}; i++ ));
do
    if [ -d "/source/[QBCore]/${array[$i]}" ] 
    then
        echo "Update QBCore module ${array[$i]} ($((i+1)) / ${arraylength})"
        updated=$((updated+1))
        cd /source/[QBCore]/${array[$i]} && git pull https://github.com/qbcore-framework/${array[$i]}.git --rebase --quiet
    else
        echo "Install QBCore module ${array[$i]} ($((i+1)) / ${arraylength})"
        installed=$((installed+1))
        git clone https://github.com/qbcore-framework/${array[$i]}.git /source/[QBCore]/${array[$i]} --quiet
    fi;
done;



echo "--------------------------------"
echo "Install QBCore modules complete"
echo "Installed  :  ${installed} modules"
echo "Updated    :  ${updated} modules"
python3 /source/scripts/database.py QBCore
echo "--------------------------------"
cd /source

