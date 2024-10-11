fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
version "1.0.0"
description "A simple hud system"
name 'krs_hud'
author "karos7804"

shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'ui/index.html'

files{
    'ui/style.css',
    'ui/script.js',
    'ui/index.html',
    'ui/logo.png',
}