fx_version 'cerulean'
game 'gta5'

description 'Standalone-Template'
version '1.0.0'

shared_scripts {
    'config.lua'
}

server_scripts {
    'server/main.lua',
    'server/*.lua',
}



client_scripts {
    'client/main.lua',
    'client/*.lua',
}

lua54 'yes'
