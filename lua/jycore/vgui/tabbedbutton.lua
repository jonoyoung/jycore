-- Tabbed button.
local PNL = {}

AccessorFunc(PNL, "disabled", "Disabled", FORCE_BOOL)
AccessorFunc(PNL, "text", "Text", FORCE_STRING)
AccessorFunc(PNL, "hover", "Hover", FORCE_BOOL)
AccessorFunc(PNL, "font", "Font", FORCE_STRING)
AccessorFunc(PNL, "selected", "Selected", FORCE_BOOL)

function PNL:Init()
	self:SetText("")
	self:SetFont("JCLarge")
	self.DoClick = function() end

	self.OnCursorEntered = function()
		self:SetHover(true)
		self:SetCursor("hand")
	end

	self.OnCursorExited = function()
		self:SetHover(false)
		self:SetCursor("none")
	end

	self.OnMouseReleased = function()
		if (!self:GetDisabled()) then self:DoClick() end
	end
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(2))

	if (self:GetSelected()) then draw.RoundedBox(0, 0, h - 3, w, 3, JC.GetColor(1))	end

	draw.SimpleText(self:GetText(), self:GetFont(), w / 2, h / 2, JC.GetColor(4), 1, 1)
end
vgui.Register("JTabbedButton", PNL, "Panel")