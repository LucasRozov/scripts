script_name('RozovHelper MZ') -- название скрипта
script_author('Hayden_DeCollantes') -- автор скрипта
script_description('Script for LSMC 02 <3') -- описание скрипта
script_version("1.1")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/scripts/main/version.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/LucasRozov/scripts/blob/main/mzhelper.lua"
        end
    end
end

require "lib.moonloader" -- подключение библиотеки
local keys = require "vkeys"

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local prefix = Roza

function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} Скрипт успешно загружен.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} Регламент был обновлен 31.07.2022.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} Версия: 1.1 (BETA).', -1)

 




 sampRegisterChatCommand("invite", cmd_inv)
 sampRegisterChatCommand('giverank', cmd_giverank)
 sampRegisterChatCommand('fwarn', cmd_fwarn)
 sampRegisterChatCommand("heal", cmd_heal)
 sampRegisterChatCommand('heal1', cmd_heal1)
 sampRegisterChatCommand('commands', cmd_cmds)



 while true do
  wait(0)


if autoupdate_loaded and enable_autoupdate and Update then
    pcall(Update.check, Update.json_url, Update.prefix, Update.url)
end
  
 end
end

function cmd_inv(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} Ошибка! Введите ID игрока, которого хотите пригласить в организацию!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данный ЛСМЦ")
            wait(2000)
            sampSendChat("/me зашел в раздел «Сотрудники»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Добавить»")
            wait(2000)
            sampSendChat("/me ввел данные о новом сотруднике")
            wait(2000)
            sampSendChat(string.format("/r В базу данных Больницы ЛС был добавлен гражданин №%d.", id))
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat("/me сунув руку в карман, достал ключ от шкафчика")
            wait(2000)
            sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, удачной работы*передав ключ", id))
            wait(2000)
            sampSendChat(string.format("/invite %d",id))
            wait(2000)
            end)
        end
end

function cmd_giverank(param)
    local id, rank = string.match(param, "(%d+) (%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} Ошибка! Введите ID игрока, которого хотите повысить!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данный ЛСМЦ")
            wait(2000)
            sampSendChat("/me зашел в раздел «Сотрудники»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me ввел новые данные о новом сотруднике")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat("/me сунув руку в карман, достал ключ от шкафчика")
            wait(2000)
            sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, там лежит ваша новая форма*передав ключ", id))
            wait(2000)
            sampSendChat(string.format("/giverank %d %d", id, rank))
            wait(2000)
            end)
        end
end

function cmd_fwarn(param)
    local id, reason = string.match(param, "(%d+) (.+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} Ошибка! Введите ID игрока, которому хотите выдать выговор!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данный ЛСМЦ")
            wait(2000)
            sampSendChat("/me зашел в раздел «Сотрудники»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me внес изменения в строке «Выговоры»")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Сотруднику с бейджиком №%d был выдан выговор! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/giverank %d %s", id, reason))
            wait(2000)
            end)
        end
end


function cmd_heal(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} Ошибка! Введите ID игрока, которого хотите вылечить!", -1)
        else
            lua_thread.create(function()
            sampSendChat("Здравствуйте. Я сотрудник данного медицинского центра, что вас беспокоит?")
            wait(1000)
            sampSendChat("/me нырнув правой рукой в карман, вытянул оттуда блокнот и ручку")
            end)
        end
end


function cmd_heal1(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} Ошибка! Введите ID игрока, которого хотите вылечить!", -1)
        else
            lua_thread.create(function()
                sampSendChat("/todo Так-так, хорошо, не волнуйтесь*записав все сказанное человеком напротив")
                wait(2000)
                sampSendChat("/me движением правой руки открыл мед.кейс")
                wait(2000)
                sampSendChat("/me несколькими движениями рук нашел нужное лекарство в мед.чемодане")
                wait(2000)
                sampSendChat("/do Лекарство в правой руке.")
                wait(2000)
                sampSendChat("/me аккуратным движением руки передал лекарство пациенту")
                wait(2000)
                sampSendChat("Принимайте эти таблетки,и через некоторое время вам станет лучше")
                wait(2000)
                sampSendChat(string.format("/heal %d", id))
                wait(2000)
            end)
        end
end

function cmd_cmds()
	local text =	' \t \n' ..
	'{FFFFFF}1. {7FFF00}/invite - {FFFFFF}Принять игрока в организацию с отыгровкой\n' ..
	'{FFFFFF}2. {7FFF00}/giverank - {FFFFFF}Повысить сотрудника с отыгровкой\n' ..
	'{FFFFFF}3. {7FFF00}/fwarn - {FFFFFF}Выдать выговор с отыгровкой\n' ..
	'{FFFFFF}4. {7FFF00}/heal - {FFFFFF}Начать лечить игрока (до ответа что беспокоит)\n' ..
	'{FFFFFF}5. {7FFF00}/heal1 - {FFFFFF}Продолжить лечить игрока!\n' ..
    '{FFFFFF}6. {7FFF00}/medcard - {FFFFFF}В разработке228!' 
	sampShowDialog(1488, 'Команды скрипта', text, 'OK')
end
