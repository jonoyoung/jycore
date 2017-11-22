-- Player list, credit to Mr-Gash for the player list code https://github.com/Mr-Gash/GMod-Deathrun.
local PNL = {}

function PNL:Init()
	local width, height = ScrW() * 0.85, ScrH() * 0.9
	self:SetSize(width, height)
	self:SetPos(0, 0)

	-- Header for player list.
	local playerListHeader = vgui.Create("DPanel", self)
	playerListHeader:Dock(TOP)
	playerListHeader:DockMargin(15, 15, 0, 0)
	playerListHeader.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(1))
		draw.SimpleText("Player List", "JCBig", 10, h / 2, JC.GetColor(5), 0, 1)
	end

	local playerList = vgui.Create("DPanelList", self)
	playerList:SetSize(ScrW(), ScrH())
	playerList:Dock(TOP)
	playerList:DockMargin(15, 15, 5, 0)
	playerList:EnableVerticalScrollbar(true)
	playerList:SetSpacing(5)

	local playerListScrollBar = playerList.VBar
	playerListScrollBar.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.Colors.Transparent) end
	playerListScrollBar.btnGrip.Paint = function(self, w, h) draw.RoundedBox(6, 0, 0, w, h, JC.GetColor(2)) end
	playerListScrollBar.btnUp.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.Colors.Transparent) end
	playerListScrollBar.btnDown.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.Colors.Transparent) end

	local function GetPlayerIcon(muted)
		if (muted) then return "icon16/sound_mute.png" end

		return "icon16/sound.png"
	end

	surface.SetFont("JCLarge")
	local _, tH = surface.GetTextSize("|")
	local color = false

	for k, v in pairs(player.GetAll()) do
		if (v == LocalPlayer()) then continue end
		color = !color
		v._ListColor = color

		local icon
		local ply = vgui.Create("DButton")
		ply:SetText("")
		ply:SetSize(0, 36)
		ply.DoClick = function()
			if (!IsValid(v)) then return end
			local muted = v:IsMuted()
			v:SetMuted(!muted)
			icon:SetImage(GetPlayerIcon(!muted))
		end

		local moved = false
		ply.Paint = function(self, w, h)
			if (!IsValid(v)) then self:Remove() return end
			surface.SetDrawColor(v._ListColor && Color(45, 55, 65, 200) || Color(65, 75, 85, 200))
			surface.DrawRect(0, 0, w, h)
			draw.RoundedBox(4, 0, 0, w, h, JC.GetColor(1))
			draw.SimpleText(v:GetName(), "JCLarge", 2 + 32 + 5, h / 2 - tH / 2, JC.GetColor(4))

			if (!moved && w != 0) then icon:SetPos(ply:GetWide() - 20, ply:GetTall() / 2 - icon:GetTall() / 2) end
		end

		local ava = vgui.Create("AvatarImage", ply)
		ava:SetSize(32, 32)
		ava:SetPlayer(v, 32)
		ava:SetPos(2, 2)
		ava.OnCursorEntered = function() ava:SetCursor("hand") end
		ava.OnCursorExited = function() ava:SetCursor("none") end
		ava.DoClick = function() v:ShowProfile() end

		icon = vgui.Create("DImage", ply)
		icon:SetSize(16, 16)
		icon:SetPos(ply:GetWide() - 20, ply:GetTall() / 2 - icon:GetTall() / 2)
		icon:SetImage(GetPlayerIcon(v:IsMuted()))

		playerList:AddItem(ply)
	end
end

function PNL:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3)) end
vgui.Register("JPlayerList", PNL, "DScrollPanel")