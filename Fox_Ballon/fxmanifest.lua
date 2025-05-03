fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
	"@uiprompt/uiprompt.lua",
	"client/client.lua",
	"client/utils.lua"
}

shared_scripts {
	'translation/translation.lua',
	'config.lua'
}

server_scripts {
	'server/server.lua'
}

dependencies {
	'vorp_core',
	'vorp_utils'
}

lua54 'yes'

author '<4NDR4D3/>'
description 'Andrade-Balloon | Join https://discord.gg/fBAQTBRvat'
version '1.0.0'
