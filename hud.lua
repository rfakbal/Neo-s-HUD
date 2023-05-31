
hook.Add("HUDShouldDraw", "DisableDefaultHUD", function(name)
    if name == "DarkRP_HUD" then
        return false
    end
end)

surface.CreateFont( "HealthBar", {
  font = "Trebuchet24",
  extended = false,
  size = 20,
  weight = 580,
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


function DrawHUD()
    local ply = LocalPlayer()

    local max_health_Length = 290
    local max_armor_Length = 290

    local health_length = ply:Health()*2.9
    local armor_length = ply:Armor()*2.9


    --local Avatar = vgui.Create( "AvatarImage")

    --Avatar:SetSize( 80, 80 )
    --Avatar:SetPos( 40, ScrH()-215 )
    --Avatar:SetPlayer( LocalPlayer(), 64 )

    if health_length > max_health_Length then 
      health_length = max_health_Length
    end

    if armor_length > max_armor_Length then 
      armor_length = max_armor_Length
    end

    draw.RoundedBox(6, 30, ScrH()-225, 312, 180, Color(0, 0, 0, 255))

    --draw.RoundedBox(4, 40, ScrH()-215, 90, 90, Color(255, 255, 255, 255))

    --draw.RoundedBox(6, 40, ScrH()-95, 290, 10, Color(255, 255, 255, 255))

    --draw.RoundedBox(6, 40, ScrH()-75, 290, 10, Color(255, 255, 255, 255))

    draw.RoundedBox(0, 40, ScrH()-80, health_length, 20, Color(220, 45, 45, 255))-- Health bar 
    draw.DrawText(tostring(ply:Health()),"HealthBar", 185, ScrH()-82, Color(255,255,255), TEXT_ALIGN_CENTER) -- Health text
    
    draw.RoundedBox(0, 40, ScrH()-58, armor_length, 5, Color(0, 130, 255, 255)) -- Armor bar

end


hook.Add("HUDPaint", "CustomHUD", DrawHUD) -- Calling the DrawHUD

