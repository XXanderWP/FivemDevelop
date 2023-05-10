if [ -d "/fivem/server-data/resources" ] 
then
    echo "Resource folder already exist"
else
    mkdir /fivem/server-data/resources/
fi

declare -a array=("modules" "cs_modules")

arraylength=${#array[@]}

for (( i=0; i<${arraylength}; i++ ));
do
    if [ -d "/source/[${array[$i]}]" ] 
    then
        echo "${array[$i]} folder already exist"
    else
        echo "${array[$i]} folder created"
        mkdir /source/[${array[$i]}]
    fi;

    if [ -d "/fivem/server-data/resources/[${array[$i]}]" ] 
    then
        echo "${array[$i]} symlink exist"
    else
        echo "Create ${array[$i]} symlink"
        ln -s /source/[${array[$i]}] /fivem/server-data/resources/
    fi
done;



if [ -d "/fivem/server-data/resources/oxmysql" ] 
then
    echo "oxmysql already exist"
else
    wget https://github.com/overextended/oxmysql/releases/download/v2.6.0/oxmysql.zip -O oxmysql.zip
    unzip oxmysql.zip -d /fivem/server-data/resources
    rm oxmysql.zip
fi


if [ -d "/fivem/server-data/resources/menuv" ] 
then
    echo "menuv already exist"
else
    wget https://github.com/ThymonA/menuv/releases/download/v1.4.1/menuv_v1.4.1.zip -O menuv.zip
    unzip menuv.zip -d /fivem/server-data/resources/menuv
    rm menuv.zip
fi


if [ -d "/fivem/server-data/resources/PolyZone" ] 
then
    echo "PolyZone already exist"
else
    wget https://github.com/mkafrin/PolyZone/releases/download/v2.6.1/PolyZone.zip -O PolyZone.zip
    unzip PolyZone.zip -d /fivem/server-data/resources/PolyZone
    rm PolyZone.zip
fi


if [ -d "/fivem/server-data/resources/mythic_notify" ] 
then
    cd /fivem/server-data/resources/mythic_notify
    git pull https://github.com/XXanderWP/mythic_notify --rebase
else
    git clone https://github.com/XXanderWP/mythic_notify /fivem/server-data/resources/mythic_notify
fi

cd /source