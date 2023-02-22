
ESX                             =  exports["es_extended"]:getSharedObject()
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local BlipCloakRoom             = nil
local BlipVehicle               = nil
local BlipVehicleDeleter		= nil
local Blips                     = {}
local OnJob                     = false
local Done 						= false
local contextmenu  = false
local isinwork = false



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	onDuty = false
	CreateBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	CreateBlip()
end)

-- NPC MISSIONS

function SelectPool()
	local index = GetRandomIntInRange(1,  #Config.Pool)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Pool[index].x and v.Pos.y == Config.Pool[index].y and v.Pos.z == Config.Pool[index].z then
			print(k)
			return k
			
		end
	end
end

function StartNPCJob()

	NPCTargetPool     = SelectPool()
	local zone            = Config.Zones[NPCTargetPool]
	Blips['NPCTargetPool'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetPool'], true)
	exports['mythic_notify']:SendAlert('warn', 'Jeď na danou lokaci která je na mapě')
	Done = true
	Onjob = true

end

function StopNPCJob(cancel)
	if Blips['NPCTargetPool'] ~= nil then
		RemoveBlip(Blips['NPCTargetPool'])
		Blips['NPCTargetPool'] = nil
	end

	OnJob = false

	if cancel then
		exports['mythic_notify']:SendAlert('warn', 'Zrušil si objednávku')
	else
		TriggerServerEvent('p_cleanergive:givereceipt')
		StartNPCJob()
		Done = true
	end


end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if NPCTargetPool ~= nil then
			local v2 = GetEntityCoords(PlayerPedId())
			local zone = Config.Zones[NPCTargetPool]
			local zonec = vector3(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
			local playerPed = GetPlayerPed(-1)
			local dist = #(zonec - v2)
			if dist < 15 then
				DrawMarker(2, zone.Pos.x, zone.Pos.y, zone.Pos.z , 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
				if dist < 2 then
					lib.showTextUI('[E] - Vyčistit')
					if IsControlJustReleased(1, 38)  then
						lib.progressCircle({
							duration = 20000,
							position = 'bottom',
							useWhileDead = false,
							canCancel = false,
							disable = {
								car = true,
								move = true,
							},
							anim = {
								dict = 'amb@world_human_maid_clean@',
								clip = 'idle_e'
							},
						})
						StopNPCJob() 
						Done = false
					end
				end	

			end
		end
	end
end)


-- UNIFORMY


RegisterNetEvent('p_setuniform')
	AddEventHandler('p_setuniform', function()
		if isinwork == false then
		lib.progressCircle({
			duration = 4500,
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
			},
			anim = {
				dict = 'missmic4',
				clip = 'michael_tux_fidget'
			},
		})
		lib.notify({
			title = 'Pool Cleaner',
			description = 'Přišel si do práce',
			type = 'success',
			icon = 'person-digging'
		})
		onDuty = true
		isinwork = true
	elseif isinwork == true then
		lib.notify({
			title = 'Pool Cleaner',
			description = 'Již pracuješ',
			type = 'error',
			icon = 'x'
		})

	end
	end)

	RegisterNetEvent('p_setciv')
	AddEventHandler('p_setciv', function()
		if isinwork == true then
		lib.progressCircle({
			duration = 4500,
			position = 'bottom',
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
			},
			anim = {
				dict = 'missmic4',
				clip = 'michael_tux_fidget'
			},
		})
		lib.notify({
			title = 'Pool Cleaner',
			description = 'Odešel si z práce',
			type = 'error',
			icon = 'person-digging'
		})
		isinwork = false
		onDuty = false
	elseif isinwork == false then
		lib.notify({
			title = 'Pool Cleaner',
			description = 'Jěště  nepracuješ',
			type = 'error',
			icon = 'x'
		})
	end
	end)

	RegisterNetEvent('p_spawnvehicle')
	AddEventHandler('p_spawnvehicle', function()
		local playerPed = GetPlayerPed(-1)
		local coords    = Config.Zones.VehicleSpawnPoint.Pos
		local Heading    = Config.Zones.VehicleSpawnPoint.Heading
		local platenum = math.random(1000, 9999)
		local platePrefix = Config.platePrefix
		ESX.Game.SpawnVehicle('bison', coords, Heading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
			plate = GetVehicleNumberPlateText(vehicle)
			plate = string.gsub(plate, " ", "")
			name = 'Véhicule de '..platePrefix
			TriggerServerEvent('esx_vehiclelock:registerkeyjob', name, plate, 'no')
		end)

	end)


	lib.registerContext({
		id = 'p_cleaner_p',
		title = 'Převlíkárny',
		options = {
			{
				title = 'Pracovní oblečení',
				icon = 'fa-vest-patches',
				arrow = false,
				metadata = {'Začneš pracovat'},
				event = 'p_setuniform'
			},
			{
				title = 'Civilní oblečení',
				icon = 'fa-shirt',
				arrow = false,
				metadata = {'Přestaneš pracovat'},
				event = 'p_setciv'
	
			},
			{
				title = 'Pomoc',
				icon = 'fa-question',
				arrow = false,
				metadata = {'Zjistiš všechno ohledně práce'},
				onSelect = function()

					local alert =	lib.alertDialog({
						   header = 'Pomoc',
						   content = '1. Musíš se převléct  \n 2. Poté si vezmeš firemní vozidlo \n 3. Ve vozidle stiskneš klávesu HOME \n 4. V oranžovém markeru stiskneš klávesu E a poté dostaneš účtenku \n 5. Účtenku můžeš poté prodat u převlíkárny v zeleným markeru',
						   centered = true,
						   cancel = true
					   })
					   print(alert)
				   end
				   
	
			}
		}
	})

	lib.registerContext({
		id = 'p_cleaner_v',
		title = 'Garáž',
		options = {
			{
				title = 'Firemní vozidlo',
				icon = 'fa-car',
				arrow = false,
				metadata = {'Vytáhneš si firemní vozidlo'},
				event = 'p_spawnvehicle'
			},
		}
	})

-- Start work / finish work
function CloakRoomMenu()

	lib.showContext('p_cleaner_p')
	local contextmenu = true

end

function openhelpdialog()

 local alert =	lib.alertDialog({
		header = 'Pomoc',
		content = '1. Musíš se převléct  \n 2. Poté si vezmeš firemní vozidlo \n 3. Ve vozidle stiskneš klávesu HOME \n 4. V oranžovém markeru stiskneš klávesu E a poté dostaneš účtenku \n 5. Účtenku můžeš poté prodat u převlíkárny v zeleným markeru',
		centered = true,
		cancel = true
	})
	print(alert)
end


-- Spawn your work vehicle
function VehicleMenu()
	lib.showContext('p_cleaner_v')
end

function ReceiptSell()
	local input = lib.inputDialog('Prodejna účtenek', {'Počet na prodej'})
	if not input then return end
	local lockerNumber = tonumber(input[1])
	TriggerServerEvent("p_sellreceipts", lockerNumber)
end


function CreateBlip()
	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then
		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(-1320.2,-1263.4,2.7)
			SetBlipSprite(BlipCloakRoom, 214)
			SetBlipColour(BlipCloakRoom, 3)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Pool Cleaner')
			SetBlipScale(BlipCloakRoom, 0.8)
			EndTextCommandSetBlipName(BlipCloakRoom)
		end
	end
end

-- Activation of the marker on the ground
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if PlayerData.job ~= nil then
			local v1 = Config.Zones.Cloakroom.Pos
			local v3 = Config.Zones.VehicleSpawn.Pos
			local v4 = Config.Zones.VehicleDeleter.Pos
			local v5 = Config.Zones.ReceiptSell.Pos
			local playercoords = GetEntityCoords(PlayerPedId())
			local dist = #(v1 - playercoords)
			local dist2 = #(v3 - playercoords)
			local dist4 = #(v4 - playercoords)
			local dist5 = #(v5 - playercoords)
			local isInMarker  = false
			local currentZone = nil
			local DeleterShown = false
			local vehicle   = GetVehiclePedIsIn(PlayerPedId(),  false)

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_poolcleaner:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_poolcleaner:hasExitedMarker', LastZone)
			end	



			if PlayerData.job.name == Config.nameJob then
					if dist < 10  then
						DrawMarker(21, Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, nil, nil, false)
					end
					if dist2 < 10 and onDuty == true then
						DrawMarker(36, Config.Zones.VehicleSpawn.Pos.x, Config.Zones.VehicleSpawn.Pos.y, Config.Zones.VehicleSpawn.Pos.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, nil, nil, false)
							
					end
					if dist4 < 10 and IsPedInAnyVehicle(PlayerPedId(), false) then
						DrawMarker(36, Config.Zones.VehicleDeleter.Pos.x, Config.Zones.VehicleDeleter.Pos.y, Config.Zones.VehicleDeleter.Pos.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
						DeleterShown = true
					end
					if dist5 < 10  then
						DrawMarker(29, Config.Zones.ReceiptSell.Pos.x, Config.Zones.ReceiptSell.Pos.y, Config.Zones.ReceiptSell.Pos.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, nil, nil, false)

					end
					if dist < 2 then
						isInMarker  = true
						lib.showTextUI('[E] - Převlíkárny')
						if IsControlJustReleased(1, 38) then
							CloakRoomMenu()
						end
					elseif dist2 < 2 and onDuty == true then
						lib.showTextUI('[E] - Garáž')
						if IsControlJustReleased(1, 38) then
							VehicleMenu()
						end
					elseif dist4 < 2 and DeleterShown == true then
						lib.showTextUI('[E] - Uschovat vozidlo')
						if IsControlJustReleased(1, 38) then
							DeleteVehicle(vehicle)
						end
					elseif dist5 < 2 then
						lib.showTextUI('[E] - Prodat účtenky')
						if IsControlJustReleased(1, 38) then
							ReceiptSell()
						end
					else	
						lib.hideTextUI()	
					end
			
			end
		end



	end
end)


	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(7)
			
			if IsControlJustReleased(1, 212) and onDuty == true then
				if Onjob then
				StopNPCJob(true)
				RemoveBlip(Blips['NPCTargetPool'])
				Onjob = false
			else
				local playerPed = GetPlayerPed(-1)
				if IsPedInAnyVehicle(playerPed,  false) and IsVehicleModel(GetVehiclePedIsIn(playerPed,  false), GetHashKey("bison")) then
				StartNPCJob()
				Onjob = true
			else
				exports['mythic_notify']:SendAlert('error', 'Musíš sedět v firemním vozidle')
			end
		end
end
		end
	end)

