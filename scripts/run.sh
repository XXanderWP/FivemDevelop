#!/bin/bash
pushd /fivem/server-data/ > /dev/null

read -p "Enter current FiveM Server license key [$(echo $FIVEM_LICENSE_KEY)]: " input

export FIVEM_LICENSE_KEY=${input:-$FIVEM_LICENSE_KEY}

read -p "Enter game build [$(echo $FIVEM_GAME_BUILD)]: " input2

export FIVEM_GAME_BUILD=${input2:-$FIVEM_GAME_BUILD}

RESOURCES="+set sv_licenseKey ${FIVEM_LICENSE_KEY} +set sv_enforceGameBuild ${FIVEM_GAME_BUILD} +sv_maxclients ${MAX_CLIENTS} +sv_hostname \"${FIVEM_PROJECT_NAME}\" +sets sv_projectName \"${FIVEM_PROJECT_NAME}\" +sets sv_projectDesc \"${FIVEM_PROJECT_DESC}\""



RESOURCES="$RESOURCES +set mysql_connection_string \"user=${MYSQL_USER};password=${MYSQL_PASSWORD};host=db;port=3306;database=${MYSQL_DATABASE};charset=utf8mb4\""

declare -a frameworks=("QBCore" "Standalone (No framework)")

echo "Select framework to launch"
select framework in "${frameworks[@]}";
do
  echo "Selected framework - \"${framework}\"";
  if [[ $framework = "" ]];
  then
    echo "You need to select correct framework index";
    echo "Select framework to launch"
  else
    echo "Framework selected";
    if [[ $framework = "QBCore" ]];
    then
      RESOURCES="$RESOURCES +ensure qb-core"
    fi;
    RESOURCES="$RESOURCES +ensure [${framework}]"
    break;
  fi;
done

RESOURCES="$RESOURCES +ensure [modules]"
RESOURCES="$RESOURCES +ensure [cs_modules]"


if [ $FIVEM_DEV = "1" ]; then
    /fivem/run.sh +exec server.cfg $RESOURCES +setr devcontainer 1 +sv_scriptHookAllowed 1 +sv_master1 ""
else
    /fivem/run.sh +exec server.cfg $RESOURCES
fi

popd > /dev/null