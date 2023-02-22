Config                            = {}
Config.DrawDistance               = 100.0
Config.nameJob                    = "poolcleaner"
Config.nameJobLabel               = "Pool Cleaner"
Config.platePrefix                = "POOL"
Config.Locale                     = 'en'

Config.Blip = {
	Sprite = 389,
	Color = 3
}

Config.Vehicles = {
	Truck = {
		Spawner = 1,
		Label = 'Cleaner Utility',
		Hash = "bison",
		Livery = 1,
		Trailer = "none",
	}
}

Config.Zones = {
	Cloakroom = {
		
		Pos = vector3(-1320.2,-1263.4,2.7),

	},

	VehicleSpawn = {
		Pos = vector3(-1307.94, -1250.86,  4.54),

	},

	VehicleSpawnPoint = {
		Pos   = {x = -1320.75, y = -1254.54, z = 3.6},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = -1,
		Heading = 258.27,
	},

	VehicleDeleter = {
		Pos = vector3(-1309.57, -1243.54,  4.54),
	},

	ReceiptSell = {
		Pos = vector3(-1307.7445, -1261.7769, 4.5388),
	},

}
Config.Pool = {
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


for i=1, #Config.Pool, 1 do

	Config.Zones['Pool' .. i] = {
		Pos   = Config.Pool[i],
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 40, g = 169, b = 255},
		Type  = -1
	}

end
