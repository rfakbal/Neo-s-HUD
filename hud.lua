include("fonts.lua")
local hide = {
   ["DarkRP_HUD"] = true,
   ["CHudDeathNotice"] = true,
   ["CHudAmmo"] = true,
   ["CHudSecondaryAmmo"] = true,
   ["CHudHealth"] = true,
   ["CHudBattery"] = true,
   ["CHudSuitPower"] = true,
   
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
   if hide[name] then return false end
end)

local avdraw = true

local function DrawIcon( icon , x , y, w, h, clr )

   surface.SetMaterial( icon )
   surface.SetDrawColor(clr)
   surface.DrawTexturedRect( x, y, w, h )

end

local scrw = 1920
local scrh = 1080

local main_frame_color = Color(30, 30, 30, 255)

local enableOutline = false


hook.Add("HUDPaint", "DrawMyHud", function()
   

   local ply = LocalPlayer()
   
   local max_health_Length = 290
   local max_armor_Length = 290
   
   local health_length = ply:Health() * 2.9
   local armor_length = ply:Armor() * 2.9
   
   if health_length > max_health_Length then
      health_length = max_health_Length -- checks if health value is higher than 100 and if yes, changes the size to default health length (100 HP)
   end -- imagine having 10000000000 hp, a lightsaber would appear on the screen lol .
   
   local cash_icon = Material( "icon16/money.png" )
   local license_icon = Material("icon16/shield.png")
   local haveArmor = false
   
   if ply:Armor() > 0 then haveArmor = true end
      
   if avdraw then
      local Avatar = vgui.Create("AvatarImage")
      Avatar:SetSize(80, 80)
      Avatar:SetPos(scrw - 1890, scrh - 200)
      Avatar:SetPlayer(ply, 64)
      avdraw = false
   end
   
   local main_frame_H = 155
   
   
   if haveArmor then
      main_frame_H = 184 -- edits main frame's height depends on the haveArmor condition
      if armor_length > max_armor_Length then
         armor_length = max_armor_Length
      end
   end
   
   if enableOutline then
      surface.SetDrawColor(15,15,15)
      surface.DrawOutlinedRect(scrw - 1903, scrh - 213, 318, main_frame_H+6, 3) -- main frame outline
      surface.DrawOutlinedRect(scrw - 1903, scrh - 213, 318, main_frame_H+6, 3)
   end


   draw.RoundedBox(6,  scrw - 245, scrh - 145, 155, 90, main_frame_color) -- ammo frame
   
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
   
      draw.DrawText( ammo_in_clip..clip_amount ,"infoXLarge", scrw - 167, scrh - 123, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER ) -- displays ammo in and out of mag with "/"
   
   else
   
      draw.DrawText( "F" ,"infoXLarge", scrw - 167, scrh - 78, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER ) -- displays F if you are dead
   end
   
   
   draw.RoundedBox(0, 20, scrh - 210, 312, main_frame_H, main_frame_color) -- main frame
   
   draw.RoundedBox(0, 27, scrh - 203, 86, 86, Color(90, 90, 90, 255)) -- outline of the avatar
   
   if haveArmor then
      draw.RoundedBox(0, 28, scrh-60, 294, 24, Color(90, 90, 90, 255)) -- outline of the armor bar
      draw.RoundedBox(0, 30, scrh - 58, armor_length, 20, Color(0, 130, 255, 255))  -- armor bar
      draw.DrawText(tostring(ply:Armor()), "infoLarge", 175, scrh - 60, Color(255, 255, 255), TEXT_ALIGN_CENTER) -- armor text
   end
   
   if string.len(ply:Name()) > 19 then
      draw.DrawText(ply:Name(), "infoSmall", 120, scrh - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (resized)
   else
      draw.DrawText(ply:Name(), "infoLarge", 120, scrh - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (original size)
   end
   
   draw.DrawText(ply:getDarkRPVar( "job" ), "infoLarge", 120, scrh - 175, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- job
   draw.DrawText(ply:getDarkRPVar( "salary" ).." $", "infoLarge", 280, scrh - 137, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- salary
   draw.DrawText( ply:getDarkRPVar("money").." $", "infoLarge", 138,  scrh - 137, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT) -- money
   draw.RoundedBox(0, 28, scrh - 97, 294, 29, Color(90, 90, 90, 255)) -- outline of the health bar
   draw.RoundedBox(0, 30, scrh - 95, health_length, 25, Color(220, 45, 45, 255)) -- health bar
   draw.DrawText(tostring(ply:Health()), "infoLarge", 175, scrh - 95, Color(255, 255, 255), TEXT_ALIGN_CENTER) -- health text

   DrawIcon(cash_icon, 118, scrh - 132, 15, 15, Color(255,255,255,255)) -- displaying cash icon
   if ply:getDarkRPVar("HasGunlicense") then
   DrawIcon(license_icon, 118, scrh - 151, 15, 15, Color(255,255,255,255)) --
   end


   local PANEL = {} -- HUD configuration panel
   
   local function OpenConfigPanel()
      local configPanel = vgui.Create("DFrame")
      configPanel:SetSize(250, 250)
      configPanel:SetPos(ScrW() / 2 - configPanel:GetWide() / 2, ScrH() / 2 - configPanel:GetTall() / 2)
      configPanel:SetTitle("HUD Configuration")
      configPanel:SetDraggable(true)
      configPanel:ShowCloseButton(true)
   
      local enableOutlineCheckbox = vgui.Create("DCheckBoxLabel", configPanel)
      enableOutlineCheckbox:SetPos(10, 180)
      enableOutlineCheckbox:SetText("Enable Outline")
      enableOutlineCheckbox:SetValue(enableOutline)
      enableOutlineCheckbox.OnChange = function(_, value_1)
      enableOutline = value_1
   end
   
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

   local restoreButton = vgui.Create("DButton", configPanel)
   restoreButton:SetPos(10, 220)
   restoreButton:SetSize(230, 20)
   restoreButton:SetText("Restore to Default")
   restoreButton.DoClick = function()
      main_frame_color = Color(30, 30, 30, 255)
      colorMixer:SetColor(main_frame_color)
   end
   
   
   configPanel:MakePopup()
   end
   
   
   concommand.Add("hud_config", OpenConfigPanel)
   
   vgui.Register("HUDConfigPanel", PANEL, "DFrame")
   
   

   concommand.Add("hud_config", OpenConfigPanel) -- chat command to open the configuration panel
   
   local function ChatCommandHandler(ply, text) -- display HUD config panel on chat command "!hud"
      if text == "!hud" then
         OpenConfigPanel()
      end
end

hook.Add("OnPlayerChat", "HUDConfigChatCommand", ChatCommandHandler)
end)
