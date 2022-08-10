script_name('ROZOVHELPER') -- �������� �������
script_author('HAYDEN') -- ����� �������
script_description('ADMIN TUCSON') -- �������� �������
script_name("ADMIN HELPER")
script_version("25.06.2022")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/scripts/main/ahelper" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/LucasRozov/scripts/tree/main"
        end
    end
end

require "lib.moonloader" -- ����������� ����������
local keys = require "vkeys"

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"
local prefix = Roza
local se = require 'samp.events'

function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������ ������� ��������.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ��������� ��� �������� 5.08.2022.', -1)
 sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������: 2.0.', -1)

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

	if 	text:find('� ����� �������� �� ������ ���������� ������ ���������� ������� ����� � ���������', 1, true) or 
		text:find('�� �� �������� ����� {FFFFFF}������, ���, ���������{6495ED} ��� �� ������� �����-������ ����������.', 1, true) or 
		text:find('������ �� �������� {FFFFFF}VIP{6495ED} ����� ������� �����������, ��������� /help [������������ VIP]', 1, true) or
		text:find('����� ���������� ������ {FFFFFF}����������, ����������, ��������� ����', 1, true) or
		text:find('��������, ������� ������� ���� �� �����! ��� ����: {FFFFFF}arizona-rp.com', 1, true) then
		return false
	end

	if
		text:find('�� ���� ��������������� � �������� �18 (Las Venturas Police Department)', 1, true) then
		return false
	end

	-- �� ��������������� ������ %d � �����-���� �2 (Arizona Interior �2)

	if
		text:find(' �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)', 1, true) then
		return false
	end
end

sampRegisterChatCommand("cheat", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ���", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ �� 30 ���� � ��������: ���'),-1)
	end
end)

sampRegisterChatCommand("zz", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/warn %d DeathMatch � ��", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������� ������ � ��������: DeathMatch � ��'),-1)
	end
end)

sampRegisterChatCommand("sbiv", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 ���� ��������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d c ��������: DeathMatch � ��', id),-1)
	end
end)

sampRegisterChatCommand("ght", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������������� ������ ��� ID: %d � ����', id),-1)
	end
end)

sampRegisterChatCommand("ghc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/getherecar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ��������������� ������ ��� ID: %d � ����', id),-1)
	end
end)

sampRegisterChatCommand("spl", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ���������� ������ ��� ID: %d', id),-1)
	end
end)

sampRegisterChatCommand("spc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/spcar %d", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ���������� ������ ��� ID: %d', id), -1)
	end
end)

sampRegisterChatCommand("caps", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 30 CapsLock", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d. �������: �apsLock', id), -1)
	end
end)

sampRegisterChatCommand("mg", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 MetaGaming", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d. �������: MetaGaming', id),-1)
	end
end)

sampRegisterChatCommand("desc", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/adeldesc %d 2 NonRP �������� ���������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������� �������� ������ ��� ID: %d. �������: NonRP �������� ���������', id),-1)
	end
end)

sampRegisterChatCommand("torg", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/mute %d 60 �������� � /j", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d. �������: �������� � /j', id),-1)
	end
end)

sampRegisterChatCommand("oskrod", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ����������� ������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d. �������: �������� � /j', id),-1)
	end
end)

sampRegisterChatCommand("afk", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/kick %d AFK w/o ESC", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������� ������ ��� ID: %d. �������: AFK w/o ESC', id),-1)
	end
end)

sampRegisterChatCommand("no_damage", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 20 �� � �� [��� �����]", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������� ������ ��� ID: %d. �������: AFK w/o ESC', id),-1)
	end
end)

sampRegisterChatCommand("deagle", function(arg)
    local radius, kolvo = string.match(arg, "(.+) (.+)")
	if radius == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ������ � ���������� ��������!', -1)
	else
		sampSendChat(string.format("/gunall %d 24 %d", radius, kolvo))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� ������ Desert Eagle [24] � ������� %d � ���������� %d ��������.', radius, kolvo),-1)
	end
end)

sampRegisterChatCommand("upom", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 5 ���������� ������", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ �� 5 ���� � ��������: ���������� ������'),-1)
	end
end)

sampRegisterChatCommand("db", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/jail %d 120 DB", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d c ��������: DB', id),-1)
	end
end)

-- �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)

sampRegisterChatCommand("az", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampSendChat(string.format("/az"))
		sampAddChatMessage('{7FFF00}[Rozov �������]{ffffff} �� ���� ��������������� � �����-���� �2 (Arizona Interior �2)!', -1)
	else
		sampSendChat(string.format("/az %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ��������������� ������ %d � �����-���� �2 (Arizona Interior �2)', id),-1)
	end
end)

sampRegisterChatCommand("bot", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/ban %d 30 ���.", id))
		sampAddChatMessage(string.format('{7FFF00}[RozovHelper]{ffffff} �� ������� �������� ������ ��� ID: %d c ��������: ���.', id),-1)
	end
end)

sampRegisterChatCommand("lvpd", function(arg)
   local id = string.match(arg, "(.+)")
	if id == nil then
		sampSendChat(string.format("/gotoint 18"))
		sampAddChatMessage('{7FFF00}[Rozov �������]{ffffff} �� ���� ��������������� � �������� �18 (Las Venturas Police Department)!', -1)
	else
		sampSendChat('/gotoint 18')
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ��������������� ������ %d � �������� �18 (Las Venturas Police Department)', id),-1)
	end
end)

sampRegisterChatCommand("cmd1", function(arg)
    local id = string.match(arg, "(.+)")
	if id == nil then
		sampAddChatMessage('{7FFF00}[RozovHelper]{ffffff} ������� ID!', -1)
	else
		sampSendChat(string.format("/spplayer %d", id))
		sampSendChat(string.format("/gethere %d", id))
		sampAddChatMessage(string.format('{7FFF00}[Rozov �������]{ffffff} �� ������� ���������� � ������� ������.', id),-1)
	end
end)