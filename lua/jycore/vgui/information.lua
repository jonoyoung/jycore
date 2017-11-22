-- Information page.
local PNL = {}

function PNL:Init()
	local infoHeader = self:Add("DPanel")
	infoHeader:SetSize(ScrW() * 0.5, 30)
	infoHeader:SetPos(15, 10)
	infoHeader.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(1))
		draw.SimpleText("Information", "JCBig", 10, h / 2, JC.GetColor(5), 0, 1)
	end

	local infoText = self:Add("DLabel")
	infoText:SetText(JC.Settings.InfoText)
	infoText:SetPos(20, 50)
	infoText:SetFont("JCLarge")
	infoText:SetColor(JC.GetColor(5))
	infoText:SizeToContents()
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3))
end
vgui.Register("JInformation", PNL, "DScrollPanel")