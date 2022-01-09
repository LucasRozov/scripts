script_version('2.0')
script_author("Tinkoff Bank")

local nalogovaya = 0
local delay_vipresend = 1 -- �������
local version = script.this.version

local checking = false
local tVips = {}

local font = renderCreateFont('Arial', 10, 1)
local font2 = renderCreateFont('Verdana', 10, 1)
local gkey = require 'game.keys'
local lib = require 'lib.moonloader'
local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
local hook = require 'lib.samp.events'
encoding.default = 'CP1251'
u8 = encoding.UTF8



local mainIni = inicfg.load({
config =
{
darktheme = true,
invf = false,
lic = false,
dmg = false,
timer = false,
trade = false,
spawncara = false,
tlf = false,
arm = false,
msk = false,
smk = false,
cctime = false,
lock = false,
jlock = false,
fcar = false,
recar = false,
scar = false,
lafk = false,
cskill = false,
cheeps = false,
key = false,
vr = false,
aut = false,
abc = false,
acd = false,
mbc = false,
at = false,
act = false,
zz = false,
famnames = false,
pizza = false,
vip = false,
drugs = false,
flood = false,
olock = false,
doppiar = false,
nalogi = false,
asc = false,
nalog = false,
binder = false,
aafk = false,
aafksilent = false,
aeda = false,
ashar = false,
shar = false,
piarcheck = false,
cure = false,
vipcheck = false,
catchmenu = false,
binderset1 = true,
binderset2 = false,
binderset3 = false,
bindersetkey = false,
infotextb = false,
infotextp = false,
infotexttoch = false,
infotextpdelay = false,
autoad = false,
vip_resend = false,
fastrep = false,
sctime_toggle = false,
chatsms = "",
rtsms = "",
famsms = "",
smsbc = "",
smsvip = "",
smsvippr = "",
chasi = "",
bindt1 = "",
bindt2 = "",
bindt3 = "",
bindt4 = "",
bindt5 = "",
bindt6 = "",
bindt7 = "",
bindt8 = "",
bindt9 = "",
bindt10 = "",
bindt11 = "",
bindt12 = "",
bindt13 = "",
bindt14 = "",
bindt15 = "",
bindt16 = "",
bindt17 = "",
bindt18 = "",
bindt19 = "",
bindt20 = "",
bindt21 = "",
bindt22 = "",
bindt23 = "",
bindt24 = "",
bindt25 = "",
bindt26 = "",
bindt27 = "",
bindt28 = "",
bindt29 = "",
bindt30 = "",
slider = 15,
tkey = "xx",
maskkey = "-",
armkey = "=",
keyAdminMenu = "",
sharkey = "bb",
checked_radio = "1",
bindtab = "1",
toch = "unactive",
textposX = "40",
textposY = "450",
textposX_vr = "60",
textposY_vr = "470",
autoad_id_type = "1",
btccurs = "0",
ltccurs = "0",
ethcurs = "0",
eurocurs = "0",
scX = "100",
scY = "400",
currenttime_shift = "0",
newfont_fontini = "1",
newfont_fontsizeini = "15",
newfont_fonttypeini = "5",
newfont_colorini = "1"
}
}, "Player ToolsE")

local bf = imgui.ImBuffer
local darktheme = imgui.ImBool(mainIni.config.darktheme)
local lic = imgui.ImBool(mainIni.config.lic)
local trade = imgui.ImBool(mainIni.config.trade)
local tlf = imgui.ImBool(mainIni.config.tlf)
local arm = imgui.ImBool(mainIni.config.arm)
local msk = imgui.ImBool(mainIni.config.msk)
local nalog = imgui.ImBool(mainIni.config.nalog)
local asc = imgui.ImBool(mainIni.config.asc)
local smk = imgui.ImBool(mainIni.config.smk)
local cctime = imgui.ImBool(mainIni.config.cctime)
local lock = imgui.ImBool(mainIni.config.lock)
local dmg = imgui.ImBool(mainIni.config.dmg)
local nalogi = imgui.ImBool(mainIni.config.nalogi)
local slider = imgui.ImInt(mainIni.config.slider)
local jlock = imgui.ImBool(mainIni.config.jlock)
local fcar = imgui.ImBool(mainIni.config.fcar)
local recar = imgui.ImBool(mainIni.config.recar)
local scar = imgui.ImBool(mainIni.config.scar)
local lafk = imgui.ImBool(mainIni.config.lafk)
local cskill = imgui.ImBool(mainIni.config.cskill)
local cheeps = imgui.ImBool(mainIni.config.cheeps)
local key = imgui.ImBool(mainIni.config.key)
local vr = imgui.ImBool(mainIni.config.vr)
local doppiar = imgui.ImBool(mainIni.config.doppiar)
local aut = imgui.ImBool(mainIni.config.aut)
local abc = imgui.ImBool(mainIni.config.abc)
local timer = imgui.ImBool(mainIni.config.timer)
local zz = imgui.ImBool(mainIni.config.zz)
local famnames = imgui.ImBool(mainIni.config.famnames)
local olock = imgui.ImBool(mainIni.config.olock)
local acd = imgui.ImBool(mainIni.config.acd)
local pizza = imgui.ImBool(mainIni.config.pizza)
local at = imgui.ImBool(mainIni.config.at)
local flood = imgui.ImBool(mainIni.config.flood)
local vip = imgui.ImBool(mainIni.config.vip)
local drugs = imgui.ImBool(mainIni.config.drugs)
local fastrep = imgui.ImBool(mainIni.config.fastrep)
local spawncara = imgui.ImBool(mainIni.config.spawncara)
local sctime_toggle = imgui.ImBool(mainIni.config.sctime_toggle)
local smsbc = imgui.ImBuffer(''..mainIni.config.smsbc, 500) 
local chatsms = imgui.ImBuffer(''..mainIni.config.chatsms, 500) 
local rtsms = imgui.ImBuffer(''..mainIni.config.rtsms, 500) 
local famsms = imgui.ImBuffer(''..mainIni.config.famsms, 500)
local smsvip = imgui.ImBuffer(''..mainIni.config.smsvip, 500)
local smsvippr = imgui.ImBuffer(''..mainIni.config.smsvippr, 500)
local chasi = imgui.ImBuffer(''..mainIni.config.chasi, 500)
local mbc = imgui.ImBool(mainIni.config.mbc)
local binder = imgui.ImBool(mainIni.config.binder)
local binderset1 = imgui.ImBool(mainIni.config.binderset1)
local binderset2 = imgui.ImBool(mainIni.config.binderset2)
local binderset3 = imgui.ImBool(mainIni.config.binderset3)
local bindersetkey = imgui.ImBool(mainIni.config.bindersetkey)
local bindt1 = imgui.ImBuffer(''..mainIni.config.bindt1, 500)
local bindt2 = imgui.ImBuffer(''..mainIni.config.bindt2, 500)
local bindt3 = imgui.ImBuffer(''..mainIni.config.bindt3, 500)
local bindt4 = imgui.ImBuffer(''..mainIni.config.bindt4, 500)
local bindt5 = imgui.ImBuffer(''..mainIni.config.bindt5, 500)
local bindt6 = imgui.ImBuffer(''..mainIni.config.bindt6, 500)
local bindt7 = imgui.ImBuffer(''..mainIni.config.bindt7, 500)
local bindt8 = imgui.ImBuffer(''..mainIni.config.bindt8, 500)
local bindt9 = imgui.ImBuffer(''..mainIni.config.bindt9, 500)
local bindt10 = imgui.ImBuffer(''..mainIni.config.bindt10, 500)
local bindt11 = imgui.ImBuffer(''..mainIni.config.bindt11, 500)
local bindt12 = imgui.ImBuffer(''..mainIni.config.bindt12, 500)
local bindt13 = imgui.ImBuffer(''..mainIni.config.bindt13, 500)
local bindt14 = imgui.ImBuffer(''..mainIni.config.bindt14, 500)
local bindt15 = imgui.ImBuffer(''..mainIni.config.bindt15, 500)
local bindt16 = imgui.ImBuffer(''..mainIni.config.bindt16, 500)
local bindt17 = imgui.ImBuffer(''..mainIni.config.bindt17, 500)
local bindt18 = imgui.ImBuffer(''..mainIni.config.bindt18, 500)
local bindt19 = imgui.ImBuffer(''..mainIni.config.bindt19, 500)
local bindt20 = imgui.ImBuffer(''..mainIni.config.bindt20, 500)
local bindt21 = imgui.ImBuffer(''..mainIni.config.bindt21, 500)
local bindt22 = imgui.ImBuffer(''..mainIni.config.bindt22, 500)
local bindt23 = imgui.ImBuffer(''..mainIni.config.bindt23, 500)
local bindt24 = imgui.ImBuffer(''..mainIni.config.bindt24, 500)
local bindt25 = imgui.ImBuffer(''..mainIni.config.bindt25, 500)
local bindt26 = imgui.ImBuffer(''..mainIni.config.bindt26, 500)
local bindt27 = imgui.ImBuffer(''..mainIni.config.bindt27, 500)
local bindt28 = imgui.ImBuffer(''..mainIni.config.bindt28, 500)
local bindt29 = imgui.ImBuffer(''..mainIni.config.bindt29, 500)
local bindt30 = imgui.ImBuffer(''..mainIni.config.bindt30, 500)
local aeda = imgui.ImBool(mainIni.config.aeda)
local invf = imgui.ImBool(mainIni.config.invf)
local tkey = imgui.ImBuffer(''..mainIni.config.tkey, 4)
local armkey = imgui.ImBuffer(''..mainIni.config.armkey, 10)
local maskkey = imgui.ImBuffer(''..mainIni.config.maskkey, 10)
local toch = imgui.ImBuffer(''..mainIni.config.toch, 20)
local ashar = imgui.ImBool(mainIni.config.ashar)
local shar = imgui.ImBool(mainIni.config.shar)
local sharkey = imgui.ImBuffer(''..mainIni.config.sharkey, 10)
local piarcheck = imgui.ImBool(mainIni.config.piarcheck)
local cure = imgui.ImBool(mainIni.config.cure)
local vipcheck = imgui.ImBool(mainIni.config.vipcheck)
local catchmenu = imgui.ImBool(mainIni.config.catchmenu)
local setmodelID = 16112
local checked_radio = imgui.ImInt(mainIni.config.checked_radio)
local bindtab = imgui.ImInt(mainIni.config.bindtab)
local posX = mainIni.config.textposX
local posY = mainIni.config.textposY
local posX_vr = mainIni.config.textposX_vr
local posY_vr = mainIni.config.textposY_vr
local scX = mainIni.config.scX
local scY = mainIni.config.scY
local currenttime_shift = mainIni.config.currenttime_shift
local infotextb = imgui.ImBool(mainIni.config.infotextb)
local infotextp = imgui.ImBool(mainIni.config.infotextp)
local infotexttoch = imgui.ImBool(mainIni.config.infotexttoch)
local infotextpdelay = imgui.ImBool(mainIni.config.infotextpdelay)
local autoad = imgui.ImBool(mainIni.config.autoad)
local autoad_id_type = imgui.ImBuffer(''..mainIni.config.autoad_id_type, 2)
local vip_resend = imgui.ImBool(mainIni.config.vip_resend)
local newfont_font = imgui.ImInt(mainIni.config.newfont_fontini)
local newfont_fontsize = imgui.ImInt(mainIni.config.newfont_fontsizeini)
local newfont_fonttype = imgui.ImInt(mainIni.config.newfont_fonttypeini)
local newfont_color = imgui.ImInt(mainIni.config.newfont_colorini)


local checked_box = false
local checktochilki = false
local checkpos = false
local checkpos_vr = false
local checkpos_vr_default = false
local pos_tochX, pos_tochY = 0, 0
local tab = "one"
local tab2 = "one"
local piarbutton = "unactive"
local wait_ = 0.5
local actinfo = '0xFF777777'
local blocker = imgui.WindowFlags.NoBringToFrontOnFocus
local autinfo = imgui.ImBool(false)
local blockbutton_timer = 0
local blockbutton_info = 0
local atoch_status = u8"�������� �����������..."
--local selected = imgui.ImInt(0)

local KeyB = {"NumPad0",
	"NumPad1",
	"NumPad2",
	"NumPad3",
	"NumPad4",
	"NumPad5",
	"NumPad6",
	"NumPad7",
	"NumPad8",
	"NumPad9",
}
 
local KeyBinder = {VK_NUMPAD0,
	VK_NUMPAD1,
	VK_NUMPAD2,
	VK_NUMPAD3,
	VK_NUMPAD4,
	VK_NUMPAD5,
	VK_NUMPAD6,
	VK_NUMPAD7,
	VK_NUMPAD8,
	VK_NUMPAD9,
}

local bindt = {bindt1,
		bindt2,
		bindt3,
		bindt4,
		bindt5,
		bindt6,
		bindt7,
		bindt8,
		bindt9,
		bindt10,
		bindt11,
		bindt12,
		bindt13,
		bindt14,
		bindt15,
		bindt16,
		bindt17,
		bindt18,
		bindt19,
		bindt20,
		bindt21,
		bindt22,
		bindt23,
		bindt24,
		bindt25,
		bindt26,
		bindt27,
		bindt28,
		bindt29,
		bindt30,
}

local FontTable = {'Verdana',
	'Arial',
	'Impact',
	'System',
	'Comic Sans MS',
}

local FColorTable = {0xFFFFFFFF,
	0x50FFFFFF,
	0xFF000000,
	0x50000000,
	0xFF990000,
	0x50990000,
    0xFF0090FF,	
    0x500090FF,	
    0xFF009900,	
    0x50009900,	
}

local newfont = renderCreateFont(FontTable[newfont_font.v], newfont_fontsize.v, newfont_fonttype.v)
function newfont_update()
    newfont = renderCreateFont(FontTable[newfont_font.v], newfont_fontsize.v, newfont_fonttype.v)
end

local status = inicfg.load(mainIni, 'Player ToolsE.ini')
if not doesFileExist('moonloader/config/Player ToolsE.ini') then inicfg.save(mainIni, 'Player ToolsE.ini') end

local alert_window_state = imgui.ImBool(false)
local black_window_state = imgui.ImBool(false)
local main_window_state = imgui.ImBool(false)
local interface_tochnew_window = imgui.ImBool(false)
function imgui.OnDrawFrame()
interface_tochnew()
imgui.ShowCursor = main_window_state.v
  if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(1080, 540), imgui.Cond.FirstUseEver)
		if not window_pos then
			ScreenX, ScreenY = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		end
	  imgui.Begin('Player Tools 2.0 | by Tinkoff Bank', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + blocker)		  	
		imgui.BeginChild("##�������", imgui.ImVec2(1050, 35), true, imgui.WindowFlags.NoScrollbar)
			imgui.SetCursorPos(imgui.ImVec2(109, 10))
				imgui.Text(u8"����������� �������: /findihouse - /fh, /findibiz - /fbiz, /house - /h, /fammenu - /fmn |")
				imgui.TextWithQuestionColored(u8'�������: \n/calc 2*2 - ���������\n/calc 2/2 - �������\n/calc 2-2 - ���������\n/calc 2+2 - �������� ', imgui.ImVec4(0.0, 0.5, 1.0, 1.0), u8'�����������: /calc *������*', imgui.SameLine())
			imgui.SetCursorPos(imgui.ImVec2(880, 10))
			    imgui.TextColored(imgui.ImVec4(0.43, 0.43, 0.50, 0.50), u8'������:')
				imgui.SameLine()
			imgui.SetCursorPos(imgui.ImVec2(825, 5))	
				if darktheme.v then					
					if imgui.Button(u8"����.## DTActive", imgui.ImVec2(50, 25)) then 
						darktheme.v = false
						apply_custom_style()						
					end				
				elseif not darktheme.v then								  
					if imgui.Button(u8"�����.## DTunActive", imgui.ImVec2(50, 25)) then 
						darktheme.v = true
						apply_custom_style()
					end	
				end
			imgui.SetCursorPos(imgui.ImVec2(932, 5))
				if imgui.Button(u8""..version.."", imgui.ImVec2(110, 25)) then
				update()
				end			
			imgui.SetCursorPos(imgui.ImVec2(7, 5))
			    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.85, 1.00, 0.41, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.85, 1.00, 0.41, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.85, 1.00, 0.41, 1.00))
				imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.00, 0.00, 0.00, 1.00))
				if imgui.Button(u8"TINKOFF", imgui.ImVec2(90, 25)) then
				   sampAddChatMessage("�������������� �� 02 ������ ������� ������ ��� ������������� - {FFD700}Tinkoff_Bank. �� 6 ��� ����� #samp EZ {00ff00}MONEY", -1)
				end
				imgui.PopStyleColor()
				imgui.PopStyleColor()
				imgui.PopStyleColor()
				imgui.PopStyleColor()
		imgui.EndChild()
		imgui.BeginChild("##�����_����", imgui.ImVec2(300, 120), true, imgui.WindowFlags.NoScrollbar)
				imgui.Checkbox(u8"����� ������ ���������� ������", lic)
				imgui.SameLine()
				imgui.TextQuestion(u8'��� ������� ������ ALT + 1 �� �������� �������� ���������� ������')
				imgui.Checkbox(u8"�������� ���������� ������", trade)
				imgui.SameLine()
				imgui.TextQuestion(u8'��� ������� ������ ALT + 2 �� ���������� �������� ���������� ������')
				imgui.Checkbox(u8"�������", tlf)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �� ������� P � ��� ��������� ������� �� ������ ������,\n���� � ��� ����� 2-� ��������� � ���������." )
				imgui.SameLine()
				imgui.Checkbox(u8"�������� ������", flood)
				imgui.SameLine()
				imgui.TextQuestion(u8"������ ������� ������ �� ���� ����� ��������� ���: ���������� �����, �� ������ sf ������ ������� � �.�" )
	  	imgui.EndChild()
	  	imgui.BeginChild("##�����_���", imgui.ImVec2(300, 248), true, imgui.WindowFlags.AlwaysVerticalScrollbar)
				imgui.CheckboxPlus(u8"����������", arm)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ��������� ���� ������ � ��� �������� ����������")	
				if arm.v then
				imgui.SameLine()
				CursorPos = imgui.GetCursorPos()
				imgui.SetCursorPos(imgui.ImVec2(175, CursorPos.y))
				 if imgui.CollapsingHeader(u8"���������##header_armour") then
				 imgui.PushItemWidth(100)
				 imgui.InputText(u8"��������� �����", armkey)
				 imgui.SameLine()
				 imgui.TextQuestion(u8"������� ���-���, ������� ����� ������������ ���������� (�� ��������� - ������ '=' (�����))")
				 imgui.Separator()
				 end
				end
				imgui.CheckboxPlus(u8"�����", msk)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ��������� ���� ������ � ��� �������� �����")
				if msk.v then
				imgui.SameLine()
				CursorPos = imgui.GetCursorPos()
				imgui.SetCursorPos(imgui.ImVec2(175, CursorPos.y))
				 if imgui.CollapsingHeader(u8"���������##header_mask") then
				 imgui.PushItemWidth(100)
				 imgui.InputText(u8"��������� �����", maskkey)
				 imgui.SameLine()
				 imgui.TextQuestion(u8"������� ���-���, ������� ����� ������������ ����� (�� ��������� - ������ '-' (�����))")
				 imgui.Separator()
				 end
				end
				imgui.CheckboxPlus(u8"��������", smk)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ SMK � ��� �������� ��������")
				imgui.CheckboxPlus(u8"���������", drugs)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ alt + 1/2/3 (������ = ���-��) �� ����������� ���������")
				imgui.CheckboxPlus(u8"������� �� ������� VIP", vip)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������ ����� �� ����� ����� ����� ��� ������� ��� - ������ �������� � ��� ��� ��� ���������")
				if vip.v then
				imgui.SameLine()
				CursorPos = imgui.GetCursorPos()
				imgui.SetCursorPos(imgui.ImVec2(175, CursorPos.y))
				 if imgui.CollapsingHeader(u8"���������##header_vipr") then
				 imgui.PushItemWidth(172)
				 imgui.InputText(u8"���� Titan", smsvip)
				 imgui.PushItemWidth(172)
				 imgui.InputText(u8"���� Premium", smsvippr)
				 imgui.Separator()
				 end
				end
				imgui.CheckboxPlus(u8"����", cctime)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� ��������� ���� ������ �� ���������� �� ���� � ����� ����������.")
				if cctime.v then
				imgui.SameLine()
				CursorPos = imgui.GetCursorPos()
				imgui.SetCursorPos(imgui.ImVec2(175, CursorPos.y))
				 if imgui.CollapsingHeader(u8"���������##header_time") then
				 imgui.PushItemWidth(100)
				 imgui.InputText(u8"��������� �����", tkey)
				 imgui.SameLine()
				 imgui.TextQuestion(u8"������� ���-���, ������� ����� ������������ ��������� (�� ��������� - 'XX' ����.)")
				 imgui.PushItemWidth(185)
				 imgui.InputText(u8"���������", chasi)
				 imgui.Separator()
				 end
				end
				imgui.CheckboxPlus(u8"�������� ����������", lock)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �� ������� L �� ��������/�������� ���� ���������")
				imgui.CheckboxPlus(u8"�������� ������", jlock)
                imgui.SameLine()
				imgui.TextQuestion(u8"��� ���������� ������ JL �� ��������/�������� ���� ����������� ���������")
				imgui.CheckboxPlus(u8"����� ����� ���� (��)", scar)
                imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� ������� ������� O �� ������� ����� ���� ������ ����������")
				imgui.CheckboxPlus(u8"��������� ����",shar)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� �/� ��������� ��� ��� �������� ��������� ���� ���-����.")
				imgui.CheckboxPlus(u8"�����", cheeps)
                imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� ������� �� CH �������� ������� ����� ������")
				if shar.v then
				imgui.SameLine()
				CursorPos = imgui.GetCursorPos()
				imgui.SetCursorPos(imgui.ImVec2(175, CursorPos.y))
				 if imgui.CollapsingHeader(u8"���������##header_shar") then
				 imgui.PushItemWidth(100)
				 imgui.InputText(u8"��������� ����", sharkey)
				 imgui.SameLine()
				 imgui.TextQuestion(u8"������� ���-���, ������� ����� ������� �/� ��������� ���\n(�� ��������� BB (����.))")
				 imgui.Separator()
				 end
				end
				if aut.v then
				 imgui.CheckboxPlus("", ashar)
				 imgui.TextColored(imgui.ImVec4(1.0, 0.5, 0.0, 1.0), u8'���������� ����', imgui.SameLine())
				 imgui.SameLine()
				 imgui.TextQuestion(u8"���������� �/� ��������� ��� (��� ����� ������ ������ ALT �� ����)")
				 imgui.CheckboxPlus("", cure)
				 imgui.TextColored(imgui.ImVec4(1.0, 0.5, 0.0, 1.0), u8'��������� (�����������)', imgui.SameLine())
				 imgui.SameLine()
				 imgui.TextQuestion(u8"��� ������� ������ ALT + 4 �� ��������� ���������� ������ � ������ ������\n(����� ��������� � ���������)")
				else
				 imgui.LockedParam(u8"����������� ������� �������\n          ��� �������������## ����_�����", imgui.ImVec2(266, 60))
				end			
		imgui.EndChild()
		if imgui.Button(u8'��������� ���������',imgui.ImVec2(145,58)) then 
           saverconfig()		   
		end
		imgui.SetCursorPos(imgui.ImVec2(325, 82))
		imgui.BeginChild("##��������_����_�����", imgui.ImVec2(178, 120), true, imgui.WindowFlags.NoScrollbar)
				imgui.Checkbox(u8"��������� ����", fcar)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ KK �� ��������� ��������� ��������� �������� (������ ��� ����)")
				imgui.Checkbox(u8"�������� ����", recar)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ RR �� �������� ��������� ��������� �����������")
				imgui.Checkbox(u8"����� �� ����", key)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �� ������ K �� ��������/�������� ����� (������ ������ ����)")
	  	imgui.EndChild()
        imgui.SetCursorPos(imgui.ImVec2(512, 82))
		imgui.BeginChild("##��������_����_������", imgui.ImVec2(178, 120), true, imgui.WindowFlags.NoScrollbar)
				if aut.v then
					imgui.Checkbox(u8"AntiAFK", lafk)
					imgui.SameLine()
					imgui.TextQuestion(u8"��� ������� ������� �� LA ������������ AntiAFK")
					imgui.Checkbox(u8"AntiCarSkill", cskill)
					imgui.SameLine()
					imgui.TextQuestion(u8"��� ������� ������� CK ��������� ���� � ���������� AntiCarSkill")
				else
				    imgui.LockedParam(u8"����������� �������\n           �������## ����_�����", imgui.ImVec2(158, 60))
				end
				imgui.Checkbox(u8"�������� ��� �/�", olock)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ OL �� ��������/�������� ��������������� ���������")
	  	imgui.EndChild()
		imgui.SetCursorPos(imgui.ImVec2(700, 277))
		imgui.BeginChild("##������_�������", imgui.ImVec2(365, 150), true, ImGuiWindowFlags_AlwaysVerticalScrollbar)
				imgui.Checkbox(u8"���������� ������� � ������ � ���������",dmg)
				imgui.SameLine()
				imgui.TextQuestion(u8"������ ������ ������ � ��������� ����� ����������� ������")
				imgui.Checkbox(u8"����� ���������� �� �������",spawncara)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �������� ���� ����� ��������� ���� � ������� �� ������ (����� ����� ����� �����)")
				imgui.Checkbox(u8"������� ������", fastrep)
				imgui.SameLine()
				imgui.TextQuestion(u8'������ ���������� ��� ������ ��� ������ �������\n������: "/rep �� ��������!!!"')
				imgui.Checkbox(u8"������� ����� � ���������",nalog)
		        imgui.SameLine()
		        imgui.TextQuestion(u8"������� ������� �� �������� ��� ����� ������� � ���������")
				imgui.Checkbox(u8"��������� ��� �������", nalogi)
				imgui.SameLine()
				imgui.TextQuestion(u8"������ ������� �������� ������ � ��������� ���� �� ������ ���������� � ���")
				--if imgui.Combo(u8'ComboBox Test', selected, KeyB, 4) then
                   -- sampAddChatMessage('�������: '..selected.v,-1)
				--end
                imgui.NewLine()
				if aut.v then
				 imgui.NewLine()
				 imgui.PushStyleColor(imgui.Col.Header, imgui.ImVec4(1.00, 0.50, 0.00, 1.00))	
				 if imgui.CollapsingHeader(u8"�������������:") then
				 imgui.Checkbox(u8"",aeda)
				 imgui.TextColored(imgui.ImVec4(1.0, 0.5, 0.0, 1.0), u8'������� (�������)', imgui.SameLine())
				 imgui.SameLine()
				 imgui.TextQuestion(u8"��� ��������� ������� You are very hungry ������������� ������ ���� �������.\n����������: ������� �� ���-��� ������� � ���������! (������ �������� 1��/3����)")
		         end
				 imgui.PopStyleColor()
				end
		imgui.EndChild()
        imgui.SetCursorPos(imgui.ImVec2(700, 436))
        imgui.BeginChild("##������_���", imgui.ImVec2(365, 50), true, imgui.WindowFlags.NoScrollbar)
				if imgui.ToggleButton(u8"", autinfo) then
				    if not aut.v then
					    alert_window_state.v = true
					    black_window_state.v = true
					    timertest(10)
                    elseif aut.v then
                        alert_window_state.v = false
					    black_window_state.v = false
					    aut.v = false
                    end					
				end
				imgui.TextColored(imgui.ImVec4(1.0, 0.5, 0.0, 1.0), u8'��������� ������� �������', imgui.SameLine(55))
				imgui.SameLine()
				imgui.TextQuestion(u8"�������� �������, ������� ����� ���� ��������� ��������� ������ �������.")
        imgui.EndChild()
		imgui.SetCursorPos(imgui.ImVec2(700, 495))
		    	if imgui.Button(u8"�������� ���", imgui.ImVec2(365,28)) then
		    		sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage(" ", -1)
					sampAddChatMessage("��� ��� ������ {00ff00}�������{ffffff}!", -1)
					
				end
		imgui.SetCursorPos(imgui.ImVec2(170, 466))
		    	if imgui.Button(u8"������������� ������", imgui.ImVec2(145,58)) then
		    		thisScript():reload()
				end
				
				--[����� ������� ����� �����������]
				newinterface()
	    	    centerinterface()
				--
	imgui.End()
	end
	if black_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(1080, 540), imgui.Cond.FirstUseEver)
		if not window_pos then
			ScreenX, ScreenY = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		end
		imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.60))
	  imgui.Begin('##block', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoInputs)  
	imgui.End()
	imgui.PopStyleColor()
	blocker = imgui.WindowFlags.NoInputs + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoSavedSettings
	else
	    blocker = imgui.WindowFlags.NoBringToFrontOnFocus
	end
    if alert_window_state.v then
	blockbutton_info = string.format("%.0f", blockbutton_timer - os.clock())
		imgui.SetNextWindowSize(imgui.ImVec2(400, 260), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'                                           ��������!', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
		imgui.BeginChild("##�����", imgui.ImVec2(370, 170), true, imgui.WindowFlags.NoScrollbar)
			imgui.CenterText(u8'������� ������ ������� �� ������')
			imgui.CenterText(u8'�������� ������� ��������� ������ �������,')
			imgui.CenterText(u8'��� ����� �������� � ����������!')
			imgui.NewLine()
			imgui.CenterText(u8'����� ���������� ������������ �')
			imgui.CenterText(u8'��������� ������ �������!')
        imgui.EndChild()
		imgui.NewLine()
		imgui.SameLine(43)
		if tonumber(blockbutton_info) > 0 then
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.60, 0.60, 0.60, 0.65))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.60, 0.60, 0.60, 0.65))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.60, 0.60, 0.60, 0.65))		    
			if imgui.Button(u8'����������� ('..blockbutton_info..')', imgui.ImVec2(150, 30)) then
			end
            imgui.PopStyleColor()
            imgui.PopStyleColor()			
            imgui.PopStyleColor()		    
		else
			if imgui.Button(u8'�����������', imgui.ImVec2(150, 30)) then
				black_window_state.v = false
				alert_window_state.v = false
				aut.v = true
			end
		end
        imgui.SameLine(205)
        if imgui.Button(u8'���������', imgui.ImVec2(150, 30)) then
			black_window_state.v = false
			alert_window_state.v = false
			aut.v = false
		end		
	imgui.End()
    end
end

function newinterface()
			imgui.SetCursorPos(imgui.ImVec2(700, 82))
			    imgui.BeginChild("##������_����_�������", imgui.ImVec2(365, 50), true, imgui.WindowFlags.NoScrollbar)
					if imgui.ButtonActivated(tab2=="one", u8"AutoAD## Tab2 1", imgui.ImVec2(103, 25)) then tab2 = "one" end imgui.SameLine()
            		if imgui.ButtonActivated(tab2=="two", u8"Family Helper## Tab2 2", imgui.ImVec2(104, 25)) then tab2 = "two" end imgui.SameLine()
					if imgui.ButtonActivated(tab2=="three", u8"�����������## Tab2 3", imgui.ImVec2(103, 25)) then tab2 = "three" end
				imgui.EndChild()
				imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.28, 0.56, 1.00, 1.00))
				imgui.SetCursorPos(imgui.ImVec2(700, 116))
			    imgui.BeginChild("##������_����_����", imgui.ImVec2(365, 151), true, ImGuiWindowFlags_AlwaysVerticalScrollbar)
				if tab2 == "one" then
			   		imgui.SetCursorPos(imgui.ImVec2(15, 15))
                        if imgui.ButtonActivated(autoad.v==false, u8"����## Autoad 1", imgui.ImVec2(57, 25)) then autoad.v = false end imgui.SameLine()
						imgui.SetCursorPos(imgui.ImVec2(62, 15))
					    if imgui.ButtonActivated(autoad.v==true, u8"���## Autoad 2", imgui.ImVec2(57, 25)) then autoad.v = true end imgui.SameLine()
						imgui.Text(u8'���� ����������')
						imgui.SameLine()
				        imgui.TextQuestion(u8"�������������� �������� ���������� ��� ������� � ������� ���������� �����������")
						imgui.SetCursorPos(imgui.ImVec2(15, 55))
						if autoad.v then
						    if imgui.CollapsingHeader(u8"��������� ���� ����������", true, imgui.TreeNodeFlags.DefaultOpen) then
							    imgui.SetCursorPos(imgui.ImVec2(175, 95))
								imgui.Text(u8'- ���')
						        imgui.SameLine()
								imgui.TextQuestion(u8"�������� ��� ����������")
								imgui.SameLine()
								imgui.SetCursorPos(imgui.ImVec2(15, 91))
				                if imgui.ButtonActivated(autoad_id_type.v=="1", u8"�������## Autoad_id_type 1", imgui.ImVec2(68, 25)) then autoad_id_type.v = "1" end imgui.SameLine()
								if imgui.ButtonActivated(autoad_id_type.v=="2", u8"VIP## Autoad_id_type 2", imgui.ImVec2(68, 25)) then autoad_id_type.v = "2" end
							end
						else
						
						end
				end
				if tab2 == "two" then
					if imgui.CollapsingHeader(u8"��������� ��� FAMILY Helper'a:", true, imgui.TreeNodeFlags.DefaultOpen) then
				 		imgui.Checkbox(u8"������ ���� �������� � ���������", famnames)
                 		imgui.SameLine()
				 		imgui.TextQuestion(u8"����� �������� ������ � ����� ��� ��� � ����� ������������ � FamInvites.txt � ����� moonloader")
	  	         		imgui.Checkbox(u8"������ ���������� ������", invf)
				 		imgui.SameLine()
				 		imgui.TextQuestion(u8'��� ������� ������ ALT + 3 �� ���������� �������� � ����� ���������� ������')
				 		imgui.Checkbox(u8"�������� VIP - �������", vipcheck)
				 		imgui.SameLine()
				 		imgui.TextQuestion(u8'��� �������� ������� "/vip (id)" �� ��������� ������� VIP � ������.')
					end
				end
				if tab2 == "three" then
					if binder.v then
					--[Binder Preset Info]
						imgui.Checkbox(u8"������ �������",infotextb)
						imgui.SameLine()
						imgui.TextQuestion(u8"��� ��������� �������� ����������� �������� ���������� ������� �������.")			         
						if infotextb.v then
						imgui.SameLine()				
							if imgui.Button(u8"�������� ���������", imgui.ImVec2(163, 25)) then
								checkpos = true
								main_window_state.v = false
							end
						end
					else
						imgui.LockedParam(u8"�������� ������ ��� ��������## ����1", imgui.ImVec2(345, 32))
					end
					
					--[VIP RESEND]
					imgui.SetCursorPos(imgui.ImVec2(15, 50))
					imgui.Checkbox(u8"Vip-Resend",vip_resend)
					imgui.SameLine()
					imgui.SetCursorPos(imgui.ImVec2(110, 50))
					imgui.TextColored(imgui.ImVec4(0.20, 0.25, 0.29, 1.00), u8'byCosmo')
					imgui.SameLine()
					imgui.SetCursorPos(imgui.ImVec2(161, 50))
					imgui.TextQuestion(u8"������ ������� ������� �������� ��������� � VIP-���\n��� �� ������� ������ ��� �������� ��������� ��� ��������� ��-�� �� � 3 �������,\n�������� ��������� � /vr ���� ��� � ��������� ����� � ������� �� ��������.")
					if vip_resend.v then
					imgui.SameLine()
					imgui.SetCursorPos(imgui.ImVec2(178, 50))
						if imgui.Button(u8"���������", imgui.ImVec2(80, 25)) then
							checkpos_vr = true
							main_window_state.v = false
						end
						imgui.SameLine(262)
						if imgui.Button(u8"�����", imgui.ImVec2(80, 25)) then
							checkpos_vr_default = true
						end
					end
				   
				   --[Toch Info]
					if toch.v == "active" and aut.v then
						imgui.Checkbox(u8"��������� �����������",infotexttoch)
						imgui.SameLine()
						imgui.TextQuestion(u8"�������� ��������� � ����������� �� ����������� ��� �������� ���� �������.")
					else
						imgui.LockedParam(u8"�������� ����������� ��� ��������## ����2", imgui.ImVec2(345, 32))
					end
					
					--[SC Time]
					imgui.Checkbox(u8"����� �� ������",sctime_toggle)
					imgui.SameLine()
					imgui.TextQuestion(u8"�������� ����������� ���������� ������� �� ������.\n��� ������������ ������� ��������� �� ������ 060 � ��������.")
					if sctime_toggle.v then
					imgui.SameLine()
					imgui.SetCursorPos(imgui.ImVec2(178, 115))
						if imgui.Button(u8"���������## SC", imgui.ImVec2(80, 25)) then
							sctime_position = true
							main_window_state.v = false
						end
                        if sc_settings == true then						
							imgui.SameLine(262)
							imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.68, 0.30, 0.22, 0.80))
							imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.68, 0.30, 0.22, 0.90))							
							if imgui.Button(u8"�������## SC", imgui.ImVec2(80, 25)) then
								sc_settings = false
							end
                            imgui.PopStyleColor()
                            imgui.PopStyleColor()							
							imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.68, 0.30, 0.22, 1.00))
							imgui.SetCursorPos(imgui.ImVec2(10, 10))
							imgui.BeginChild("##SCSettings", imgui.ImVec2(345, 105), true, ImGuiWindowFlags_AlwaysVerticalScrollbar)
								if imgui.Button(u8"<## SC1", imgui.ImVec2(25, 25)) then
								    if newfont_font.v > 1 then
								        newfont_font.v = newfont_font.v - 1
									end
									newfont_update()
								end
								imgui.SameLine()
                                imgui.Text(u8''..tostring(FontTable[newfont_font.v]))
                                imgui.SameLine(130)								
								if imgui.Button(u8">## SC11", imgui.ImVec2(25, 25)) then
								    if newfont_font.v < #FontTable then
								        newfont_font.v = newfont_font.v + 1
									end
									newfont_update()
								end
								imgui.SameLine(162)
								imgui.Text(u8'��� ������')	
								imgui.SameLine(250)
								if imgui.Button(u8"<## SC2", imgui.ImVec2(25, 25)) then
								    newfont_fonttype.v = newfont_fonttype.v - 1
									newfont_update()
								end
								imgui.SameLine()
                                imgui.Text(u8''..tostring(newfont_fonttype.v))	
                                imgui.SameLine()								
								if imgui.Button(u8">## SC22", imgui.ImVec2(25, 25)) then
								    newfont_fonttype.v = newfont_fonttype.v + 1
									newfont_update()
								end  								
								imgui.PushItemWidth(140)
                                if imgui.SliderInt(u8"������ ������", newfont_fontsize, 5, 80, "%.0f")	then
                                    newfont_update()
                                end	
								
								if imgui.Button(u8"<## SC3Col", imgui.ImVec2(25, 25)) then
								    if newfont_color.v > 1 then
									    newfont_color.v = newfont_color.v - 1
									end
									newfont_update()
								end
								imgui.SameLine()
                                imgui.Text(u8'���� �����')	
                                imgui.SameLine(130)								
								if imgui.Button(u8">## SC33Col", imgui.ImVec2(25, 25)) then
								    if newfont_color.v < #FColorTable then
									    newfont_color.v = newfont_color.v + 1
									end
									newfont_update()
								end  																
							imgui.EndChild()
                            imgui.PopStyleColor()																			
						else											
							imgui.SameLine(262)
							if imgui.Button(u8"���������## SC", imgui.ImVec2(80, 25)) then
								sc_settings = true
							end	
					    end
					end					
		
				end
			    imgui.EndChild()
				imgui.PopStyleColor()
end

function centerinterface()
		    imgui.SetCursorPos(imgui.ImVec2(325, 210))
				imgui.BeginChild("##��������_�����_�������", imgui.ImVec2(365, 50), true, imgui.WindowFlags.NoScrollbar)
					if imgui.ButtonActivated(tab=="one", u8"����## Tab 1", imgui.ImVec2(75, 25)) then tab = "one" end imgui.SameLine()
            		if imgui.ButtonActivated(tab=="two", u8"�����## Tab 2", imgui.ImVec2(75, 25)) then tab = "two" end imgui.SameLine()
					if imgui.ButtonActivated(tab=="three", u8"�������## Tab 3", imgui.ImVec2(75, 25)) then tab = "three" end imgui.SameLine()
					if imgui.ButtonActivated(tab=="four", u8"������## Tab 4", imgui.ImVec2(75, 25)) then tab = "four" end
				imgui.EndChild()
		        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.28, 0.56, 1.00, 1.00))
	        imgui.SetCursorPos(imgui.ImVec2(325, 244))
	  	        imgui.BeginChild("##��������_�����_����", imgui.ImVec2(365, 280), true, ImGuiWindowFlags_AlwaysVerticalScrollbar)
					if tab == "one" then			 
						if aut.v then
						    autinfo = imgui.ImBool(true)
						    if not piarcheck.v then
			   				    imgui.SetCursorPos(imgui.ImVec2(64, 25))
			                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 1.00, 1.00, 0.65))
			                        if imgui.Button(u8"���� ��������## Unactive", imgui.ImVec2(233, 35)) then 
			                            piarbutton = "active" 
			                            piarcheck.v = true								
									end
			                    imgui.PopStyleColor()
							end	
			                if piarcheck.v then
			   					imgui.SetCursorPos(imgui.ImVec2(64, 25))
               					imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 0.50, 0.00, 1.00))			  
			    					if imgui.Button(u8"���� �������## Active", imgui.ImVec2(233, 35)) then 
			      						piarbutton = "unactive"
				  						piarcheck.v = false
									end
			   					imgui.PopStyleColor()
			  				end
				            imgui.SameLine()
				            imgui.TextQuestion(u8"�������� ���� � /vr � /j ����.")
							-- [��������� ���������]
							if piarcheck.v then
							    imgui.SetCursorPos(imgui.ImVec2(79, 64))
								imgui.LockedParam(u8"", imgui.ImVec2(213, 25))
								imgui.SetCursorPos(imgui.ImVec2(87, 65))
				                imgui.Text(u8"��������� ���������: /piar")
                                imgui.SameLine()
				                imgui.TextQuestion(u8"�������� ������������ ��������� � ������������ ���������")
								imgui.NewLine()
				                imgui.SliderInt(u8"�������� (�)", slider, 15, 1200, u8"%.0fc")
				                imgui.NewInputText(u8'������� #1', chatsms, 237, u8'������: /vr ����� �����', 1)
								imgui.NewLine()
				                imgui.NewInputText(u8'        ������� #2', famsms, 207, u8'������: /ad ������ �����', 1)
				                imgui.SetCursorPos(imgui.ImVec2(228, 195))
								imgui.Checkbox(u8"                 ", doppiar)
								imgui.SameLine()
				                imgui.TextQuestion(u8'�������� ������ � "������� �1" � ����������� � 6 ���')
								    imgui.SetCursorPos(imgui.ImVec2(15, 240))
                                        if imgui.ButtonActivated(infotextp.v==false, u8"OFF## InfoPiar 1", imgui.ImVec2(51, 25)) then infotextp.v = false end imgui.SameLine()
						            imgui.SetCursorPos(imgui.ImVec2(55, 240))
					                    if imgui.ButtonActivated(infotextp.v==true and infotextpdelay.v==false, u8"ON## InfoPiar 2", imgui.ImVec2(51, 25)) then infotextp.v = true infotextpdelay.v = false end imgui.SameLine()
									imgui.SetCursorPos(imgui.ImVec2(95, 240))	
									    if imgui.ButtonActivated(infotextp.v==true and infotextpdelay.v==true, u8"ON++## InfoPiar 3", imgui.ImVec2(51, 25)) then infotextp.v = true infotextpdelay.v = true end imgui.SameLine()
						            imgui.Text(u8'���������')
						            imgui.SameLine()
									imgui.SetCursorPos(imgui.ImVec2(239, 240))
				                    imgui.TextQuestion(u8"������� ��������� ������ ��������� �� �����.\n����� ��������� - �������� ����\n������� ��������� - �������� ���\n\nON++ ��� ������� ������ �� ��������")
									imgui.SameLine()
									if not infotextb.v or not binder.v then
									imgui.SetCursorPos(imgui.ImVec2(260, 240))
				                        if imgui.Button(u8"���������## ����", imgui.ImVec2(77, 25)) then
				                            checkpos = true
											main_window_state.v = false
									    end
									else
									imgui.TextQuestion(u8'��������� ��������� � ���� "�����������" > ��������� ����������� ������� �������')
									end
							else
                                imgui.LockedParam(u8"�������� ���� ��� �������� ��������## ����_����_������", imgui.ImVec2(345, 32))
				            end
				        else
						    autinfo = imgui.ImBool(false)
				            imgui.LockedParam(u8"����������� ������� ������� ��� �������������## ����_����", imgui.ImVec2(345, 60))
				        end
			 		elseif tab == "two" then
							if aut.v then
								imgui.Checkbox(u8"������ �����",timer)
								imgui.SameLine()
								imgui.TextQuestion(u8"����� � ��� ����� � ����� �� ������� �� �����")							
									  if imgui.CollapsingHeader(u8"��������� �����", true, imgui.TreeNodeFlags.DefaultOpen) then
				  						imgui.Checkbox(u8"���� �������� ������ ����", acd)
				  						imgui.SameLine()
				  						imgui.TextQuestion(u8"��� ������ ������ ������ ��� �� ������� ���� �� ����� �� ������������� ������� ����� ����")
				  						imgui.Checkbox(u8"�������������� ����� ����",asc)
			    						imgui.SameLine()
			    						imgui.TextQuestion(u8"����� ���� ��� �� ������� ���, ������ ��������� ���")
										imgui.Checkbox(u8"��������� ����� �����", mbc)
				  						imgui.SameLine()
				 						imgui.TextQuestion(u8"��� ��������� ���������� ����� �����")
				  						imgui.InputText(u8"���������", smsbc)
				  						imgui.Checkbox(u8"���� ���� ����� �����", at)
				  						imgui.SameLine()
				  						imgui.TextQuestion(u8"����� ������� ����� ������ ��� �������� /time � ����������")
				 					  end
							else
							imgui.LockedParam(u8"����������� ������� ������� ��� �������������## ����_�����", imgui.ImVec2(345, 60))
							end
					-- [����������� ���������]
			 		elseif tab == "three" then
						if aut.v then	
							imgui.SetCursorPos(imgui.ImVec2(15, 5))
							imgui.TextColored(imgui.ImVec4(0.20, 0.25, 0.29, 1.00), u8'by Vadyao')
							imgui.SetCursorPos(imgui.ImVec2(105, 5))
							imgui.LockedParam(u8"", imgui.ImVec2(166, 25))
							imgui.SetCursorPos(imgui.ImVec2(126, 5))
							imgui.Text(u8'���������: /atoch')
							if toch.v == "unactive" then
								imgui.SetCursorPos(imgui.ImVec2(64, 25))
								imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 1.00, 1.00, 0.65))
									if imgui.Button(u8"����������� ���������## ATUnactive", imgui.ImVec2(233, 35)) then 
										toch.v = "active"									                            										
									end
								imgui.PopStyleColor()
							elseif toch.v == "active" then
								imgui.SetCursorPos(imgui.ImVec2(64, 25))
								imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 0.50, 0.00, 1.00))			  
									if imgui.Button(u8"����������� ��������## ATActive", imgui.ImVec2(233, 35)) then 
										toch.v = "unactive"
									end
								imgui.PopStyleColor()
							end
							if toch.v == "active" then
								imgui.SameLine()
								imgui.TextQuestion(u8"��������� �������������� ������� �����������.\n����������:\n1. ��������, �� ������� ������ ������ ���������\n2. �������� ��� ������\n3. ������� ������� /atoch � ������ ��� ����� ��������� �������,\n���� �� ��������� ��������� ������� ��� �� �������� �������.")
								imgui.NewLine()
								imgui.SetCursorPos(imgui.ImVec2(55, 67))
								imgui.BeginChild("##��������_�����_����_�������_1", imgui.ImVec2(250, 75), true, imgui.WindowFlags.NoScrollbar)
									imgui.SetCursorPos(imgui.ImVec2(38, 10))
									imgui.Text(u8'�������� ��������� �������:')
									imgui.SetCursorPos(imgui.ImVec2(44, 37))
									imgui.SliderInt(u8"", checked_radio, 1, 12, "+%.0f")
								imgui.EndChild()
								imgui.SetCursorPos(imgui.ImVec2(55, 149))
								imgui.BeginChild("##��������_�����_����_�������_2", imgui.ImVec2(250, 75), true, imgui.WindowFlags.NoScrollbar)
									imgui.SetCursorPos(imgui.ImVec2(61, 10))
									imgui.Text(u8'��������, ��� ������:')
									imgui.SetCursorPos(imgui.ImVec2(15, 35))
										imgui.SetCursorPos(imgui.ImVec2(15, 35))
											if imgui.ButtonActivated(setmodelID==1615, u8"�������## InfoToch 1", imgui.ImVec2(105, 25)) then setmodelID = 1615 end imgui.SameLine()
										imgui.SetCursorPos(imgui.ImVec2(130, 35))
											if imgui.ButtonActivated(setmodelID==16112, u8"�����## InfoToch 2", imgui.ImVec2(105, 25)) then setmodelID = 16112 end							
								imgui.EndChild()
								imgui.SetCursorPos(imgui.ImVec2(70, 243))
									if setmodelID == 16112 then
										imgui.Text(u8'����� ������ ��������������')
									else
										imgui.Text(u8'����� �������� ��������������')
									end
								imgui.SameLine()
								imgui.TextQuestion(u8"����� ����� ���� ������������� � ����� ���������. ���� ������� ��������, �� ������ ��� 15 ������ ����� ������ ��, ������ ���������.")
							else
								imgui.LockedParam(u8"����������� ����������� ��� �������� ��������## ����_�������_������", imgui.ImVec2(345, 32))
							end
						else
                            imgui.LockedParam(u8"����������� ������� ������� ��� �������������## ����_�������", imgui.ImVec2(345, 60))
						end
					elseif tab == "four" then
					    bindersettings()
					end
		        imgui.EndChild()
		        imgui.PopStyleColor()  					
end					
					
					
function bindersettings() -- [������ ���������]					
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.28, 0.56, 1.00, 1.00))
		imgui.Checkbox(u8"�������� ������",binder)
		imgui.SameLine()
		imgui.TextQuestion(u8"�������� ���������� ������, ������� ������� �� �������� NumPad �� 0 �� 9.")
					if binder.v then
						    imgui.SameLine()
							imgui.TextWithQuestion(u8'������� ��� ����� ��������� �� NumPad ��� Ctrl (���� � ��� ��� NumPad ������)\n*����������: (Ctrl+ -) ��� ������� ������ Ctrl � ������� - (�����)',u8'����� ������� -')
					        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.68, 0.30, 0.22, 0.50))
							imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.68, 0.30, 0.22, 0.30))
							imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.68, 0.30, 0.22, 0.40))
							if bindersetkey.v then
							    imgui.SetCursorPos(imgui.ImVec2(286, 16))
			    			    if imgui.Button(u8"Ctrl+ -## BUnactive", imgui.ImVec2(65, 23)) then 
			      				    bindersetkey.v = false 
			    			    end
			  			    elseif not bindersetkey.v then
							    imgui.SetCursorPos(imgui.ImVec2(286, 16))
			    			    if imgui.Button(u8"NumPad*## BActive", imgui.ImVec2(65, 23)) then 
			      				    bindersetkey.v = true
							    end
			  			    end
							imgui.PopStyleColor()
							imgui.PopStyleColor()
							imgui.PopStyleColor()
							imgui.PushStyleColor(imgui.Col.CheckMark, imgui.ImVec4(0.68, 0.30, 0.22, 1.00))
							imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.68, 0.30, 0.22, 0.80))
							imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.68, 0.30, 0.22, 0.90))
								if imgui.ButtonActivated(bindtab.v==1, u8"������ 1## BindTab_1", imgui.ImVec2(104, 25)) then 
					 				bindtab.v = 1
								end 
								imgui.SameLine()
            					if imgui.ButtonActivated(bindtab.v==2, u8"������ 2## BindTab_2", imgui.ImVec2(104, 25)) then 
									bindtab.v = 2 
								end 
								imgui.SameLine()
								if imgui.ButtonActivated(bindtab.v==3, u8"������ 3## BindTab_3", imgui.ImVec2(104, 25)) then 
					 				bindtab.v = 3 
								end
							imgui.PopStyleColor()
							imgui.PopStyleColor()
							imgui.PopStyleColor()
							imgui.SetCursorPos(imgui.ImVec2(7, 67))
							imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.68, 0.30, 0.22, 1.00))
							if darktheme.v then
							    imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.14, 0.17, 0.21, 1.00))
							else
							    imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.65, 0.65, 0.65, 1.00))
							end
				 			imgui.BeginChild("##��������_�����_����_������", imgui.ImVec2(351, 206), true, ImGuiWindowFlags_AlwaysVerticalScrollbar)
				 			if bindtab.v == 1 then
					 				binderset1.v = true
				     				binderset2.v = false
				     				binderset3.v = false 
                                    for b = 1, 10 do									
				   					    imgui.NewInputText(''..KeyB[b], bindt[b], 245, u8'����� �����', 1)
			    			        end
				   			elseif bindtab.v == 2 then
									binderset1.v = false
				    				binderset2.v = true
				    				binderset3.v = false 							
                                    for b = 1, 10 do									
				   					    imgui.NewInputText(''..KeyB[b], bindt[(10 + b)], 245, u8'����� �����', 1)
			    			        end			    			
				   			elseif bindtab.v == 3 then
					 				binderset1.v = false
				     				binderset2.v = false
				     				binderset3.v = true 							
                                    for b = 1, 10 do									
				   					    imgui.NewInputText(''..KeyB[b], bindt[(20 + b)], 245, u8'����� �����', 1)
			    			        end			    			
				   			end
							imgui.EndChild()
				        imgui.PopStyleColor() 
						imgui.PopStyleColor() 
					else
					imgui.LockedParam(u8"����������� ������ ��� �������� ��������## ����_������", imgui.ImVec2(345, 60))
					end	    
    imgui.PopStyleColor()   		
end

-- [������� ����������]
function saverconfigNew() -- ���� ����� ����������
				mainIni.config.ashar = ashar.v
				mainIni.config.shar = shar.v
				mainIni.config.sharkey = sharkey.v
				mainIni.config.piarcheck = piarcheck.v
				mainIni.config.cure = cure.v
				mainIni.config.vipcheck = vipcheck.v
				mainIni.config.catchmenu = catchmenu.v
				mainIni.config.checked_radio = checked_radio.v
				mainIni.config.smsvippr = smsvippr.v
				mainIni.config.bindt11 = bindt11.v
				mainIni.config.bindt12 = bindt12.v
				mainIni.config.bindt13 = bindt13.v
				mainIni.config.bindt14 = bindt14.v
				mainIni.config.bindt15 = bindt15.v
				mainIni.config.bindt16 = bindt16.v
				mainIni.config.bindt17 = bindt17.v
				mainIni.config.bindt18 = bindt18.v
				mainIni.config.bindt19 = bindt19.v
				mainIni.config.bindt20 = bindt20.v
				mainIni.config.bindt21 = bindt21.v
				mainIni.config.bindt22 = bindt22.v
				mainIni.config.bindt23 = bindt23.v
				mainIni.config.bindt24 = bindt24.v
				mainIni.config.bindt25 = bindt25.v
				mainIni.config.bindt26 = bindt26.v
				mainIni.config.bindt27 = bindt27.v
				mainIni.config.bindt28 = bindt28.v
				mainIni.config.bindt29 = bindt29.v
				mainIni.config.bindt30 = bindt30.v
				mainIni.config.binderset1 = binderset1.v
				mainIni.config.binderset2 = binderset2.v
				mainIni.config.binderset3 = binderset3.v
				mainIni.config.bindersetkey = bindersetkey.v
				mainIni.config.bindtab = bindtab.v
				mainIni.config.toch = toch.v
				mainIni.config.infotextb = infotextb.v
				mainIni.config.infotextp = infotextp.v
				mainIni.config.infotexttoch = infotexttoch.v
                mainIni.config.infotextpdelay = infotextpdelay.v				
				mainIni.config.autoad = autoad.v
				mainIni.config.autoad_id_type = autoad_id_type.v
				mainIni.config.slider = slider.v
				mainIni.config.vip_resend = vip_resend.v
				mainIni.config.fastrep = fastrep.v
				mainIni.config.darktheme = darktheme.v
				mainIni.config.sctime_toggle = sctime_toggle.v
				mainIni.config.newfont_fontini = newfont_font.v
				mainIni.config.newfont_fontsizeini = newfont_fontsize.v
				mainIni.config.newfont_fonttypeini = newfont_fonttype.v
				mainIni.config.newfont_colorini = newfont_color.v
end

function saverconfig() -- ����������� Upvalues!!!
		   saverconfigNew() -- �������� ����� ����������
                mainIni.config.lic = lic.v
				mainIni.config.trade = trade.v
				mainIni.config.tlf = tlf.v
				mainIni.config.arm = arm.v
				mainIni.config.msk = msk.v
				mainIni.config.smk = smk.v
				mainIni.config.nalogi = nalogi.v
				mainIni.config.cctime = cctime.v
				mainIni.config.spawncara = spawncara.v
				mainIni.config.lock = lock.v
				mainIni.config.jlock = jlock.v
				mainIni.config.fcar = fcar.v
				mainIni.config.recar = recar.v
				mainIni.config.scar = scar.v
				mainIni.config.lafk = lafk.v
				mainIni.config.cskill = cskill.v
				mainIni.config.test = test.v
				mainIni.config.key = key.v
				mainIni.config.aut = aut.v
				mainIni.config.abc = abc.v
				mainIni.config.acd = acd.v
				mainIni.config.nalog = nalog.v
				mainIni.config.dmg = dmg.v
				mainIni.config.asc = asc.v
				mainIni.config.mbc = mbc.v
				mainIni.config.timer = timer.v
				mainIni.config.at = at.v
				mainIni.config.smsbc = smsbc.v
				mainIni.config.chatsms = chatsms.v
				mainIni.config.rtsms = rtsms.v
				mainIni.config.famsms = famsms.v
				mainIni.config.zz = zz.v
				mainIni.config.famnames = famnames.v
				mainIni.config.flood = flood.v
				mainIni.config.olock = olock.v
				mainIni.config.pizza = pizza.v
				mainIni.config.vip = vip.v
				mainIni.config.smsvip = smsvip.v
				mainIni.config.chasi = chasi.v
				mainIni.config.drugs = drugs.v
				mainIni.config.doppiar = doppiar.v
				mainIni.config.binder = binder.v
				mainIni.config.bindt1 = bindt1.v
				mainIni.config.bindt2 = bindt2.v
				mainIni.config.bindt3 = bindt3.v
				mainIni.config.bindt4 = bindt4.v
				mainIni.config.bindt5 = bindt5.v
				mainIni.config.bindt6 = bindt6.v
				mainIni.config.bindt7 = bindt7.v
				mainIni.config.bindt8 = bindt8.v
				mainIni.config.bindt9 = bindt9.v
				mainIni.config.bindt10 = bindt10.v
				mainIni.config.binder = binder.v
				mainIni.config.aeda = aeda.v
				mainIni.config.invf = invf.v
				mainIni.config.tkey = tkey.v
				mainIni.config.armkey = armkey.v
				mainIni.config.maskkey = maskkey.v
				if inicfg.save(mainIni, 'Player ToolsE.ini') then
				 sampAddChatMessage("{FFD700}[Player Tools {ff0000}(BETA){FFD700}] {56d93f} ��������� ������� ���������!", -1)
				end
end
			
function main()
	autoupdate("https://raw.githubusercontent.com/LucasRozov/scripts/main/upd.json", '['..string.upper(thisScript().name)..']: ', "vk.com/scam.haha")
	while not isSampAvailable() do wait(0) end
	sampRegisterChatCommand("piar", function()
        if piarcheck.v then	
	        act = not act; sampAddChatMessage(act and '{01A0E9}������� ��������!' or '{01A0E9}������� ���������!', -1)
	        if act then
	            piar()
				actinfo = '0xFF109000'
			else
			    actinfo = '0xFF777777'
            end
	    end
	end)	
	-- [�����������: �������]
	sampRegisterChatCommand('atoch', function() 
		if toch.v == "active" then
            checked_box = not checked_box
            sampAddChatMessage(checked_box and '{01A0E9}����������� ��������!' or '{01A0E9}����������� ���������!', -1)
		end			
	end)
	
	sampRegisterChatCommand("pmenu", function()
        main_window_state.v = not main_window_state.v
    end)
	
	sampRegisterChatCommand('fh', function(num) 
		sampSendChat('/findihouse '..num) 
	end)
    
	sampRegisterChatCommand('h', function(num) 
		sampSendChat('/house '..num) 
	end)
    
	sampRegisterChatCommand('fmn', function(num) 
		sampSendChat('/fammenu '..num) 
	end)
	
	sampRegisterChatCommand('fbiz', function(num) 
		sampSendChat('/findibiz '..num) 
	end)

	
	sampAddChatMessage("{ff0000}Player Tools (BETA) {00ff00}��������! {ff0000}������: " ..version.. " ", 0xff0000ff)
	
	sampRegisterChatCommand('vip', function(id)
	if vipcheck.v then
			if tonumber(id) and tonumber(id) < 1000 and tonumber(id) > -1 then 
				lua_thread.create(function()
					go = os.time()
					checking = true
					sampSendChat('/vipplayers')
					while checking do 
						wait(0) 
						if tonumber(os.time() - go) > 5 then 
							checking = false
							sampAddChatMessage('{FF0090}[VIP-Check] {FFFFFF}����� ����� ��������. ���������� ��� ���', 0x5050FF)
							return
						end 
					end
					local strVips = table.concat(tVips, ', ')
					local nick = sampGetPlayerNickname(tonumber(id))
					sampAddChatMessage('{FF0090}[VIP-Check] {FFFFFF}�����{5050FF} '..nick..'{FFFFFF} '..(strVips:find(nick) and '�����' or '�� �����')..' Titan ��� Premium VIP!', 0x5050FF)
					tVips = {}
				end)
			else
				sampAddChatMessage('{FF0090}[VIP-Check] {FFFFFF}��������� /vip [id]', 0x5050FF)
			end
		end   
	end)
	
	sampRegisterChatCommand('calc', function(arg) 
    if #arg > 0 then 
        local k = calc(arg)
        if k then 
            sampAddChatMessage('{01A0E9}[Player Tools] {ff981a}�������� ������: ' ..arg.. ' = ' .. k,0x6495ED)  
        end 
    else sampAddChatMessage("{01A0E9}[Player Tools] {ff981a}������� ������ ������� ����� ������" , 0x6495ED)
    end
    --if #arg > 0 and arg:find("euro") then 
        --local k = 222
        --if k then 
           -- sampAddChatMessage('{01A0E9}[Player Tools] {ff981a}�������� ������: ' ..arg.. ' = ' .. k,0x6495ED)  
        --end 
    --else sampAddChatMessage("{01A0E9}[Player Tools] {ff981a}������� ������ ������� ����� ������" , 0x6495ED)
    --end
    end)
	
	sampRegisterChatCommand('rep', fastreport)
	

  while true do
	  wait(0)
	  imgui.Process = main_window_state.v or interface_tochnew_window.v
	  --[��������� ���� ������� (For DEBUG)]
	  bindermain()
	  --
	  if sctime_toggle.v then
	    sctime()
	  end
	  
	  if infotextb.v or infotextp.v then
	    infotext()
      end
	    --[��������]
		if lic.v and wasKeyPressed(0x31) and isKeyDown(0x12) then 
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local _, id = sampGetPlayerIdByCharHandle(ped)
			if id then
			        if id == -1 then sampAddChatMessage('[������] ����� ������ ���!', 0x6495ED) else
					   sampSendChat('/showskill '..id)
					end
			end
		end
		
		--[�����]
		if trade.v and wasKeyPressed(0x32) and isKeyDown(0x12) then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local _, id = sampGetPlayerIdByCharHandle(ped)
			if id then
			        if id == -1 then sampAddChatMessage('[������] ����� ������ ���!', 0x6495ED) else
					   sampSendChat('/trade '..id)
					end
			end
		end
		
		--[������ � ����]
		if invf.v and wasKeyPressed(0x33) and isKeyDown(0x12) then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local _, id = sampGetPlayerIdByCharHandle(ped)
			if id then
			        if id == -1 then sampAddChatMessage('[������] ����� ������ ���!', 0x6495ED) else
					   sampSendChat('/faminvite '..id)
					end
			end
		end
		
		--[���������]
		if cure.v and wasKeyPressed(0x34) and isKeyDown(0x12) then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local _, id = sampGetPlayerIdByCharHandle(ped)
			if id then
			        if id == -1 then sampAddChatMessage('[������] ����� ������ ���!', 0x6495ED) else
					   sampSendChat('/cure '..id)
					end
			end
		end
		
		if arm.v then
			if testCheat(armkey.v) and not sampIsChatInputActive() and not isKeyDown(0x11) then
				sampSendChat("/armour")
			end
		end
		if spawncara.v then
			if wasKeyPressed(4) then
              if not isCharOnFoot(playerPed) then
                 car = storeCarCharIsInNoSave(playerPed)
                 _, id = sampGetVehicleIdByCarHandle(car)
                 sampSendChat('/fixmycar '..id)
				end
			end
       end
		if smk.v then
			if testCheat("smk") and not sampIsCursorActive() then
				sampSendChat("/smoke")
			end
		end
		if msk.v then
			if testCheat(maskkey.v) and not sampIsCursorActive() and not isKeyDown(0x11) then
				sampSendChat("/mask")
			end
		end
		if timer.v then
			if sampIsDialogActive() and (sampGetCurrentDialogId() == 8869 or sampGetCurrentDialogId() == 8868) then
			ttime = os.clock()
			while sampIsDialogActive() do
				wait(0)
			end
			sampAddChatMessage(string.format("{ffffff}����� {ff981a}[%s]{ffffff} ���� �� {ff981a}[%s]{ffffff} ������",sampGetCurrentDialogEditboxText(), string.sub(os.clock() - ttime, 1, 5)), 16777215)
			end
		end
		if cctime.v then
			if testCheat(tkey.v) and not sampIsCursorActive() then				
				sampSendChat ("/time")
				wait(1000)
				if chasi.v=="" then else
				 sampSendChat(u8:decode(chasi.v))
				end
				wait(1800)
				sampSendChat ("/do �� ������ �����  "..os.date('%H:%M:%S'))
			end 
		end
		if olock.v and not sampIsCursorActive() then
			if testCheat("ol") then
				sampSendChat("/olock")
			end
		end
		if jlock.v and not sampIsChatInputActive() then
			if testCheat("jl") then
				sampSendChat("/jlock")
			end
		end
		if lock.v and not sampIsChatInputActive() then
			if testCheat("l") then
				sampSendChat("/lock")
			end
		end
		if drugs.v and not sampIsCursorActive() then
			if wasKeyPressed(0x61) and isKeyDown(0x12) then
                sampSendChat("/usedrugs 1")
            end
            if wasKeyPressed(0x62) and isKeyDown(0x12) then
                sampSendChat("/usedrugs 2")
            end
            if wasKeyPressed(0x63) and isKeyDown(0x12) then
                sampSendChat("/usedrugs 3")
			end
		end
		if fcar.v and not sampIsCursorActive() and isCharOnFoot(playerPed) then
			if testCheat("kk") then
				sampSendChat("/fillcar")
			end
		end
		if recar.v and not sampIsCursorActive() then
			if testCheat("rr") then
				sampSendChat("/repcar")
			end
		end
		if key.v and not sampIsCursorActive() and not isCharOnFoot(playerPed) then
			if testCheat("k") then
				sampSendChat("/key")
			end
		end
		if scar.v and not sampIsCursorActive() then
			if testCheat("oo") then
				sampSendChat("/style")
			end
		end
		if lafk.v and not sampIsCursorActive() then
			if testCheat("la") then
				sampSendChat("������ ������ ���������� � ����������")
			end
		end
		if cskill.v and not sampIsCursorActive() then
			if testCheat("ck") then
				sampSendChat("/cskill")
			end
		end
		if cheeps.v and not sampIsCursorActive() then
			if testCheat("ch") then
				sampSendChat("/cheeps")
			end
		end
		if shar.v then
			if testCheat(sharkey.v) and isCharOnFoot(playerPed) and not sampIsCursorActive() then
				sampSendChat("/balloon")
			end 
		end
		if ashar.v then -- [�������] 
         textdt = sampTextdrawGetString(2067)		
		  if sampTextdrawIsExists(2067) and textdt == "~w~PRESSED [ ~p~LALT~w~ ]" or textdt == "~w~PRESSED [ ~p~SPACE~w~ ]" or textdt == "~w~PRESSED [ ~p~H~w~ ]" and not sampIsCursorActive() then 
		    wait(1) 
		    autoshar() 
		  end
		end 
		if ashar.v then -- [�������2] 
         textdt2 = sampTextdrawGetString(2069)		
		  if sampTextdrawIsExists(2069) and textdt2 == "~w~PRESSED [ ~p~LALT~w~ ]" or textdt2 == "~w~PRESSED [ ~p~SPACE~w~ ]" or textdt2 == "~w~PRESSED [ ~p~H~w~ ]" and not sampIsCursorActive() then 
		    wait(1) 
		    autoshar()		
		  end
		end

        -- [��������� ���� � ������� �������]		
        if checkpos then
            sampToggleCursor(true)
            posX, posY = getCursorPos()
            if isKeyJustPressed(0x01) then
                main_window_state.v = true
                sampToggleCursor(false)
			    sampAddChatMessage("����� ������� �����������! X:" .. posX .." Y:".. posY .. ' | �� �������� ������ "��������� ���������"', 0xffffff)
		        mainIni.config.textposX = posX
	            mainIni.config.textposY = posY
			    checkpos = false
            end
        end	
		
		--[��������� Vip-Resend]
        if checkpos_vr then
            sampToggleCursor(true)
            posX_vr, posY_vr = getCursorPos()
			        testmessage_vs = "Test message. Vip-Resend by Cosmo."
					renderDrawBox(posX_vr, posY_vr, renderGetFontDrawTextLength(font, tostring(testmessage_vs), true) + 40, 23, 0xFF0090FF)
					 renderDrawPolygon(posX_vr - 3, posY_vr + 8, 18, 18, 16, 0, 0xFF0090FF) -- ����� ���� ����������
		             renderDrawPolygon(posX_vr - 3, posY_vr + 14, 18, 18, 16, 0, 0xFF0090FF) -- ����� ��� ����������
		             renderDrawPolygon(posX_vr + (renderGetFontDrawTextLength(font, tostring(testmessage_vs), true) + 40), posY_vr + 8, 18, 18, 16, 0, 0xFF0090FF) -- ������ ���� ����������
		             renderDrawPolygon(posX_vr + (renderGetFontDrawTextLength(font, tostring(testmessage_vs), true) + 40), posY_vr + 14, 18, 18, 16, 0, 0xFF0090FF) -- ������ ��� ����������
		        	 renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 20, 20, 16, 0, 0xFFFFFFFF)
        			 renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 15, 15, 8, 0, 0xFF0090FF)
                     renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 24, 24, 3, 0, 0xFF0090FF)					 
		        	 renderFontDrawText(font, tostring(testmessage_vs), posX_vr + 23, posY_vr + 2, -1)
            if isKeyJustPressed(0x01) then
                main_window_state.v = true
                sampToggleCursor(false)
			    sampAddChatMessage("����� ������� �����������! X:" .. posX .." Y:".. posY .. ' | �� �������� ������ "��������� ���������"', 0xffffff)
		        mainIni.config.textposX_vr = posX_vr
	            mainIni.config.textposY_vr = posY_vr
			    checkpos_vr = false
            end
        end		
		if checkpos_vr_default then
		    local el = getStructElement(sampGetInputInfoPtr(), 0x8, 4)
			posX_vr, posY_vr = getStructElement(el, 0x8, 4), getStructElement(el, 0xC, 4)
		    mainIni.config.textposX_vr = posX_vr
	        mainIni.config.textposY_vr = posY_vr
			sampAddChatMessage('��������� �������� �� �������������� ������ | �� �������� ������ "��������� ���������"', 0xffffff)			
			checkpos_vr_default = false
		end
		
		--[��������� sctime]
		if sctime_position then
		    sampToggleCursor(true)
		    scX, scY = getCursorPos()
		    if isKeyJustPressed(0x01) then
			    main_window_state.v = true
		        sampToggleCursor(false)
				sampAddChatMessage("����� ������� �����������! X:" .. scX .." Y:".. scY .. ' | �� �������� ������ "��������� ���������"', 0xffffff)
			    mainIni.config.scX = scX
	            mainIni.config.scY = scY		    
			    sctime_position = false
		    end
		end
		
		--[��������� �����������]
		if toch.v and infotexttoch.v and sampTextdrawGetString(2078) == "�A�O����" or sampTextdrawGetString(2078) == "ENCHANT" or sampTextdrawGetString(2078) == "O�MEH���" or sampTextdrawGetString(2078) == "CANCEL" then		    
			interface_tochnew_window.v = true
		else
			interface_tochnew_window.v = false
		end		
	end
end	

-- [������]
function bindermain()
    if bindersetkey.v then
		if binder.v and binderset1.v and not isKeyDown(0x12) then
			for d = 1, 10 do
      			if wasKeyPressed(KeyBinder[d]) and isKeyDown(0x11) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
					sampSendChat(u8:decode(bindt[d].v))
				end		
		    end
		elseif binder.v and binderset2.v and not isKeyDown(0x12) then
			for d = 1, 10 do
      			if wasKeyPressed(KeyBinder[d]) and isKeyDown(0x11) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
					sampSendChat(u8:decode(bindt[(10 + d)].v))
				end		
		    end
		elseif binder.v and binderset3.v and not isKeyDown(0x12) then
			for d = 1, 10 do
      			if wasKeyPressed(KeyBinder[d]) and isKeyDown(0x11) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
					sampSendChat(u8:decode(bindt[(20 + d)].v))
				end		
		    end			
		end
    else
		if binder.v and binderset1.v and not isKeyDown(0x12) then
		    for d = 1, 10 do
		        if isKeyJustPressed(KeyBinder[d]) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
			        sampSendChat(u8:decode(bindt[d].v))
			    end
		    end
        elseif binder.v and binderset2.v and not isKeyDown(0x12) then
		    for d = 1, 10 do
		        if isKeyJustPressed(KeyBinder[d]) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
			        sampSendChat(u8:decode(bindt[(10 + d)].v))
			    end
		    end
		elseif binder.v and binderset3.v and not isKeyDown(0x12) then
		    for d = 1, 10 do
		        if isKeyJustPressed(KeyBinder[d]) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
			        sampSendChat(u8:decode(bindt[(20 + d)].v))
			    end
		    end		
		end	
	end	
	
		--[����� ������� �������]
		if binder.v then
		   if bindersetkey.v then
           	if wasKeyPressed(0xBD) and isKeyDown(0x11) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
			    bindtab.v = bindtab.v+1
				if bindtab.v > 3 then bindtab.v = 1 end	
				if bindtab.v == 1 then
					binderset1.v = true
				    binderset2.v = false
				    binderset3.v = false
                elseif bindtab.v == 2 then
					binderset1.v = false
				    binderset2.v = true
				    binderset3.v = false 
                elseif bindtab.v == 3 then
					binderset1.v = false
				    binderset2.v = false
				    binderset3.v = true 
                end					
                sampAddChatMessage(' {0090FF}[Player Tools {ff981a}(BINDER){0090FF}] {56d93f} ���������� ������ #'..bindtab.v..'', -1)						
			end
           else			
			if isKeyJustPressed(VK_MULTIPLY) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then 
			    bindtab.v = bindtab.v+1
				if bindtab.v > 3 then bindtab.v = 1 end	
				if bindtab.v == 1 then
					binderset1.v = true
				    binderset2.v = false
				    binderset3.v = false
                elseif bindtab.v == 2 then
					binderset1.v = false
				    binderset2.v = true
				    binderset3.v = false 
                elseif bindtab.v == 3 then
					binderset1.v = false
				    binderset2.v = false
				    binderset3.v = true 
                end
                sampAddChatMessage(' {0090FF}[Player Tools {ff981a}(BINDER){0090FF}] {56d93f} ���������� ������ #'..bindtab.v..'', -1)						
			end
		   end
		end
        
		--[����� ��������� �������]
		if bindersetkey.v then
		    KeyB = {"Ctrl+1",
		        "Ctrl+2",
		        "Ctrl+3",
		        "Ctrl+4",
		        "Ctrl+5",
		        "Ctrl+6",
		        "Ctrl+7",
		        "Ctrl+8",
		        "Ctrl+9",
		        "Ctrl+0",
        	}

		    KeyBinder = {0x31,
		        0x32,
		        0x33,
		        0x34,
		        0x35,
		        0x36,
		        0x37,
		        0x38,
		        0x39,
		        0x30,
        	}            			
		else
		    KeyB = {"NumPad0",
			    "NumPad1",
			    "NumPad2",
			    "NumPad3",
			    "NumPad4",
			    "NumPad5",
			    "NumPad6",
			    "NumPad7",
			    "NumPad8",
			    "NumPad9",
            }
			
		    KeyBinder = {VK_NUMPAD0,
			    VK_NUMPAD1,
			    VK_NUMPAD2,
			    VK_NUMPAD3,
			    VK_NUMPAD4,
			    VK_NUMPAD5,
			    VK_NUMPAD6,
			    VK_NUMPAD7,
			    VK_NUMPAD8,
			    VK_NUMPAD9,
            }				
		end
end


function hook.onServerMessage(color, text)
        -- [�����]
	    if famnames.v then 
		    if text:find('(.+)(%d+)] ������ ���� ����������� �������� � �����!') then
			    lua_thread.create(function()
				  idf = text:match('%d+')
				   wait(100)
				    if sampIsPlayerConnected(tonumber(idf)) then
		              local famfile = io.open('moonloader/FamInvites.txt',"a")
		              famfile:write(''..sampGetPlayerNickname(idf)..' | �������: '..sampGetPlayerScore(idf)..' | '..os.date('%c')..'\n')
		              famfile:close()
		              sampAddChatMessage('{F2A1EE}[ARZ Fam Helper] {ffffff}'..sampGetPlayerNickname(idf)..' {ffff00}('..sampGetPlayerScore(idf)..' lvl) {42b201}��� �������� � ��� ������!', -1)			
				    end		
				end)	
		    end				
		end		
	if nalogi.v then
		if text:find("�� ����������� ������") and not text:find('�������') and not text:find('- |') and not text:find('���.') and not text:find('News') then
		   nalogovaya = nalogovaya + 20000
		   sampAddChatMessage("{73b461}[����������] {ffffff}�� ���������� ��� {73b461}"..nalogovaya..'$',-1)
		   return false
		end
	end
    if acd.v then
     if text:find("�����������! ������ ���� ��������� ����������� ���!") and not text:find('�������') and not text:find('- |') and not text:find(': ') then
			sampSendChat('/lock')
	  end
	end
	if asc.v then
		if text:find("�����������! ������ ���� ��������� ����������� ���!") and not text:find('�������') and not text:find('- |') and not text:find(': ') then
			lua_thread.create(function()
              if not isCharOnFoot(playerPed) then
                 car = storeCarCharIsInNoSave(playerPed)
                 _, id = sampGetVehicleIdByCarHandle(car)
                 sampSendChat('/fixmycar '..id)
				 sampAddChatMessage("{0090FF}[Player Tools {ff981a}(LITE){0090FF}]{ffffff}- �� ������� ���������� ���� ����������!",-1)
			  end
		  end)
		end
	end  
	if mbc.v then
		if text:find("�����������! ������ ���� ��������� ����������� ���!") or text:find("(.-)����������! ������ ���� ��� ���!(.-)") and not text:find('�������') and not text:find('- |') and not text:find(': ') and not text:find('[VIP]') and not text:find('[PREMIUM]') then
			lua_thread.create(function()
				wait(500)
				sampSendChat(u8:decode(smsbc.v))
			end)
		end
	end
	if at.v then
		if text:find("�����������! ������ ���� ��������� ����������� ���!") or text:find("(.-)����������! ������ ���� ��� ���!(.-)") and not text:find('�������') and not text:find('- |') and not text:find(': ') and not text:find('[VIP]') and not text:find('[PREMIUM]') then
			lua_thread.create(function()
				if mbc.v then
					wait(5000)
				end
				sampSendChat(u8:decode(chasi.v))
				sampSendChat("/time")
				wait(1200)
				sampSendChat ("/do �� �����  "..os.date('%H:%M:%S'))
			end)
		end
	end
	if vip.v then
		if text:find '����� (.-) �������� Titan VIP' and not text:find('�������') and not text:find('- |') then
			sampSendChat(u8:decode(smsvip.v))
		end
		if text:find '����� (.-) �������� PREMIUM VIP' and not text:find('�������') and not text:find('- |') then
			sampSendChat(u8:decode(smsvippr.v))
		end
	end
	if flood.v then
		if text:find("~~~~~~~~~~~~~~~~~~~~~~~~~~") and not text:find('�������') then
			return false
		end
		if text:find("- �������� �������") and not text:find('�������') then
			return false
		end
		if text:find("- �������� �����") and not text:find('�������') then
			return false
		end
		if text:find("- ����� � ���������") and not text:find('�������') then
			return false
		end
		if text:find("������") and not text:find('�������') then
			return false
		end
		if text:find("���� ���") and not text:find('�������') then
			return false
		end
		if text:find("����� ������") and not text:find('�������') then
			return false
		end
		if text:find("���� ���") and not text:find('�������') then
			return false
		end
		if text:find("����� ��������������") and not text:find('�������') then
			return false
		end
		if text:find("����������� �������") and not text:find('�������') then
			return false
		end
		if text:find("���������� �������� �����") and not text:find('�������') then
			return false
		end
		if text:find("��� ����") and not text:find('�������') then
			return false
		end
		if text:find("� ����� �������� �� ������ ���������� ������ ���������� ������� ����� � ���������") and not text:find('�������') then
			return false
		end
		if text:find("�� �� �������� �����") and text:find("��� �� ������� �����-������ ����������.") and not text:find('�������') then
			return false
		end
		if text:find("- ������ �� ��������") and text:find("����� ������� �����������, ��������� /help [������������ VIP]") and not text:find('�������') then
			return false
		end
		if text:find("- � �������� ���-�� ����� ���������� ������") and not text:find('�������') then
			return false
		end
	end	
	if checking then 
		local getname = text:match('^%[VIP%]: (.+)%[%d+%].+�������')
		if getname then
			table.insert(tVips, getname) 
			return false 
		end
	end
	if text:find('�����: %d+ �������') then 
		checking = false
		return false
	end
	if autoad.v and text:find('���� ��������� ���������������� � ������� � ����� ������������ ����� ��������!') or text:find('���� VIP ��������� ���������������� � ������� � ����� ������������ ����� ��������!') then
	    return false
	end
	
	--[Vip-resend by Cosmo]
	if vip_resend.v then
		if not finished_vs then
			if text:find('^%[������%].*����� ���������� ��������� � ���� ���� ����� ���������') then
				lua_thread.create(function()
					wait(delay_vipresend * 1000);
					sampSendChat('/vr ' .. message_vs)
					wait(500)
				end)
				return false
			end
			local id = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
			if text:match('%[%u+%] {%x+}[A-z0-9_]+%[' .. id .. '%]:') then
				finished_vs = true
			end
		end
		if text:find('^�� ���������') or text:find('��� ����������� ��������� �������� ��������� � ���� ���') then
			finished_vs = true
		end
	end
end

-- [Vip-Resend by Cosmo]
function hook.onSendCommand(cmd)
if vip_resend.v then
	local result_vs = cmd:match('^/vr (.+)')
	if result_vs ~= nil then 
		process_vs, finished_vs = nil, false
		message_vs = tostring(result_vs)
		process_vs = lua_thread.create(function()
			while not finished_vs do
				if sampGetGamestate() ~= 3 then
					finished_vs = true; break
				end
				if not sampIsChatInputActive() then
					local rotate = os.clock() * 3 * 90
					renderDrawBox(posX_vr, posY_vr, renderGetFontDrawTextLength(font, tostring(message_vs), true) + 40, 23, 0xFF0090FF)
					 renderDrawPolygon(posX_vr - 3, posY_vr + 8, 18, 18, 16, 0, 0xFF0090FF) -- ����� ���� ����������
		             renderDrawPolygon(posX_vr - 3, posY_vr + 14, 18, 18, 16, 0, 0xFF0090FF) -- ����� ��� ����������
		             renderDrawPolygon(posX_vr + (renderGetFontDrawTextLength(font, tostring(message_vs), true) + 40), posY_vr + 8, 18, 18, 16, 0, 0xFF0090FF) -- ������ ���� ����������
		             renderDrawPolygon(posX_vr + (renderGetFontDrawTextLength(font, tostring(message_vs), true) + 40), posY_vr + 14, 18, 18, 16, 0, 0xFF0090FF) -- ������ ��� ����������
		        	 renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 20, 20, 16, 0, 0xFFFFFFFF)
        			 renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 15, 15, 8, 0, 0xFF0090FF)
                     renderDrawPolygon(posX_vr + 5, posY_vr + (renderGetFontDrawHeight(font) / 2 + 3), 24, 24, 3, -1*rotate, 0xFF0090FF)					 
		        	 renderFontDrawText(font, tostring(message_vs), posX_vr + 23, posY_vr + 2, -1)
		        end
		        wait(0)
			end
		end)
	end
end
end

-- [�������]
function autoshar()
    if ashar.v and sampTextdrawIsExists(2066) or sampTextdrawIsExists(2069) and not sampIsCursorActive() then
      wait(0)
            gkey.player(9)
			gkey.player(21)
            gkey.player(16)	        
    end		
end
function gkey.player(keyid)
    setGameKeyState(keyid, 2550)
end

-- [���������: �����������]
function interface_tochnew()
	if interface_tochnew_window.v and not main_window_state.v then
	    pos_tochX1, pos_tochY1 = sampTextdrawGetPos(2077)
		pos_tochX, pos_tochY = convertGameScreenCoordsToWindowScreenCoords(pos_tochX1, pos_tochY1)
			imgui.SetNextWindowSize(imgui.ImVec2(525, 160), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowPos(imgui.ImVec2(pos_tochX + 138, pos_tochY + 130), imgui.Cond.Appearing, imgui.ImVec2(0.5, 0.5))
            imgui.PushStyleColor(imgui.Col.TitleBg, imgui.ImVec4(0.08, 0.08, 0.08, 1.00))	
			imgui.PushStyleColor(imgui.Col.TitleBgCollapsed, imgui.ImVec4(0.08, 0.08, 0.08, 1.00))	
			imgui.PushStyleColor(imgui.Col.TitleBgActive, imgui.ImVec4(0.08, 0.08, 0.08, 1.00))
			imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.08, 0.08, 0.08, 1.00))
			imgui.Begin(u8'                                                       �����������', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoBringToFrontOnFocus)
				imgui.SetCursorPos(imgui.ImVec2(15, 24))
					imgui.BeginChild("##�����������_���������_1", imgui.ImVec2(240, 75), true, imgui.WindowFlags.NoScrollbar)
						imgui.SetCursorPos(imgui.ImVec2(25, 10))
						imgui.Text(u8'�������� ��������� �������:')
						imgui.SetCursorPos(imgui.ImVec2(40, 37))
						imgui.SliderInt(u8"", checked_radio, 1, 12, "+%.0f")
						mainIni.config.checked_radio = checked_radio.v
					imgui.EndChild()
				imgui.SetCursorPos(imgui.ImVec2(270, 24))
					imgui.BeginChild("##�����������_���������_2", imgui.ImVec2(240, 75), true, imgui.WindowFlags.NoScrollbar)
						imgui.SetCursorPos(imgui.ImVec2(51, 10))
						imgui.Text(u8'��������, ��� ������:')
						imgui.SetCursorPos(imgui.ImVec2(15, 35))
							imgui.SetCursorPos(imgui.ImVec2(15, 35))
								if imgui.ButtonActivated(setmodelID==1615, u8"�������## InfoToch 1", imgui.ImVec2(100, 25)) then setmodelID = 1615 end imgui.SameLine()
							imgui.SetCursorPos(imgui.ImVec2(125, 35))
								if imgui.ButtonActivated(setmodelID==16112, u8"�����## InfoToch 2", imgui.ImVec2(100, 25)) then setmodelID = 16112 end							
					imgui.EndChild()
				imgui.SetCursorPos(imgui.ImVec2(15, 110))
					imgui.BeginChild("##�����������_���������_������", imgui.ImVec2(435, 39), true, imgui.WindowFlags.NoScrollbar)
					    imgui.SetCursorPos(imgui.ImVec2(15, 12))
					    imgui.Text(u8'������: '..atoch_status)
					imgui.EndChild()
				if checked_box then
				    checked_box_text = "ON"
				    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 1.00, 0.00, 0.50))
				else
				    atoch_status = u8'�������� �����������...'
				    checked_box_text = "OFF"
				    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.00, 0.00, 0.00, 0.50))
				end
				imgui.SetCursorPos(imgui.ImVec2(460, 110))
                if imgui.Button(u8''..checked_box_text, imgui.ImVec2(50, 39)) then
                    checked_box = not checked_box
					atoch_status = u8'������� �������, � ������ � ���������...' or u8'�������� �����������...' 
				end
				imgui.PopStyleColor()
		imgui.End()
		imgui.PopStyleColor()
		imgui.PopStyleColor()
		imgui.PopStyleColor()
		imgui.PopStyleColor()
	end
end

-- [���� � ������� ���� �������]		
function infotext()	
	if infotextb.v and binder.v and not sampGetGamestate() ~= 3 then -- [������ ON]
		renderDrawBox(posX, posY, 140, 20, 0xFF0090FF) -- �������������
         renderDrawPolygon(posX, posY + 7, 15, 15, 16, 0, 0xFF0090FF) -- ����� ���� ����������
		 renderDrawPolygon(posX, posY + 12, 15, 15, 16, 0, 0xFF0090FF) -- ����� ��� ����������
		 renderDrawPolygon(posX + 140, posY + 7, 15, 15, 16, 0, 0xFF0090FF) -- ������ ���� ����������
		 renderDrawPolygon(posX + 140, posY + 12, 15, 15, 16, 0, 0xFF0090FF) -- ������ ��� ����������
		renderFontDrawText(font, "������ ������� �"..bindtab.v, posX + 5, posY + 1, -1)
	end
	if infotextp.v and piarcheck.v and aut.v and not sampGetGamestate() ~= 3 then -- [���� ON]
		renderDrawPolygon(posX + 163, posY + 10, 21, 21, 20, 0, actinfo)
			if piar_delay_start and infotextpdelay.v and act then
				piar_delay_info = string.format("%.0f", piar_delay_timer - os.clock())
				if tonumber(piar_delay_info) < 1 then
					piar_delay_info = ">"
				end
				renderDrawBox(posX + 168, posY + 2, renderGetFontDrawTextLength(font, tostring(piar_delay_info), true) + 2, 16, actinfo)
				renderDrawPolygon(posX + (renderGetFontDrawTextLength(font, tostring(piar_delay_info), true) + 172), posY + 9.5, 16, 17, 20, 0, actinfo)
				renderFontDrawText(font, piar_delay_info, posX + 174, posY + 2, 0xFF770000)
			end
		renderFontDrawText(font, "P", posX + 159, posY + 2, -1)
	end
end

-- [�����]
function sctime()
	currenttime = os.time() + currenttime_shift
	renderFontDrawText(newfont, os.date("%H:%M:%S", currenttime), scX + 5, scY + 1, FColorTable[newfont_color.v])
end

-- [�������]
function hook.onDisplayGameText(style, time, text)
	if dmg.v then
	    if style == 3 and time == 1000 and text:find("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Jailed %d+ Sec%.") then
		  local c, _ = math.modf(tonumber(text:match("Jailed (%d+)")) / 60)
		  return {style, time, string.format("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Jailed %s Sec = %s Min.", text:match("Jailed (%d+)"), c)}
		end
	end
	if aeda.v then
	    if text:find("You are very hungry!") or text:find('You are hungry!') then
		sampSendChat('/jmeat')
		end
	end
end

-- [���� ��������]
function hook.onShowDialog(dialogId, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
    if zz.v then
	    if dialogText:find("� ���� ����� ���������") then
			return false
		end
	end
	if pizza.v then	
	    if dialogText:find("�� ������� ��������") then
			return false
		end
	end
	if tlf.v then
	   if dialogId == 1000 then
		   sampSendDialogResponse(1000,1,0,"")
		   return false
		end
	end
	if nalogi.v then
		if dialogText:find("��� �� ������") then
			sampAddChatMessage("{01A0E9}�� �������� ��� �� ������ �������",-1)
			return false
		end
		if dialogText:find("��� ������ �����") then
			return false
		end
	end
	
	--[�utoAD]--
	if autoad.v then
	    if dialogId == 15346 then
		    sampSendDialogResponse(15346,1,autoad_id_type.v,nil)
			return false
	    end
        if dialogId == 15347 then
			local adtext_parced, adtextr_parced, adtexttype_parced = dialogText:match('����� ����������:\n(.*)\n{ffff00}������������:(.*)\n{ffff00}��� ����������: (.*)\n{ffff00}��������')
			local adtextc_parced = dialogText:match('��������� ����������: (.*) {cccccc}')
			sampAddChatMessage('{ffff00}���� '..adtexttype_parced..'{ffff00} ���������� <<'..adtext_parced..'{ffff00}>> ', 0xffff00)
			sampAddChatMessage('���������������� �'..adtextr_parced..'{ffffff} NEWS {ffff00}�� '..adtextc_parced..'', 0xffff00)
			sampSendDialogResponse(15347,1,-1,nil)
			return false
	    end
	end
	
	if sctime_toggle then	
		if string.match(dialogText, "������� �����") then
			chislo, mesyac, god = string.match(dialogText, "����������� ����: 	{2EA42E}(%d+):(%d+):(%d+)")
			chas, minuti, sekundi = string.match(dialogText, "������� �����: 	{345690}(%d+):(%d+):(%d+)")
			datetime = {year = god,month = mesyac,day = chislo,hour = chas,min = minuti,sec = sekundi}
			currenttime_shift = tostring(os.time(datetime)) - os.time()
		end
	end
	
	if fastrep.v then
	    if dialogId == 32 then
		    return false
		end
	end
	
end

-- [��������]
function piar()
math.randomseed(os.clock())
	lua_thread.create(function()
	 local randsec1 = math.random(1,8) * 1000
	 local randsec2 = math.random(1,3) * 1000
		if act and doppiar.v then
		  delay1 = slider.v * 1000 - randsec1
		  delay2 = 9200 - randsec2
		   if act then
		    sampSendChat(u8:decode(chatsms.v))
		   end
		   piar_delay_start = true
		   piar_delay_timer = os.clock() + (delay2 / 1000)
		     --sampAddChatMessage('DEBUG: piar_delay_timer - ' ..tonumber(piar_delay_timer).. ' | delay2 - ' ..tostring(delay1).. ' | piar_delay_info - '..string.format("%.0f", piar_delay_timer - os.clock()), 0xffff00)
		   wait(delay2)
		   if act then
	        sampSendChat(u8:decode(famsms.v))
		   end
		   piar_delay_timer = os.clock() + (delay1 / 1000)
		     --sampAddChatMessage('DEBUG: piar_delay_timer - ' ..tonumber(piar_delay_timer).. ' | delay1 - ' ..tostring(delay1).. ' | piar_delay_info - '..string.format("%.0f", piar_delay_timer - os.clock()), 0xffff00)
           wait(delay1)
		   piar_delay_start = false
		  return true
		end
		if act and not doppiar.v then
		  delay1 = slider.v * 1000 - randsec1
		  if act then
		   sampSendChat(u8:decode(chatsms.v))
		  end
		  piar_delay_start = true
		  piar_delay_timer = os.clock() + (delay1 / 1000)
		    --sampAddChatMessage('DEBUG: piar_delay_timer - ' ..tonumber(piar_delay_timer).. ' | delay1 - ' ..tostring(delay1).. ' | piar_delay_info - '..string.format("%.0f", piar_delay_timer - os.clock()), 0xffff00)
		  wait(delay1)
		  piar_delay_start = false
		  return true
		end
	end)
end

function timertest(sec)
lua_thread.create(function()
    if alert_window_state.v then
	    blockbutton_timer = os.clock() + sec
	    wait(sec*1000)
    end
end)
end

-- [�����������]
function calc(m) 
    local func = load('return '..tostring(m)) 
    local a = select(2, pcall(func)) 
    return type(a) == 'number' and a
end

-- [�����������: ��� by Vadyao. �������� KitGov4e]
function hook.onShowTextDraw(textdrawId, data)
	if checked_box then
	 if sampTextdrawGetString(2078) == "O�MEH���" or sampTextdrawGetString(2078) == "CANCEL" then
	  atoch_status = u8'���� �������...'
	 end
		if checktochilki and data.modelId == setmodelID then
		   atoch_status = u8'������� �������...'
			worktread:terminate()
			checktochilki = false
			sampSendClickTextdraw(textdrawId)
			lua_thread.create(function()
				wait(wait_*1000)
				sampSendClickTextdraw(2077)
			end)
			atoch_status = u8'���� �������...'
		end
		if textdrawId == 2067 and not checktochilki then
		 if sampTextdrawGetString(2078) == "O�MEH���" or sampTextdrawGetString(2078) == "CANCEL" then
		   atoch_status = u8'���� �������...'
		 else		    
		   atoch_status = u8'������� �������, � ������ � ���������...'
		 end
			if data.boxColor == 1515015679 then
				if sampTextdrawGetString(2082) == '_' then
					checktochilki = true
					worktread = lua_thread.create(inventory)
				else
					sampSendClickTextdraw(2077)
				end
			elseif data.boxColor == 1515913037 then
			    atoch_status = u8'���� �������...'
				if tonumber(sampTextdrawGetString(2084):match('(%d+)')) < checked_radio.v then
					if sampTextdrawGetString(2082) == '_' then
						checktochilki = true
						worktread = lua_thread.create(inventory)
					else
						sampSendClickTextdraw(2077)
					end
				else
				    atoch_status = u8'������� ���������, ��������� ��������� �������...'
				end
			end
		end
	end
end

-- [�����������: ����� ���������]
function inventory()
	time = os.time()
	repeat wait(0)
	    atoch_status = u8'����� ������� � ���������...'
		if os.time() >= time+15 then
			checktochilki = false
			sampAddChatMessage("{01A0E9}[{ff981a}(�������){01A0E9}] {56d93f} � ��� ����������� �����/�������!", -1)
			atoch_status = u8'������� �� �������, ������� �����������...'
			break
		end
		sampSendClickTextdraw(2092)
		wait(1500)
		sampSendClickTextdraw(2093)
		wait(1500)
		sampSendClickTextdraw(2094)
		wait(1500)
	until not checktochilki 
end

-- [������� ������]
function fastreport(text)
	if fastrep.v then
		if #text == 0 then
			sampAddChatMessage('{ff6347}[ARZ ������� ������]:{ffffff} ������� ��� ������', 0xff6347)
		else
			sampSendChat('/rep')
			sampSendDialogResponse(32, 1, 0, text)
		end
	else
		sampSendChat('/rep')
	end
end



-- [����� �����]
function apply_custom_style()
	if not state then
  	imgui.SwitchContext()
  	local style = imgui.GetStyle()
   	local colors = style.Colors
   	local clr = imgui.Col
   	local ImVec4 = imgui.ImVec4
   	local ImVec2 = imgui.ImVec2
	style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 15.0
    style.FramePadding = ImVec2(5, 5)
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 15.0
    style.GrabRounding = 7.0
    style.ChildWindowRounding = 8.0
    style.FrameRounding = 6.0
	 if darktheme.v then
	  colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
      colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
      colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
      colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
      colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
      colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
      colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
      colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
      colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
      colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
      colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
      colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
      colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
      colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
      colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
      colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
      colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
      colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
      colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
      colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
      colors[clr.CloseButton] = ImVec4(1.00, 0.39, 0.38, 0.56)
      colors[clr.CloseButtonHovered] = ImVec4(1.00, 0.39, 0.38, 0.69)
      colors[clr.CloseButtonActive] = ImVec4(1.00, 0.39, 0.38, 1.00)
      colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
      colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
      colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
      colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
      colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)	  
	 else
	  colors[clr.Text] = ImVec4(0.00, 0.00, 0.00, 1.00)
      colors[clr.TextDisabled] = ImVec4(0.15, 0.15, 0.15, 1.00)
      colors[clr.WindowBg] = ImVec4(0.90, 0.90, 0.90, 1.00)
      colors[clr.ChildWindowBg] = ImVec4(0.75, 0.75, 0.75, 1.00)
      colors[clr.PopupBg] = ImVec4(0.50, 0.50, 0.50, 0.90)
      colors[clr.Border] = ImVec4(0.90, 0.90, 0.90, 0.50)
      colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.FrameBg] = ImVec4(0.60, 0.60, 0.60, 1.00)
      colors[clr.FrameBgHovered] = ImVec4(0.50, 0.50, 0.50, 1.00)
      colors[clr.FrameBgActive] = ImVec4(0.55, 0.55, 0.55, 1.00)
      colors[clr.TitleBg] = ImVec4(0.50, 0.50, 0.50, 0.65)
      colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
      colors[clr.TitleBgActive] = ImVec4(0.50, 0.50, 0.50, 1.00)
      colors[clr.MenuBarBg] = ImVec4(0.55, 0.55, 0.55, 1.00)
      colors[clr.ScrollbarBg] = ImVec4(0.48, 0.48, 0.48, 0.39)
      colors[clr.ScrollbarGrab] = ImVec4(0.40, 0.40, 0.40, 1.00)
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.36, 0.36, 0.36, 1.00)
      colors[clr.ScrollbarGrabActive] = ImVec4(0.33, 0.33, 0.33, 1.00)
      colors[clr.ComboBg] = ImVec4(0.60, 0.60, 0.60, 1.00)
      colors[clr.CheckMark] = ImVec4(0.50, 0.60, 1.00, 1.00)
      colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
      colors[clr.Button] = ImVec4(0.70, 0.80, 1.00, 1.00)
      colors[clr.ButtonHovered] = ImVec4(0.75, 0.85, 1.00, 1.00)
      colors[clr.ButtonActive] = ImVec4(0.58, 0.66, 1.00, 1.00)
      colors[clr.Header] = ImVec4(0.60, 0.60, 0.60, 0.55)
      colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
      colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
      colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
      colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
      colors[clr.CloseButton] = ImVec4(1.00, 0.39, 0.38, 0.56)
      colors[clr.CloseButtonHovered] = ImVec4(1.00, 0.39, 0.38, 0.69)
      colors[clr.CloseButtonActive] = ImVec4(1.00, 0.39, 0.38, 1.00)
      colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
      colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
      colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
      colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
      colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
	 end
	end
end
apply_custom_style()



function imgui.ButtonActivated(activated, ...)
    if activated then
        imgui.PushStyleColor(imgui.Col.Button, imgui.GetStyle().Colors[imgui.Col.CheckMark])
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.GetStyle().Colors[imgui.Col.CheckMark])
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.GetStyle().Colors[imgui.Col.CheckMark])

            imgui.Button(...)

        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()

    else
        return imgui.Button(...)
    end
end

function imgui.TextQuestion(text)
	imgui.TextDisabled('(?)')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.TextWithQuestion(text, ...)
	imgui.Text(...)
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.ButtonWithQuestion(text, ...)
	imgui.Button(...)
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.TextWithQuestionColored(text, ...)
	imgui.TextColored(...)
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end

function imgui.LockedParam(...) -- [ ������: imgui.LockedParam(u8"�������������## ����1", imgui.ImVec2(65, 23)) ]
        local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a/2) )
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a/2))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a/2))
            local this_pos = imgui.GetCursorPos()
			imgui.SetCursorPos(imgui.ImVec2(this_pos.x - 5, this_pos.y - 4))
			imgui.Button(...)
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
end

function imgui.CheckboxPlus(...)
    local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList() 
	local height = 27
    local width = 263
	local col_bg2 = imgui.GetColorU32(imgui.ImVec4(0.11, 0.15, 0.17, 0.15))
	local col_bg = imgui.GetColorU32(imgui.ImVec4(0.11, 0.15, 0.17, 0.15)) 
    draw_list:AddRectFilled(imgui.ImVec2(p.x - 4, p.y - 3), imgui.ImVec2(p.x + width, p.y + height), col_bg2, 8)
	draw_list:AddRectFilled(imgui.ImVec2(p.x - 3, p.y - 2), imgui.ImVec2(p.x + width - 1, p.y + height - 1), col_bg, 8)
	imgui.Checkbox(...)
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function imgui.ToggleButton(str_id, bool)
    local rBool = false
    if LastActiveTime == nil then
        LastActiveTime = {}
    end
    if LastActive == nil then
        LastActive = {}
    end
    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    local p = imgui.GetCursorScreenPos()
    local draw_list = imgui.GetWindowDrawList()
    local height = imgui.GetTextLineHeightWithSpacing() - 3
    local width = height * 1.55
    local radius = height * 0.50
    local ANIM_SPEED = 0.15
    if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
        bool.v = not bool.v
        rBool = true
        LastActiveTime[tostring(str_id)] = os.clock()
        LastActive[str_id] = true
    end
    local t = bool.v and 1.0 or 0.0
    if LastActive[str_id] then
        local time = os.clock() - LastActiveTime[tostring(str_id)]
        if time <= ANIM_SPEED then
            local t_anim = ImSaturate(time / ANIM_SPEED)
            t = bool.v and t_anim or 1.0 - t_anim
        else
            LastActive[str_id] = false
        end
    end
    local col_bg
	local col_bg2 = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Border])
    if imgui.IsItemHovered() then
        col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
    else
        col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ChildWindowBg])
    end
    draw_list:AddRectFilled(imgui.ImVec2(p.x - 2, p.y - 2), imgui.ImVec2(p.x + width, p.y + height), col_bg2, height * 0.5)
	draw_list:AddRectFilled(p, imgui.ImVec2(p.x + width - 2, p.y + height - 2), col_bg, height * 0.5)
    draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0) - 1, p.y + radius - 1), radius - 3, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.GetStyle().Colors[imgui.Col.Button]))
	imgui.SameLine()
	imgui.Text(str_id)
	return rBool
end

function update()
	sampAddChatMessage("������ 2.0",-1)
	sampAddChatMessage("���� ������: 08.01.2022",-1)
end

--
--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __ ) \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _ \\ V /  | | | | |_) | |   | ' /
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |   | |_| |  _ <| |___| . \
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\                                                                                                                                                                                                                  
--
-- Author: http://qrlk.me/samp
--
function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
	  function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
		  if doesFileExist(json) then
			local f = io.open(json, 'r')
			if f then
			  local info = decodeJson(f:read('*a'))
			  updatelink = info.updateurl
			  updateversion = info.latest
			  f:close()
			  os.remove(json)
			  if updateversion ~= thisScript().version then
				lua_thread.create(function(prefix)
				  local dlstatus = require('moonloader').download_status
				  local color = -1
				  sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
				  wait(250)
				  downloadUrlToFile(updatelink, thisScript().path,
					function(id3, status1, p13, p23)
					  if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
						print(string.format('��������� %d �� %d.', p13, p23))
					  elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
						print('�������� ���������� ���������.')
						sampAddChatMessage((prefix..'���������� ���������!'), color)
						goupdatestatus = true
						lua_thread.create(function() wait(500) thisScript():reload() end)
					  end
					  if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
						if goupdatestatus == nil then
						  sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
						  update = false
						end
					  end
					end
				  )
				  end, prefix
				)
			  else
				update = false
				print('v'..thisScript().version..': ���������� �� ���������.')
			  end
			end
		  else
			print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
			update = false
		  end
		end
	  end
	)
	while update ~= false do wait(100) end
  end
