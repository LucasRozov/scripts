script_name('ROZOVHELPER') -- название скрипта
script_author('HAYDEN') -- автор скрипта
script_description('ADMIN TUCSON') -- описание скрипта
script_name("ADMIN HELPER")
script_version("1.2")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/scripts/main/ahelper.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/LucasRozov/scripts/tree/main"
        end
    end
end

require "lib.moonloader" -- подключение библиотеки
local keys = require "vkeys"

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local prefix = Roza
local se = require 'samp.events'

function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Скрипт успешно загружен.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Регламент был обновлен 9.08.2022.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Версия: 1.2', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} 2281337', -1)

sampRegisterChatCommand("zz", cmd_zz)
sampRegisterChatCommand('cheat', cmd_cheat)
sampRegisterChatCommand('zapret', cmd_zapret)
sampRegisterChatCommand('caps', cmd_caps)
sampRegisterChatCommand('db', cmd_db)
sampRegisterChatCommand('mg', cmd_mg)
sampRegisterChatCommand('ppv', cmd_ppv)
sampRegisterChatCommand('dm', cmd_dm)
sampRegisterChatCommand('copov', cmd_copov)
sampRegisterChatCommand('sbiv', cmd_sbiv)
sampRegisterChatCommand('upom', cmd_upom)
sampRegisterChatCommand('oskrod', cmd_oskrod)
sampRegisterChatCommand('ght', cmd_ght)
sampRegisterChatCommand('ghc', cmd_ghc)
sampRegisterChatCommand('spl', cmd_spl)
sampRegisterChatCommand('spc', cmd_spc)
sampRegisterChatCommand('test228', cmd_)
sampRegisterChatCommand('lvpd', cmd_lvpd)
sampRegisterChatCommand('', cmd_)

 
 while true do
  wait(0)

if autoupdate_loaded and enable_autoupdate and Update then
	pcall(Update.check, Update.json_url, Update.prefix, Update.url)
end
  
 end
end

function se.onServerMessage(color, text)
	if color == 0x73B461FF and text:match('^%[ News .. %]') then
		return false
	end

	if 	text:find('В нашем магазине ты можешь приобрести нужное количество игровых денег и потратить', 1, true) or 
		text:find('их на желаемый тобой {FFFFFF}бизнес, дом, аксессуар{6495ED} или на покупку каких-нибудь безделушек.', 1, true) or 
		text:find('Игроки со статусом {FFFFFF}VIP{6495ED} имеют большие возможности, подробнее /help [Преимущества VIP]', 1, true) or
		text:find('можно приобрести редкие {FFFFFF}автомобили, аксессуары, воздушные шары', 1, true) or
		text:find('предметы, которые выделят тебя из толпы! Наш сайт: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if
		text:find('Вы были телепортированы в интерьер №18 (Las Venturas Police Department)', 1, true) then
		return false
	end

	-- Вы телепортировали игрока %d в админ-зону №2 (Arizona Interior №2)

	if
		text:find(' Вы были телепортированы в админ-зону №2 (Arizona Interior №2)', 1, true) then
		return false
	end
end

sampRegisterChatCommand("cheat", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Чит", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили игрока на 30 дней с причиной: Чит'),-1)
	end
end)

sampRegisterChatCommand("zz", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/warn %d DeathMatch в ЗЗ", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заварнили игрока с причиной: DeathMatch в ЗЗ'),-1)
	end
end)

sampRegisterChatCommand("sbiv", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 Сбив анимации", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно посадили игрока под ID: %d c причиной: DeathMatch в ЗЗ', id),-1)
	end
end)

sampRegisterChatCommand("ght", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно телепортировали игрока под ID: %d к себе', id),-1)
	end
end)

sampRegisterChatCommand("ghc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/getherecar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно телепортировали машину под ID: %d к себе', id),-1)
	end
end)

sampRegisterChatCommand("spl", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заспавнили игрока под ID: %d', id),-1)
	end
end)

sampRegisterChatCommand("spc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/spcar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно заспавнили машину под ID: %d', id), -1)
	end
end)

sampRegisterChatCommand("caps", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 30 CapsLock", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили игрока под ID: %d. Причина: СapsLock', id), -1)
	end
end)

sampRegisterChatCommand("mg", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 MetaGaming", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили игрока под ID: %d. Причина: MetaGaming', id),-1)
	end
end)

sampRegisterChatCommand("desc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/adeldesc %d 2 NonRP описание персонажа", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно удалили описание игрока под ID: %d. Причина: NonRP описание персонажа', id),-1)
	end
end)

sampRegisterChatCommand("torg", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 Торговля в /j", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили игрока под ID: %d. Причина: Торговля в /j', id),-1)
	end
end)

sampRegisterChatCommand("oskrod", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Оскорбление родных", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно замутили игрока под ID: %d. Причина: Торговля в /j', id),-1)
	end
end)

sampRegisterChatCommand("afk", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/kick %d AFK w/o ESC", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно кикнули игрока под ID: %d. Причина: AFK w/o ESC', id),-1)
	end
end)

sampRegisterChatCommand("no_damage", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 20 ДМ в ЗЗ [Без урона]", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно кикнули игрока под ID: %d. Причина: AFK w/o ESC', id),-1)
	end
end)

sampRegisterChatCommand("deagle", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите радиус и количество патронов!', -1)
	else
		sampSendChat(string.format("/gunall %d 24 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно выдали Desert Eagle [24] в радиусе %d в количестве %d патронов.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("upom", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 5 Упоминание родных", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили игрока на 5 дней с причиной: Упоминание родных'),-1)
	end
end)

sampRegisterChatCommand("db", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 DB", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно посадили игрока под ID: %d c причиной: DB', id),-1)
	end
end)

-- Вы были телепортированы в админ-зону №2 (Arizona Interior №2)

sampRegisterChatCommand("az", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampSendChat(string.format("/az"))
		sampAddChatMessage('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы были телепортированы в админ-зону №2 (Arizona Interior №2)!', -1)
	else
		sampSendChat(string.format("/az %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы телепортировали игрока %d в админ-зону №2 (Arizona Interior №2)', id),-1)
	end
end)

sampRegisterChatCommand("bot", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 Бот.", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} Вы успешно забанили игрока под ID: %d c причиной: Бот.', id),-1)
	end
end)

sampRegisterChatCommand("lvpd", function(arg)
   local id = string.match(arg, "(.+)")
	if id == nil then
		sampSendChat(string.format("/gotoint 18"))
		sampAddChatMessage('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы были телепортированы в интерьер №18 (Las Venturas Police Department)!', -1)
	else
		sampSendChat('/gotoint 18')
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы телепортировали игрока %d в интерьер №18 (Las Venturas Police Department)', id),-1)
	end
end)

sampRegisterChatCommand("cmd1", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} Введите ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} Вы успешно заспавнили и вернули игрока.', id),-1)
	end
end)

sampRegisterChatCommand("test", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ТЕСТ!', -1)
	else
		sampSendChat(string.format("ТЕСТ %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov Тилипёрт]{ffffff} ВТЕСТ.', id),-1)
	end
end)
