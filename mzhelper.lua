script_name('RozovHelper MZ') -- �������� �������
script_author('Hayden_DeCollantes') -- ����� �������
script_description('Script for LSMC 02 <3') -- �������� �������
script_version("1.0")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/scripts/main/version.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/qrlk/moonloader-script-updater/"
        end
    end
end

require "lib.moonloader" -- ����������� ����������
local keys = require "vkeys"

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local prefix = Roza

function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} ������ ������� ��������.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} ��������� ��� �������� 31.07.2022.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper MZ]{ffffff} ������: 1.0 (BETA).', -1)

 




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
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} ������! ������� ID ������, �������� ������ ���������� � �����������!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me ������ �� ������� �������")
            wait(2000)
            sampSendChat("/me ����� � ���� ������ ����")
            wait(2000)
            sampSendChat("/me ����� � ������ �����������")
            wait(2000)
            sampSendChat("/me ����� ������ ����������")
            wait(2000)
            sampSendChat("/me ���� ������ � ����� ����������")
            wait(2000)
            sampSendChat(string.format("/r � ���� ������ �������� �� ��� �������� ��������� �%d.", id))
            wait(2000)
            sampSendChat("/me ����� ������� � ������")
            wait(2000)
            sampSendChat("/me ����� ���� � ������, ������ ���� �� ��������")
            wait(2000)
            sampSendChat(string.format("/todo ���, �������, ������� �%d, ������� ������*������� ����", id))
            wait(2000)
            sampSendChat(string.format("/invite %d",id))
            wait(2000)
            end)
        end
end

function cmd_giverank(param)
    local id, rank = string.match(param, "(%d+) (%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} ������! ������� ID ������, �������� ������ ��������!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me ������ �� ������� �������")
            wait(2000)
            sampSendChat("/me ����� � ���� ������ ����")
            wait(2000)
            sampSendChat("/me ����� � ������ �����������")
            wait(2000)
            sampSendChat("/me ����� ������ ����������")
            wait(2000)
            sampSendChat("/me ���� ����� ������ � ����� ����������")
            wait(2000)
            sampSendChat("/me ����� ������� � ������")
            wait(2000)
            sampSendChat("/me ����� ���� � ������, ������ ���� �� ��������")
            wait(2000)
            sampSendChat(string.format("/todo ���, �������, ������� �%d, ��� ����� ���� ����� �����*������� ����", id))
            wait(2000)
            sampSendChat(string.format("/giverank %d %d", id, rank))
            wait(2000)
            end)
        end
end

function cmd_fwarn(param)
    local id, reason = string.match(param, "(%d+) (.+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} ������! ������� ID ������, �������� ������ ������ �������!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me ������ �� ������� �������")
            wait(2000)
            sampSendChat("/me ����� � ���� ������ ����")
            wait(2000)
            sampSendChat("/me ����� � ������ �����������")
            wait(2000)
            sampSendChat("/me ����� ������ ����������")
            wait(2000)
            sampSendChat("/me ���� ��������� � ������ ����������")
            wait(2000)
            sampSendChat("/me ����� ������� � ������")
            wait(2000)
            sampSendChat(string.format("/r ���������� � ��������� �%d ��� ����� �������! �������: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/giverank %d %s", id, reason))
            wait(2000)
            end)
        end
end


function cmd_heal(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} ������! ������� ID ������, �������� ������ ��������!", -1)
        else
            lua_thread.create(function()
            sampSendChat("������������. � ��������� ������� ������������ ������, ��� ��� ���������?")
            wait(1000)
            sampSendChat("/me ������ ������ ����� � ������, ������� ������ ������� � �����")
            end)
        end
end


function cmd_heal1(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{7FFF00}[RozovHelper MZ]{ffffff} ������! ������� ID ������, �������� ������ ��������!", -1)
        else
            lua_thread.create(function()
                sampSendChat("/todo ���-���, ������, �� ����������*������� ��� ��������� ��������� ��������")
                wait(2000)
                sampSendChat("/me ��������� ������ ���� ������ ���.����")
                wait(2000)
                sampSendChat("/me ����������� ���������� ��� ����� ������ ��������� � ���.��������")
                wait(2000)
                sampSendChat("/do ��������� � ������ ����.")
                wait(2000)
                sampSendChat("/me ���������� ��������� ���� ������� ��������� ��������")
                wait(2000)
                sampSendChat("���������� ��� ��������,� ����� ��������� ����� ��� ������ �����")
                wait(2000)
                sampSendChat(string.format("/heal %d", id))
                wait(2000)
            end)
        end
end

function cmd_cmds()
	local text =	' \t \n' ..
	'{FFFFFF}1. {7FFF00}/invite - {FFFFFF}������� ������ � ����������� � ����������\n' ..
	'{FFFFFF}2. {7FFF00}/giverank - {FFFFFF}�������� ���������� � ����������\n' ..
	'{FFFFFF}3. {7FFF00}/fwarn - {FFFFFF}������ ������� � ����������\n' ..
	'{FFFFFF}4. {7FFF00}/heal - {FFFFFF}������ ������ ������ (�� ������ ��� ���������)\n' ..
	'{FFFFFF}5. {7FFF00}/heal1 - {FFFFFF}���������� ������ ������!\n' ..
    '{FFFFFF}6. {7FFF00}/medcard - {FFFFFF}� ����������!' 
	sampShowDialog(1488, '������� �������', text, 'OK')
end