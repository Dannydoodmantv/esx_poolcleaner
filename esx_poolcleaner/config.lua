Config                            = {}
Config.DrawDistance               = 30.0
Config.Locale                     = 'en'
Config.nameJob					  = 'poolcleaner' -- The name of the job. Important to not misspell or else it won't work
Config.Item						  = 'poolreceipt' -- Name of the item which is given and then sold by the player
Config.Multiplier				  = '100' -- This how much money do want so a 100x multiplier is 100$ for 1 receipt
Config.Cleantime				  = '20000' -- It is in ms so this would be 20 seconds
-- Controls
Config.KeyClean 				  =  38 -- Control for starting the cleaning in the marker.  || All controls can be found here https://docs.fivem.net/docs/game-references/controls/
Config.Key  					  =  38	-- Control for opening menus in markers	
Config.KeyJobStart 				  =  212 -- Control for starting and ending job


Config.Blip = {
	Sprite = 389,
	Color = 3,
}

Config.Vehicles = {
	Hash = "bison" -- Hash of the vehicle. All of the hashes can be found here https://gtahash.ru/car/
}


Config.WorkUniform = {
	job_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 17, ['torso_2'] = 4,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 5,
			['pants_1'] = 16, ['pants_2'] = 3,
			['shoes_1'] = 16, ['shoes_2'] = 0,
			['helmet_1'] = 15, ['helmet_2'] = 1,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 2, ['tshirt_2'] = 0,
			['torso_1'] = 195, ['torso_2'] = 24,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 15,
			['pants_1'] = 16, ['pants_2'] = 11,
			['shoes_1'] = 16, ['shoes_2'] = 4,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0
		}
	  },
}


Config.Zones = {
	Cloakroom = {
		Pos = vector3(-1320.2,-1263.4,2.7),
		Type = 21,
		R = 255, 
		G = 255, 
		B = 255,
		Size = 1.0,
	},

	VehicleSpawn = {
		Pos = vector3(-1307.94, -1250.86,  4.54),
		Type = 36,
		R = 255, 
		G = 255, 
		B = 255,
		Size = 1.0,
	},

	VehicleSpawnPoint = {
		Pos   = {x = -1320.75, y = -1254.54, z = 3.6},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Heading = 258.27,
	},

	VehicleDeleter = {
		Pos = vector3(-1309.57, -1243.54,  4.54),
		Type = 36,
		R = 255, 
		G = 0, 
		B = 0,
		Size = 1.0,
	},

	ReceiptSell = {
		Pos = vector3(-1307.7445, -1261.7769, 4.5388),
		Type = 29,
		R = 0, 
		G = 255, 
		B = 0,
		Size = 1.0,
	},

}
Config.Pool = { 
	R = 186, 
	G = 12, 
	B = 0,
	Type = 2,
	Size = 1.0,
	vector3{ -1342.4207, -930.7485, 11.7531}, 
	vector3{ -582.2297, 104.5204, 68.3715}, 
	vector3{ -888.7083, -40.6808, 38.2400}, 
	vector3{ 182.4090, -958.1177,  29.9652}, 
	vector3{ -853.4560, -67.3877, 37.8383}, 
	vector3{ -1186.5557, -231.0245, 37.9533}, 
	vector3{ -1337.1832, 341.9789, 64.0778}, 
	vector3{ -1365.6512, 335.4437, 64.4799}, 
	vector3{ -17.2614, 328.3167, 113.1608}, 
	vector3{ 878.5097, -619.1213, 58.2980}, 
	vector3{ 897.8136, -636.0830, 58.1027}, 
	vector3{ 952.2756, -687.3450, 57.5022}, 
	vector3{ 508.7499, 219.8696, 104.7481}, 

}


for i=1, #Config.Pool, 1 do -- this is the marker for the pools

	Config.Zones['Pool' .. i] = {
		Pos   = Config.Pool[i],
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 40, g = 169, b = 255},
		Type  = -1
	}

end

