fx_version 'adamant'
game 'gta5'
description 'Mafije na target sa lakom konfiguracijom,nesto novo :)'
Author 'Vulegg #5757 & Vaskezzyy #4303'

client_scripts {
    'config.lua',
    'klijent_s/**'
}

server_scripts {
    'config.lua',
    '@oxmysql/lib/MySQL.lua',
    'server_s/**'
}

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

shared_scripts{"@es_extended/imports.lua"}

dependencies {
 'es_extended',
 'oxmysql',
 'ox_inventory',
 'ox_lib',
 'okokNotify'
}