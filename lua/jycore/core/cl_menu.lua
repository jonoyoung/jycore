-- Close the menu if it is open.
JC.Menu = nil

function JC.CloseMenu()
	if (IsValid(JC.Menu)) then
		JC.Menu:AlphaTo(0, 0.15, 0)
		timer.Create("CloseMenu", 0.15, 1, function()
			JC.Menu:Remove()
		end)

		return true
	end

	return false
end

-- Create the menu.
function JC.CreateMenu()
	if (JC.CloseMenu()) then
		gui.EnableScreenClicker(false)
		return
	end

	local width, height = ScrW() * 0.85, ScrH() * 0.9
	local navWidth = ScrW() * 0.15

	-- Create frame for menu.
	JC.Menu = vgui.Create("JFrame")
	JC.Menu:SetSize(width, height)
	JC.Menu:Center()
	JC.Menu:SetTitle("")

	-- Top bar.
	local topBarHeight = 50
	local topBar = JC.Menu:Add("DPanel")
	topBar:SetSize(width, topBarHeight)
	topBar:SetPos(0, 0)
	topBar.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(1))
	end

		-- Homepage.
		local homePage = JC.Menu:Add("JHomePage")
		homePage:SetSize(width, height - topBarHeight)
		homePage:SetPos(0, topBarHeight)

		-- Info panel.
		local infoPanel = JC.Menu:Add("JInformation")
		infoPanel:SetSize(width, height - topBarHeight)
		infoPanel:SetPos(width, topBarHeight)
		infoPanel:SetVisible(false)

		-- Settings panel.
		local settingsPanel = JC.Menu:Add("JSettings")
		settingsPanel:SetSize(width, height - topBarHeight)
		settingsPanel:SetPos(width, topBarHeight)
		settingsPanel:SetVisible(false)

		-- Player list panel.
		local playerListPanel = JC.Menu:Add("JPlayerList")
		playerListPanel:SetSize(width, height - topBarHeight)
		playerListPanel:SetPos(width, topBarHeight)
		playerListPanel:SetVisible(false)

		-- Server list panel.
		local serverListPanel = JC.Menu:Add("JServerList")
		serverListPanel:SetSize(width, height - topBarHeight)
		serverListPanel:SetPos(width, topBarHeight)
		serverListPanel:SetVisible(false)

	/* BEGINNING OF NAVIGATION MENU CODE. */
	-- Navigation menu.
	local navHeight = ScrH() * 0.9
	local navigationMenu = JC.Menu:Add("DScrollPanel")
	navigationMenu:SetSize(navWidth, navHeight)
	navigationMenu:SetPos(-navWidth, 0)
	navigationMenu.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100)) end

	-- Top bar menu button.
	local navHover = false
	local navHidden = true
	local navMenuButton = topBar:Add("JButton")
	navMenuButton:SetSize(topBarHeight, topBarHeight)
	navMenuButton:SetPos(0, 0)
	navMenuButton.OnCursorEntered = function()
		navHover = true
		navMenuButton:SetCursor("hand")
	end
	navMenuButton.OnCursorExited = function()
		navHover = false
		navMenuButton:SetCursor("none")
	end
	navMenuButton.OnMousePressed = function()
		if (navHidden) then
			navMenuButton:MoveTo(navWidth, 0, 0.15, 0, 5)
			navigationMenu:MoveTo(0, 0, 0.15, 0, 5)
			navHidden = false
		else
			navMenuButton:MoveTo(0, 0, 0.15, 0, 5)
			navigationMenu:MoveTo(-navWidth, 0, 0.15, 0, 5)
			navHidden = true
		end
	end
	navMenuButton.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(1))

		if (navHover) then draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(2)) end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material("jycore/vgui/menu_bars.png"))
		surface.DrawTexturedRect(w / 2 - 8, h / 2 - 8, 16, 16)
	end

	function JC.NavigationMinimise()
		navigationMenu:MoveTo(-navWidth, 0, 0.15, 0, 5)
		navMenuButton:MoveTo(0, 0, 0.15, 0, 5)
		navHidden = true
	end

		-- Shadow.
		local shadowEdge = navigationMenu:Add("DPanel")
		shadowEdge:SetSize(navWidth - 2, navHeight)
		shadowEdge:SetPos(0, 0)
		shadowEdge.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(1))	end

		-- Header.
		local header = navigationMenu:Add("JHeader")
		header:SetSize(navWidth - 2, topBarHeight)
		header:SetPos(0, 0)
		header:SetText(JC.Settings.ServerName)
		header:SetFont("JCBig")

		-- General label.
		local generalHeader = navigationMenu:Add("DPanel")
		generalHeader:SetSize(navWidth - 2, 30)
		generalHeader:Dock(TOP)
		generalHeader:DockMargin(0, header:GetTall(), 0, 0)
		generalHeader.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w - 2, h, JC.Colors.White)
			draw.SimpleText("General", "JCLarge", 15, h / 2, JC.GetColor(5), 0, 1)
		end

			-- Information button.
			local infoButton = navigationMenu:Add("JButton")
			infoButton:SetSize(navigationMenu:GetWide() - 2, 30)
			infoButton:SetText("")
			infoButton:Dock(TOP)
			infoButton:DockMargin(0, 0, 2, 0)
			infoButton.PaintOver = function(self, w, h) draw.SimpleText("Information", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			infoButton.DoClick = function()
				if (!infoPanel:IsVisible()) then
					infoPanel:MoveTo(0, topBarHeight, 0.15, 0, 5)
					infoPanel:SetVisible(true)
				else
					timer.Simple(0.15, function() infoPanel:SetVisible(false) end)
					infoPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (settingsPanel:IsVisible()) then
					timer.Simple(0.15, function() settingsPanel:SetVisible(false) end)
					settingsPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (playerListPanel:IsVisible()) then
					timer.Simple(0.15, function() playerListPanel:SetVisible(false) end)
					playerListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (serverListPanel:IsVisible()) then
					timer.Simple(0.15, function() serverListPanel:SetVisible(false) end)
					serverListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				JC.NavigationMinimise()
			end

			-- Settings button.
			local settingsButton = navigationMenu:Add("JButton")
			settingsButton:SetSize(navigationMenu:GetWide() - 2, 30)
			settingsButton:SetText("")
			settingsButton:Dock(TOP)
			settingsButton:DockMargin(0, 0, 2, 0)
			settingsButton.PaintOver = function(self, w, h) draw.SimpleText("Settings", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			settingsButton.DoClick = function()
				if (!settingsPanel:IsVisible()) then
					settingsPanel:MoveTo(0, topBarHeight, 0.15, 0, 5)
					settingsPanel:SetVisible(true)
				else
					timer.Simple(0.15, function() settingsPanel:SetVisible(false) end)
					settingsPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (infoPanel:IsVisible()) then
					timer.Simple(0.15, function() infoPanel:SetVisible(false) end)
					infoPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (playerListPanel:IsVisible()) then
					timer.Simple(0.15, function() playerListPanel:SetVisible(false) end)
					playerListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (serverListPanel:IsVisible()) then
					timer.Simple(0.15, function() serverListPanel:SetVisible(false) end)
					serverListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				JC.NavigationMinimise()
			end

			-- Player list button.
			local playerListButton = navigationMenu:Add("JButton")
			playerListButton:SetSize(navigationMenu:GetWide() - 2, 30)
			playerListButton:SetText("")
			playerListButton:Dock(TOP)
			playerListButton:DockMargin(0, 0, 2, 0)
			playerListButton.PaintOver = function(self, w, h) draw.SimpleText("Player List", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			playerListButton.DoClick = function()
				if (!playerListPanel:IsVisible()) then
					playerListPanel:MoveTo(0, topBarHeight, 0.15, 0, 5)
					playerListPanel:SetVisible(true)
				else
					timer.Simple(0.15, function() playerListPanel:SetVisible(false) end)
					playerListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (infoPanel:IsVisible()) then
					timer.Simple(0.15, function() infoPanel:SetVisible(false) end)
					infoPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (settingsPanel:IsVisible()) then
					timer.Simple(0.15, function() settingsPanel:SetVisible(false) end)
					settingsPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (serverListPanel:IsVisible()) then
					timer.Simple(0.15, function() serverListPanel:SetVisible(false) end)
					serverListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				JC.NavigationMinimise()
			end

		-- Shop label.
		local shopHeader = navigationMenu:Add("DPanel")
		shopHeader:SetSize(navWidth - 2, 30)
		shopHeader:Dock(TOP)
		shopHeader:DockMargin(0, 10, 0, 0)
		shopHeader.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(4))
			draw.SimpleText("Shop", "JCLarge", 15, h / 2, JC.GetColor(5), 0, 1)
		end

			-- Shop button.
			local shopButton = navigationMenu:Add("JButton")
			shopButton:SetSize(navigationMenu:GetWide() - 2, 30)
			shopButton:SetText("")
			shopButton:Dock(TOP)
			shopButton:DockMargin(0, 0, 2, 0)
			shopButton.PaintOver = function(self, w, h) draw.SimpleText("Shop", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end

			-- Donate button.
			local donateButton = navigationMenu:Add("JButton")
			donateButton:SetSize(navigationMenu:GetWide() - 2, 30)
			donateButton:SetText("")
			donateButton:Dock(TOP)
			donateButton:DockMargin(0, 0, 2, 0)
			donateButton.PaintOver = function(self, w, h) draw.SimpleText("Donate", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			donateButton.DoClick = function() gui.OpenURL(JC.Settings.Donation) end

		-- Commuinty label.
		local communityHeader = navigationMenu:Add("DPanel")
		communityHeader:SetSize(navWidth - 2, 30)
		communityHeader:Dock(TOP)
		communityHeader:DockMargin(0, 10, 0, 0)
		communityHeader.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w - 2, h, JC.GetColor(4))
			draw.SimpleText("Community", "JCLarge", 15, h / 2, JC.GetColor(5), 0, 1)
		end

			-- Forum button.
			local forumButton = navigationMenu:Add("JButton")
			forumButton:SetSize(navigationMenu:GetWide() - 2, 30)
			forumButton:SetText("")
			forumButton:Dock(TOP)
			forumButton:DockMargin(0, 0, 2, 0)
			forumButton.PaintOver = function(self, w, h) draw.SimpleText("Forum", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			forumButton.DoClick = function() gui.OpenURL(JC.Settings.Forum) end

			-- Website button.
			local websiteButton = navigationMenu:Add("JButton")
			websiteButton:SetSize(navigationMenu:GetWide() - 2, 30)
			websiteButton:SetText("")
			websiteButton:Dock(TOP)
			websiteButton:DockMargin(0, 0, 2, 0)
			websiteButton.PaintOver = function(self, w, h) draw.SimpleText("Website", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			websiteButton.DoClick = function() gui.OpenURL(JC.Settings.Website) end
		
			-- Server list button.
			local serverListButton = navigationMenu:Add("JButton")
			serverListButton:SetSize(navigationMenu:GetWide() - 2, 30)
			serverListButton:SetText("")
			serverListButton:Dock(TOP)
			serverListButton:DockMargin(0, 0, 2, 0)
			serverListButton.PaintOver = function(self, w, h) draw.SimpleText("Server List", "JCLarge", 16 + 15, h / 2, JC.GetColor(4), 0, 1) end
			serverListButton.DoClick = function()
				if (!serverListPanel:IsVisible()) then
					serverListPanel:MoveTo(0, topBarHeight, 0.15, 0, 5)
					serverListPanel:SetVisible(true)
				else
					timer.Simple(0.15, function() serverListPanel:SetVisible(false) end)
					serverListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (infoPanel:IsVisible()) then
					timer.Simple(0.15, function() infoPanel:SetVisible(false) end)
					infoPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (settingsPanel:IsVisible()) then
					timer.Simple(0.15, function() settingsPanel:SetVisible(false) end)
					settingsPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				if (playerListPanel:IsVisible()) then
					timer.Simple(0.15, function() playerListPanel:SetVisible(false) end)
					playerListPanel:MoveTo(width, topBarHeight, 0.15, 0, 5)
				end

				JC.NavigationMinimise()
			end

		-- Player info.
		local playerInfo = navigationMenu:Add("DPanel")
		playerInfo:SetSize(navWidth - 2, 74)
		playerInfo:SetPos(0, navHeight - 74)
		playerInfo:SetText("")
		playerInfo.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(2)) end

			-- Avatar.
			local playerAvatar = vgui.Create("AvatarImage", playerInfo)
			playerAvatar:SetSize(64, 64)
			playerAvatar:SetPos(5, (playerInfo:GetTall() - playerAvatar:GetTall()) / 2)
			playerAvatar:SetPlayer(LocalPlayer(), 64)

			-- Player name.
			local playerName = playerInfo:Add("DLabel")
			playerName:SetText(LocalPlayer():GetName())
			playerName:SetFont("JCBig")
			playerName:SetColor(JC.GetColor(3))
			playerName:SizeToContents()
			playerName:SetPos(64 + 10, 5)

			-- Player info points.
			local playerPoints = playerInfo:Add("DLabel")
			-- playerPoints:SetText(JC.GetPoints() .. " " .. JC.Settings.CurrencyName .. ".") You can use this if you create a shop and point system.
			playerPoints:SetText("10000000 " .. JC.Settings.CurrencyName .. ".")
			playerPoints:SetFont("JCLarge")
			playerPoints:SetColor(JC.GetColor(4))
			playerPoints:SizeToContents()
			playerPoints:SetPos(64 + 10, playerInfo:GetTall() - (playerPoints:GetTall() * 2) - 5)

			-- Player rank, it has a placeholder text because I haven't created a ranking system.
			local playerRank = playerInfo:Add("DLabel")
			-- playerRank:SetText(JC.GetRank()) You can use this if you create your own rank system.
			playerRank:SetText("Owner")
			playerRank:SetFont("JCLarge")
			playerRank:SetColor(JC.GetColor(4))
			playerRank:SizeToContents()
			playerRank:SetPos(64 + 10, playerInfo:GetTall() - playerRank:GetTall() - 5)
	/* END OF NAVIGATION MENU CODE. */

	gui.EnableScreenClicker(true)
end

net.Receive("MenuToggle", function() JC.CreateMenu() end)