if [ -d "/source/[modules]/$1" ] 
then
    echo "Resource $1 already exist"
else
    echo "Creating resource $1..."
    cp -a /source/data/templates/standalone/. /source/[modules]/$1
    echo "Creating resource $1 complete"
fi

