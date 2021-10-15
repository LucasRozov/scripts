script_name('RozovMAP')
script_version('4.2')
script_author('Lucas')

ini = require 'inicfg'
cfg = ini.load({
    main = {
    	radius = 300,
    	color_s = 1,
    	color_f = 2,
    	react = 5,
    	markers = true    
    }
}, "TreasureMAP")

local state = false
local coords = {}
local pool = {}
local finded = {}
local markers = {}
local reaction = {-1, 3, 5, 10, 15}
local colors = {
	[1] = {0x00FF00FF, 	'������'},
	[2] = {0xFFFF00FF, 	'Ƹ����'},
	[3] = {0xFF0000FF, 	'�������'},
	[4] = {0x6666FFFF, 	'�����'},
	[5] = {0xFF5000FF, 	'�����'},
	[6] = {0xFFFFFFFF, 	'�����'},
	[7] = {0xFF00FFFF, 	'�������'},
	[8] = {0xAAAAAAFF, 	'�����'},
	[9] = {0x00FFFFFF, 	'�������'},
	[10] = {0xFF6060FF, '���������'},
	[11] = {0x1E90FFFF, '����� 2'},
	[12] = {0xFFD700FF, '�������'},
	[13] = {0x00FF7FFF, '������ �������'},
	[14] = {0xD2691EFF, '����������'},
}

function main()

while not isSampAvailable() do wait(100) end

	local lib, requests = pcall(require, 'requests')
	if lib then
		local responce = requests.get('https://raw.githubusercontent.com/LucasRozov/scripts/main/coords.js')
		if responce.status_code == 200 then
			local result = decodeJson(responce.text)
			if type(result) == 'table' then
				coords = result
				sampAddChatMessage(' >>{FFFFFF} RozovMAP by Lucas {1E90FF}|{FFFFFF} �������: {1E90FF}/rozovmap | {FFFFFF}�����: {1E90FF}' .. #coords, 0x1E90FF)
			else
				sampAddChatMessage(' >> RozovMAP: �� ������� �������������� ����������! ���������� ���� �����!', 0xFF2020)
				return
			end
		else
			sampAddChatMessage(' >> RozovMAP: �� ������� ��������� ���������� ������!', 0xFF2020)
			return
		end
	else
		sampAddChatMessage(' >> RozovMAP: ����������� ���������� "requests"! ������ ����������!', 0xFF2020)
		return
	end

	sampRegisterChatCommand('rozovmap', show_menu)
	addEventHandler('onScriptTerminate', function(script, quit)
		if script == thisScript() then 
			ini.save(cfg, 'TreasureMAP.ini')
			remove_markers()
			remove_all() 
		end
	end)

	while true do
		remove_markers()
		if state then
			local A = { getCharCoordinates(PLAYER_PED) }
			for i, B in ipairs(coords) do
				local dist = getDistanceBetweenCoords3d(A[1], A[2], A[3], B[1], B[2], B[3])
				if dist <= 20 and cfg.main.markers then 
					markers[i] = createUser3dMarker(B[1], B[2], B[3] + 1.5, 4)
				end
				if dist <= cfg.main.radius and pool[i] == nil then
					pool[i] = addBlipForCoord(B[1], B[2], B[3])
					changeBlipColour(pool[i], finded[i] and colors[cfg.main.color_f][1] or colors[cfg.main.color_s][1])
				elseif dist <= cfg.main.react and finded[i] == nil then
					finded[i] = true
					changeBlipColour(pool[i], colors[cfg.main.color_f][1])
				elseif dist > cfg.main.radius and pool[i] ~= nil then
					removeBlip(pool[i])
					pool[i] = nil
				end
			end
		end

		local result, button, list, _ = sampHasDialogRespond(101)
		if result and button == 1 then
			if list == 0 then
				state = not state
				if not state then remove_all() end
				show_menu()
			elseif list == 2 or list == 3 then
				cur_color = (list == 2 and 1 or 2)
				change_color()
			elseif list == 4 then
				for i = 1, #reaction do
					if cfg.main.react == reaction[i] then
						cfg.main.react = reaction[i + 1] or reaction[1]
						if cfg.main.react == -1 then finded = {}; remove_all(true) end
						show_menu()
						break
					end
				end 
			elseif list == 5 then
				cfg.main.markers = not cfg.main.markers
				show_menu()
			elseif list == 1 then
				local max = 500
				for i = 100, max, 100 do
					if cfg.main.radius == i then
						cfg.main.radius = (i == max and 100 or i + 100)
						show_menu()
						break
					end
				end 
			else
				show_menu()
			end
		elseif result and button == 0 then
			ini.save(cfg, 'TreasureMAP.ini')
		end

		local result, button, _, input = sampHasDialogRespond(102)
		if result then
			input = tonumber(input)
			if input ~= nil and button == 1 then
				if input < 1 or input > #colors then
					change_color()
				else
					cfg.main[cur_color == 1 and 'color_s' or 'color_f'] = input
					remove_all(true)
					show_menu()
				end
			else
				show_menu()
			end
		end

		wait(0)
	end
end

function show_menu()
	sampShowDialog(101, '{1E90FF}RozovMAP {FFFFFF}| ' .. #coords .. plural(#coords, {' �����', ' �����', ' �����'}), 
string.format([[
����� %s
������: {1E90FF}%s{FFFFFF} �.
���� �������: %s
���� �����������: %s
������ ��������: {1E90FF}%s{FFFFFF}
�������� �������: %s
 
�����: {1E90FF}Lucas
������ �������: {1E90FF}4.2
��� Discord-������: {1E90FF}https://discord.gg/wXH83zPuun
]], 
	state and '{00FF00}��������' or '{FF0000}�� ��������', 
	cfg.main.radius,
	('{%06X}%s'):format(rgba_to_rgb(colors[cfg.main.color_s][1]), colors[cfg.main.color_s][2]),
	('{%06X}%s'):format(rgba_to_rgb(colors[cfg.main.color_f][1]), colors[cfg.main.color_f][2]),
	cfg.main.react == -1 and '��������' or cfg.main.react .. ' �.',
	cfg.main.markers and '{00FF00}��' or '{FF0000}���'
	), 
'�������', '�������', 2)
end

function change_color()
	local get_colors = function()
		local result = ''
		for i = 1, #colors do
			result = ('%s{FFFFFF}%s = {%06X}%s'):format(result .. (i % 2 == 0 and '\t\t' or '\n'), i, rgba_to_rgb(colors[i][1]), colors[i][2])
		end
		return result
	end
	sampShowDialog(102, '{1E90FF}RozovMAP {FFFFFF}| ����� �����', 
		string.format('%s\n\n{AAAAAA}������� ����� �����:', get_colors()),
		'�������', '�����', 1
	)
end

function remove_all(bool_update)
	for i = 1, #coords do
		if pool[i] ~= nil then
			if bool_update then
				changeBlipColour(pool[i], finded[i] and colors[cfg.main.color_f][1] or colors[cfg.main.color_s][1])
			else
				removeBlip(pool[i])
				pool[i] = nil
			end
		end
	end
end

function remove_markers()
	for i, marker in pairs(markers) do
    	removeUser3dMarker(marker)
    	markers[i] = nil
	end
end

function rgba_to_rgb(rgba)
	local r = bit.band(bit.rshift(rgba, 24), 0xFF)
	local g = bit.band(bit.rshift(rgba, 16), 0xFF)
	local b = bit.band(bit.rshift(rgba, 8), 0xFF)
	return bit.bor(bit.bor(b, bit.lshift(g, 8)), bit.lshift(r, 16))
end

function plural(n, forms)
	n = math.abs(n) % 100
	if n % 10 == 1 and n ~= 11 then
		return forms[1]
	elseif 2 <= n % 10 and n % 10 <= 4 and (n < 10 or n >= 20) then
		return forms[2]
	end
	return forms[3]
end