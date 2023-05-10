fx_version 'cerulean'
game 'gta5'

description 'QB-Template'
version '1.0.0'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'qb-core'
}

client_script 'client/main.lua'

lua54 'yes'
