ESX                			 = exports["es_extended"]:getSharedObject()



RegisterServerEvent('p_cleanergive:givereceipt')
AddEventHandler('p_cleanergive:givereceipt', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	exports.ox_inventory:AddItem(_source, 'poolreceipt', 1)


end
)



RegisterServerEvent('p_sellreceipts')
AddEventHandler('p_sellreceipts', function(lockerNumber)
	local count = (100 * lockerNumber)
	local number = lockerNumber
	local _source = source
	local cansell = false
	local itemcount = exports.ox_inventory:GetItem(_source, 'poolreceipt')

		 if exports.ox_inventory:RemoveItem(_source, 'poolreceipt', lockerNumber) then
			exports.ox_inventory:AddItem(_source, 'money', count)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Prodal si <span style="color: green"; font-weight: "900">'..lockerNumber..'x <span style="color: white; font-weight: 500">účtenky'})
		 else	
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nemáš dostatek účtenek na prodej'})
		 end 

	--end		
end)

