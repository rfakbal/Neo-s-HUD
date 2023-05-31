local hide = {
  ["DarkRP_LocalPlayerHUD"] = true,
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
  if hide[name] then return false end
end)

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


hook.Add("HUDPaint", "DrawMyHud", function()
    local ply = LocalPlayer()

    local max_health_Length = 290
    local max_armor_Length = 290

    local health_length = ply:Health() * 2.9
    local armor_length = ply:Armor() * 2.9

    if health_length > max_health_Length then 
      health_length = max_health_Length
    end

    --local Avatar = vgui.Create("AvatarImage")

    --Avatar:SetSize(80, 80)
    --Avatar:SetPos(40, ScrH() - 200)
    --Avatar:SetPlayer(ply, 64)

    draw.RoundedBox(6, ScrW() - 1900, ScrH() - 210, 312, 180, Color(20, 20, 20, 255)) -- main frame

    draw.RoundedBox(0, ScrW() - 1892, ScrH() - 202, 84, 84, Color(90, 90, 90, 255)) -- outline of the avatar
    
    if ply:Armor() > 0 then 
      draw.RoundedBox(0, ScrW()-1891, ScrH()-44, 292, 7, Color(90, 90, 90, 255)) -- outline of the armor bar
      draw.RoundedBox(0, ScrW() - 1890, ScrH() - 43, health_length, 5, Color(0, 130, 255, 255)) -- health bar -- Armor bar
      if armor_length > max_armor_Length then 
        armor_length = max_armor_Length
      end
    end 

    if string.len(ply:Name()) > 19 then
    draw.DrawText(ply:Name(), "infoSmall", ScrW() - 1800, ScrH() - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (resized)
    else 
    draw.DrawText(ply:Name(), "infoLarge", ScrW() - 1800, ScrH() - 203, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- name (original size)
    end 

    draw.DrawText("Job: "..ply:getDarkRPVar( "job" ), "infoLarge", ScrW() - 1800, ScrH() - 180, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- job 
    draw.DrawText("Salary: "..ply:getDarkRPVar( "salary" ), "infoLarge", ScrW() - 1800, ScrH() - 160, Color(255, 255, 255), TEXT_ALIGN_LEFT) -- salary

    draw.RoundedBox(0, ScrW() - 1891, ScrH() - 66, 292, 22, Color(90, 90, 90, 255)) -- outline of the health bar
    draw.RoundedBox(0, ScrW() - 1890, ScrH() - 65, health_length, 20, Color(220, 45, 45, 255)) -- health bar
    draw.DrawText(tostring(ply:Health()), "infoLarge", ScrW() - 1745, ScrH() - 67, Color(255, 255, 255), TEXT_ALIGN_CENTER) -- health text

end)
