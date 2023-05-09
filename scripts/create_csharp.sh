if [ -d "/source/[cs_modules]/$1" ] 
then
    echo "Resource $1 already exist"
else
    dotnet new -i CitizenFX.Templates
    eval "mkdir /source/[cs_modules]/$1"
    eval "cd /source/[cs_modules]/$1"
    dotnet new cfx-resource
    dotnet restore
fi

