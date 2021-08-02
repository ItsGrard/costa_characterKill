
fx_version '44febabe-d386-4d18-afbe-5e627f4af937'
game 'gta5'

author 'Grard'
description 'Simple resource to allow admins to perform a CharacterKill with a command from inside the server for Roleplay servers'
version '1.0.0'

client_scripts 'client.lua'
server_script {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',	
	'locales/es.lua',
	'config.lua',
	'server.lua'
}
