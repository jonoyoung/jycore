-- Homepage vGUI.
local PNL = {}

function PNL:Init()
	self:SetSize(ScrW() * 0.85, (ScrH() * 0.9) - 50)

	-- MOTD.
	local htmlMOTD = self:Add("HTML")
	htmlMOTD:SetSize(self:GetWide(), self:GetTall())
	htmlMOTD:SetPos(0, 0)
	htmlMOTD:OpenURL(JC.Settings.MotdUrl)
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3))
end
vgui.Register("JHomePage", PNL, "DScrollPanel")