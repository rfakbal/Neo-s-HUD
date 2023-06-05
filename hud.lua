local hide = {
   ["DarkRP_LocalPlayerHUD"] = true,
   ["CHudDeathNotice"] = true,
   ["CHudAmmo"] = true,
   ["CHudSecondaryAmmo"] = true,
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
if hide[name] then return false end
end)

surface.CreateFont( "infoXLarge", {
   font = "Trebuchet24",
   extended = false,
   size = 40,
   weight = 600,
   blursize = 0,
   scanlines = 0,
   antialias = true,
   underline = false,
   italic = false,
   strikeout = false,
   symbol = false,
   rotary = false,
   shadow = false,
   additive = false,
   outline = false,
} )

surface.CreateFont( "infoLarge", {
   font = "Trebuchet24",
   extended = false,
   size = 23,
   weight = 530,
   blursize = 0,
   scanlines = 0,
   antialias = true,
   underline = false,
   italic = false,
   strikeout = false,
   symbol = false,
   rotary = false,
   shadow = false,
   additive = false,
   outline = false,
} )

surface.CreateFont( "infoSmall", {
   font = "Trebuchet24",
   extended = false,
   size = 17,
   weight = 530,
   blursize = 0,
   scanlines = 0,
   antialias = true,
   underline = false,
   italic = false,
   strikeout = false,
   symbol = false,
   rotary = false,
   shadow = false,
   additive = false,
   outline = false,
} )

local function DrawIcon( icon , x , y, w, h, clr )

   surface.SetMaterial( icon )
   surface.SetDrawColor(clr)
   surface.DrawTexturedRect( x, y, w, h )

end

local main_frame_color = Color(30, 30, 30, 255)

hook.Add("HUDPaint", "DrawMyHud", function()
local ply = LocalPlayer()

local max_health_Length = 290
local max_armor_Length = 290

local health_length = ply:Health() * 2.9
local armor_length = ply:Armor() * 2.9

if health_length > max_health_Length then
   health_length = max_health_Length
end

local cash_icon = Material( "icon16/money.png" )
local haveArmor = false

if ply:Armor() > 0 then haveArmor = true end
--local Avatar = vgui.Create("AvatarImage") 

--Avatar:SetSize(80, 80)
--Avatar:SetPos(ScrW() - 1890, ScrH() - 200) 
--Avatar:SetPlayer(ply, 64)

local main_frame_H = 155

if haveArmor then
   main_frame_H = 180 -- edits main frame's height depends on the haveArmor condition 
   if armor_length > max_armor_Length then
      armor_length = max_armor_Length
   end
end

draw.RoundedBox(6, ScrW() - 245, ScrH() - 100, 155, 90, Color(30, 30, 30, 255)) -- ammo frame

if ply:GetActiveWeapon() != NULL then -- checks if player got any weapon 
   local ammo_in_clip -- ammo value of the current mag/clip
   local clip_amount -- ammo value of the total mags/clips without current mag

   if ply:GetActiveWeapon():Clip1() < 0 then -- if the ammo is LEFF THAN 0 (Infinite) then do......
      ammo_in_clip = "∞" -- displays infinite sign
      clip_amount = ""  
   elseif ply:GetActiveWeapon():Clip1() > -1 then
      ammo_in_clip = ply:GetActiveWeapon():Clip1()
      clip_amount = "/"..ply:GetAmmoCount( ply:GetActiveWeapon():GetPrimaryAmmoType() )
   end

   draw.DrawText( ammo_in_clip..clip_amount ,"infoXLarge", ScrW() - 167, ScrH() - 78, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER ) -- displays ammo in and out of mag with "/"

else

   draw.DrawText( "You are dead" ,"infoXLarge", ScrW() - 167, ScrH() - 78, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER ) -- displays you are dead if you are dead
end


draw.RoundedBox(6, ScrW() - 1900, ScrH() - 210, 312, main_frame_H, main_frame_color) -- main frame

draw.RoundedBox(0, ScrW() - 1893, ScrH() - 203, 86, 86, Color(90, 90, 90, 255)) -- outline of the avatar

if haveArmor then
   draw.RoundedBox(0, ScrW()-1892, ScrH()-60, 294, 24, Color(90, 90, 90, 255)) -- outline of the armor bar
   draw.RoundedBox(0, ScrW() - 1890, ScrH() - 58, armor_length, 20, Color(0, 130, 255, 255))  -- armor bar
   draw.DrawText(tostring(ply:Armor()), "infoLarge", ScrW() - 1745, ScrH() - 60, Color(255, 255, 255), TEXT_ALIGN_CENTER) -- armor text
end

if string.len(ply:Name()) > 19 then
   draw.DrawText(ply:Name(), "infoSmall", ScrW() - 1800, ScrH() - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (resized)
else
   draw.DrawText(ply:Name(), "infoLarge", ScrW() - 1800, ScrH() - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (original size)
end

draw.DrawText("Job: "..ply:getDarkRPVar( "job" ), "infoLarge", ScrW() - 1800, ScrH() - 180, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- job
draw.DrawText("Salary: "..ply:getDarkRPVar( "salary" ).." $", "infoLarge", ScrW() - 1800, ScrH() - 160, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- salary
draw.DrawText( ply:getDarkRPVar("money").." $", "infoLarge", ScrW() - 1780,  ScrH() - 137, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT) -- money
draw.RoundedBox(0, ScrW() - 1892, ScrH() - 97, 294, 29, Color(90, 90, 90, 255)) -- outline of the health bar
draw.RoundedBox(0, ScrW() - 1890, ScrH() - 95, health_length, 25, Color(220, 45, 45, 255)) -- health bar
draw.DrawText(tostring(ply:Health()), "infoLarge", ScrW() - 1745, ScrH() - 95, Color(255, 255, 255), TEXT_ALIGN_CENTER) -- health text

DrawIcon(cash_icon, ScrW() - 1802, ScrH() - 132, 15, 15, Color(255,255,255,255)) -- displaying cash icon 

-- HUD mod configuration panel
local PANEL = {}

local function OpenConfigPanel()
    local configPanel = vgui.Create("DFrame")
    configPanel:SetSize(250, 200)
    configPanel:SetPos(ScrW() / 2 - configPanel:GetWide() / 2, ScrH() / 2 - configPanel:GetTall() / 2)
    configPanel:SetTitle("HUD Configuration")
    configPanel:SetDraggable(true)
    configPanel:ShowCloseButton(true)
    
    local colorMixer = vgui.Create("DColorMixer", configPanel)
    colorMixer:SetPos(10, 30)
    colorMixer:SetSize(230, 140)
    colorMixer:SetPalette(false)
    colorMixer:SetAlphaBar(false)
    colorMixer:SetWangs(true)
    colorMixer:SetColor(main_frame_color)
    colorMixer.ValueChanged = function(self, newColor)
        main_frame_color = newColor
    end

    local defaultButton = vgui.Create("DButton", configPanel)
    defaultButton:SetText("Default")
    defaultButton:SetPos(10, 180)
    defaultButton:SetSize(100, 30)
    defaultButton.DoClick = function()
        main_frame_color = Color(30, 30, 30, 255) -- Set the default color
        colorMixer:SetColor(main_frame_color) -- Update the color in the color mixer
    end
    
    configPanel:MakePopup()
end

concommand.Add("hud_config", OpenConfigPanel)

vgui.Register("HUDConfigPanel", PANEL, "DFrame")


-- Chat command to open the configuration panel
concommand.Add("hud_config", OpenConfigPanel)

-- Display HUD config panel on chat command "!hud"
local function ChatCommandHandler(ply, text)
    if text == "!hud" then
        OpenConfigPanel()
    end
end

hook.Add("OnPlayerChat", "HUDConfigChatCommand", ChatCommandHandler)
end)
