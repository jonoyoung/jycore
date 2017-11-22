-- Main header.
local PNL = {}

AccessorFunc(PNL, "text", "Text", FORCE_STRING)
AccessorFunc(PNL, "font", "Font", FORCE_STRING)

function PNL:Init()
	self:SetPos(0, 0)
	self:SetText("")
	self:SetFont("JCMedium")
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(2))
	draw.SimpleText(self:GetText(), self:GetFont(), w / 2, h / 2, JC.GetColor(4), 1, 1)
end
vgui.Register("JHeader", PNL, "EditablePanel")