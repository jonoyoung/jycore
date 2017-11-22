-- Main frame.
local PNL = {}

AccessorFunc(PNL, "title", "Title", FORCE_STRING)
AccessorFunc(PNL, "draggable", "Draggable", FORCE_BOOL)

function PNL:Init()
	self:SetTitle("")
	self:SetDraggable(false)
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.Colors.Dark_Grey)
	draw.SimpleText(self:GetTitle(), "JCMedium", 5, 5, JC.Colors.Black, 0, 0)
end
vgui.Register("JFrame", PNL, "EditablePanel")