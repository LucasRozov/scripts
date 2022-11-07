script_name('JLV Helper') -- название скрипта
script_author('Lucas_Rozob') -- автор скрипта
script_description('Script for JJLV 02 <3') -- описание скрипта
script_version("1.3")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/scripts/main/jlvhelper.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://vk.com/lucasrozov"
        end
    end
end


require "lib.moonloader" -- подключение библиотеки
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local main_color = 0x5A90CE
local main_color_text = "{5A90CE}"
local white_color = "{FFFFFF}"

local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

local main_window_state = imgui.ImBool(false)

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end

function main()
 if not isSampLoaded() or not isSampfuncsLoaded() then return end
 while not isSampAvailable() do wait(100) end
 sampAddChatMessage('{9370DB}[JLV Helper]{ffffff} Скрипт успешно загружен.', -1)
 sampAddChatMessage('{9370DB}[JLV Helper]{ffffff} Версия: 1.3 (BETA).', -1)


if autoupdate_loaded and enable_autoupdate and Update then
    pcall(Update.check, Update.json_url, Update.prefix, Update.url)
end



 sampRegisterChatCommand("invite", cmd_inv)
 sampRegisterChatCommand('giverank', cmd_giverank)
 sampRegisterChatCommand('fwarn', cmd_fwarn)
 sampRegisterChatCommand('uninvite', cmd_uninv)
 sampRegisterChatCommand('unfwarn', cmd_unfwarn)
 sampRegisterChatCommand('smenu', cmd_sobes)
 sampRegisterChatCommand('cuff', cmd_cuff)
 sampRegisterChatCommand('gotome', cmd_gotome)
 sampRegisterChatCommand('carcer', cmd_carcer)
 sampRegisterChatCommand('uncuff', cmd_uncuff)
 sampRegisterChatCommand('ungotome', cmd_ungotome)

imgui.Process = false

 while true do
  wait(0)

if main_window_state.v == false then 
    imgui.Process = false
end

  
 end
end


function imgui.OnDrawFrame()
    result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(400, 270), imgui.Cond.FirstUseEver)
    imgui.Begin(u8"Меню призывов и экзаменов", main_window_state, imgui.WindowFlags.NoResize)
    imgui.Text(u8'Добро пожаловать в меню призывов!\nДля того чтобы что-либо отправить - нажми на кнопку ниже!')
    if imgui.Button(u8'Приветствие') then
        sampSendChat('Здравия желаю! Вы пришли на призыв?')
    end
    imgui.SameLine()
    if imgui.Button(u8'Расскажите о себе') then
        sampSendChat('Отлично! Расскажите немного о себе, где проживаете, чем занимаетесь?')
    end
    imgui.Spacing()
    if imgui.Button(u8'Документы') then
        sampSendChat('Хорошо, мне нужны Ваши документы, а именно: паспорт, лицензии, мед.карта.')
        sampSendChat('/b Отыгровки документов обязательны!')
    end
    imgui.SameLine()
    if imgui.Button(u8'Вопрос #1') then
        sampSendChat('Хорошо, как Вы понимаете слово "адекватность"?')
    end
    imgui.Spacing()
    if imgui.Button(u8'Вопрос #2') then
        sampSendChat('Охарактеризуйте себя тремя словами.')
    end
    imgui.Spacing()
    if imgui.Button(u8'Годен') then    
        sampSendChat('Поздравляю! Вы годен, сейчас выдам Вам ключ от шкафчика.')
    end
    imgui.SameLine()
    if imgui.Button(u8'Не годен') then
        sampSendChat('К сожалению, вы не годны к службе.')
    end
    imgui.Spacing()
    if imgui.CollapsingHeader(u8'Дополнительные вопросы для призыва') then
       if imgui.Button(u8'Доп. вопрос #1') then
        sampSendChat('Что находится у меня над головой?')
       end
       if imgui.Button(u8'Почему ТСР') then
        sampSendChat('Почему Вы выбрали именно Тюрьму Строгого Режима?')
       end
    end
    imgui.Spacing()
    
    imgui.End()
end

function cmd_sobes()
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end


function cmd_inv(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите пригласить в организацию!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данныx Jail Las Venturas")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Добавить»")
            wait(2000)
            sampSendChat("/me ввел данные о новом военнослужащем")
            wait(2000)
            sampSendChat(string.format("/r В базу данных военнослужащих Jail Las Venturas был добавлен гражданин №%d.", id))
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat("/me сунув руку в карман, достал ключ от шкафчика")
            wait(2000)
            sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, удачной службы!*передав ключ", id))
            wait(2000)
           sampSendChat(string.format("/invite %d",id))
            wait(2000)
            end)
        end
end

function cmd_cuff(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите заковать в наручники!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me снял наручники с пояса")
            wait(2000)
            sampSendChat("/me надел наручники на человека")
            wait(2000)
            sampSendChat(string.format("/cuff %d",id))
            wait(2000)
            end)
        end
end

function cmd_uncuff(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите разковать!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал ключ от наручников")
            wait(2000)
            sampSendChat("/me снял наручники с человека")
            wait(2000)
            sampSendChat(string.format("/uncuff %d",id))
            wait(2000)
            end)
        end
end

function cmd_gotome(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите потащить за тобой!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me схватил человека за руку")
            wait(2000)
            sampSendChat("/me потащил человека за собой")
            wait(2000)
            sampSendChat(string.format("/gotome %d",id))
            wait(2000)
            end)
        end
end

function cmd_gotome(param)
    local id = string.match(param, "(%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите потащить за тобой!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me отпустил руку человека")
            wait(2000)
            sampSendChat(string.format("/ungotome %d",id))
            wait(2000)
            end)
        end
end

function cmd_carcer(param)
    local id, rank = string.match(param, "(%d+) (%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока и номер карцера!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достав ключи, открыл дверь карцера")
            wait(2000)
            sampSendChat("/todo Заходи, давай!*затаскивая заключенного в карцер")
            wait(2000)
            sampSendChat("/me закрыл карцер")
            wait(2000)
            sampSendChat("/do Карцер закрыт.")
            wait(2000)
            sampSendChat("Пол часа отдохнешь, посиди, подумай над своим поведением.")
            wait(2000)
            sampSendChat(string.format("/carcer %d %d", id, rank))
            wait(2000)
            end)
        end
end

function cmd_giverank(param)
    local id, rank = string.match(param, "(%d+) (%d+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите повысить!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данных Jail Las-Venturas")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me изменил данные о военнослужащем")
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
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которому хотите выдать выговор!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данныx Jail Las-Venturas")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me внес изменения в строке «Выговоры»")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был выдан выговор! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/fwarn %d %s", id, reason))
            wait(2000)
            end)
        end
end

function cmd_unfwarn(param)
    local id, reason = string.match(param, "(%d+) (.+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которому хотите снять выговор!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данныx Jail Las-Venturas")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me внес изменения в строке «Выговоры»")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был снят выговор! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/unfwarn %d %s", id, reason))
            wait(2000)
            end)
        end
end

function cmd_uninv(param)
    local id, reason = string.match(param, "(%d+) (.+)")
        if id == nil then
            sampAddChatMessage("{9370DB}[JLV Helper]{ffffff} Ошибка! Введите ID игрока, которого хотите уволить!", -1)
        else
            lua_thread.create(function()
            sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данныx Jail Las-Venturas")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Удалить»")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Военнослужащий с бейджиком №%d был уволен! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/uninvite %d %s", id, reason))
            wait(2000)
            end)
        end
end

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
                  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('Загрузка обновления завершена.')
                        sampAddChatMessage((prefix..'Обновление завершено!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': Обновление не требуется.')
              end
            end
          else
            print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end
  




function cmd_cmds()
	local text =	' \t \n' ..
	'{FFFFFF}1. {9370DB}/invite - {FFFFFF}Принять игрока в организацию с отыгровкой\n' ..
	'{FFFFFF}2. {9370DB}/giverank - {FFFFFF}Повысить сотрудника с отыгровкой\n' ..
	'{FFFFFF}3. {9370DB}/fwarn - {FFFFFF}Выдать выговор с отыгровкой\n' ..
	'{FFFFFF}4. {9370DB}/heal - {FFFFFF}Начать лечить игрока (до ответа что беспокоит)\n' ..
	'{FFFFFF}5. {9370DB}/heal1 - {FFFFFF}Продолжить лечить игрока!\n' ..
    '{FFFFFF}6. {9370DB}/medcard - {FFFFFF}Выдать мед.карту!' 
	sampShowDialog(1488, 'Команды скрипта', text, 'OK')
end

function apply_custom_style()
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
       colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
       colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
       colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
       colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
       colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
       colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
       colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
       colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
       colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
 end
 apply_custom_style()
