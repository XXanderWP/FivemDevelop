if [ -d "/source/[cs_modules]/$1" ] 
then
    cd /source/[cs_modules]/$1
    dotnet restore
    dotnet publish -c Release
else
    echo "Resource $1 not found"
fi

