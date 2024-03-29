fx_version 'cerulean'
games { 'gta5' }

author "mVein#0710"

shared_scripts {
     '@qb-core/shared/locale.lua',
     'locale/tr.lua',
     'config.lua',
     'shared/shared.lua'
}

client_scripts {
     'client/lib.lua',
     'client/target/target.lua',
     'client/client_main.lua',
     'client/menu/menu.lua',
}

server_script {
     '@oxmysql/lib/MySQL.lua',
     'server/server_main.lua',
}

dependency 'oxmysql'

lua54 'yes'
 
