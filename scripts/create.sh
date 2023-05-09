declare -a types=("LUA_QBCore" "C#")


read -p "Enter module name: " input

echo "Select type of module"
select type in "${types[@]}";
do
  echo "Selected type - \"${type}\"";
  if [[ $type = "" ]];
  then
    echo "You need to select correct type of module";
    echo "Select type of module"
  else
    echo "Type selected";
    if [[ $type = "C#" ]];
    then
        sh /source/scripts/create_csharp.sh $input
    fi
    if [[ $type = "LUA_QBCore" ]];
    then
        sh /source/scripts/create_qbcore.sh $input
    fi
    break;
    
  fi;
done
