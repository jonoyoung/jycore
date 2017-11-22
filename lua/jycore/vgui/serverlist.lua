-- THIS IS STILL VERY MUCH IN PROGRESS.

-- Server list panel.
local PNL = {}

function PNL:Init()
	self:SetPos(0, 0)
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3)) end

	local serverList = self:Add("DScrollPanel")
	serverList:Dock(FILL)

		-- Server label.
	local label = serverList:Add("DPanel")
	label:SetSize(self:GetWide(), 20)
	label:Dock(TOP)
	label:DockMargin(0, 0, 0, 0)
	label.Paint = function(self, w, h)
		draw.RoundedBox(0, 10, 0, 3, h, JC.GetColor(2))
		draw.SimpleText("Server List", "JCLarge", 20, h / 2, JC.GetColor(5), 0, 1)
	end

	-- Server header.
	local header = serverList:Add("DPanel")
	header:SetSize(self:GetWide(), 20)
	header:Dock(TOP)
	header:DockMargin(5, 10, 0, 10)
	header.Paint = function(self, w, h) draw.SimpleText("Here is a list of all of our servers.", "JCLarge", 5, h / 2, JC.GetColor(5), 0, 1) end

		-- Server name.
		local name = serverList:Add("DPanel")
		name:SetSize(serverList:GetWide(), ScrH() * 0.1)
		name:Dock(TOP)
		name:DockMargin(0, 20, 0, 0)
		name.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(2))
			draw.SimpleText(JC.GetServerName("Deathrun"), "JCLarge", 20, h / 2, JC.GetColor(4), 0, 1)
			draw.SimpleText(JC.GetServerIP("Deathrun"), "JCLarge", 120, h / 2, JC.GetColor(4), 0, 1)
		end

			-- Server connect button.
			local connect = name:Add("JButton")
			connect:SetPos(0, 0)
			connect:SetSize(100, name:GetTall())
			connect:SetText("Connect")
			connect.DoClick = function() LocalPlayer():ConCommand("connect " .. JC.GetServerIP("Deathrun") .. ":27015") end 
end

function PNL:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3)) end
vgui.Register("JServerList", PNL, "DFrame")