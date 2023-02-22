fx_version 'adamant'

game 'gta5'

description 'ESX Pool Cleaner'

version '1.1'

lua54 'yes'

shared_scripts {'@es_extended/imports.lua', '@ox_lib/init.lua'}

client_scripts {
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'client/main.lua',
	'config.lua',
	'vehicles.meta',
	'carvariations.meta',
	'carcols.meta',
}

data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

server_scripts {
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'server/main.lua',
	'config.lua',
}
