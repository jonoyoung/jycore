-- Settings menu.
local PNL = {}

function PNL:Init()
	self:SetPos(0, 0)
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3))
	end

	-- Property sheet.
	local propertySheet = vgui.Create("DPropertySheet", self)
	propertySheet:Dock(FILL)
	propertySheet.Paint = function(self, w, h) draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3)) end

	-- Colour sheet.
	local colorSheet = vgui.Create("DScrollPanel")

	local colorSheetScrollBar = colorSheet:GetVBar()
	function colorSheetScrollBar:Paint(w, h) draw.RoundedBox(0, 5, 0, w - 5, h, JC.Colors.Transparent) end
	function colorSheetScrollBar.btnGrip:Paint(w, h) draw.RoundedBox(6, 5, 0, w - 5, h, JC.GetColor(2)) end
	function colorSheetScrollBar.btnUp:Paint(w, h) draw.RoundedBox(0, 5, 0, w - 5, h, JC.Colors.Transparent) end
	function colorSheetScrollBar.btnDown:Paint(w, h) draw.RoundedBox(0, 5, 0, w - 5, h, JC.Colors.Transparent) end

		-- Colour label.
		local colorHeader = colorSheet:Add("DPanel")
		colorHeader:SetSize(colorSheet:GetWide(), 20)
		colorHeader:Dock(TOP)
		colorHeader:DockMargin(0, 0, 0, 0)
		colorHeader.Paint = function(self, w, h)
			draw.SimpleText("Change the colours of the menu to your preference.", "JCLarge", 5, h / 2, JC.GetColor(5), 0, 1)
		end

			-- First colour header.
			local firstHeader = colorSheet:Add("DPanel")
			firstHeader:SetSize(colorSheet:GetWide(), 20)
			firstHeader:Dock(TOP)
			firstHeader:DockMargin(5, 10, 0, 10)
			firstHeader.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(2))
				draw.SimpleText("Primary Colour", "JCLarge", 10, h / 2, JC.GetColor(5), 0, 1)
			end
				local firstColor = colorSheet:Add("DColorMixer")

			-- Second colour header.
			local secondHeader = colorSheet:Add("DPanel")
			secondHeader:Dock(TOP)
			secondHeader:DockMargin(5, 10, 0, 10)
			secondHeader.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(2))
				draw.SimpleText("Secondary Colour", "JCLarge", 10, h / 2, JC.GetColor(5), 0, 1)
			end
				local secondColor = colorSheet:Add("DColorMixer")

			--Third colour header.
	 		local thirdHeader = colorSheet:Add("DPanel")
	 		thirdHeader:SetSize(colorSheet:GetWide(), 20)
	 		thirdHeader:Dock(TOP)
	 		thirdHeader:DockMargin(5, 10, 0, 10)
			thirdHeader.Paint = function(self, w, h)
	 			draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(2))
	 			draw.SimpleText("Tertiary Colour", "JCLarge", 10, h / 2, JC.GetColor(5), 0, 1)
	 		end
	 			local thirdColor = colorSheet:Add("DColorMixer")

	 		-- Fourth colour header.
	 		local fourthHeader = colorSheet:Add("DPanel")
	 		fourthHeader:SetSize(colorSheet:GetWide(), 20)
	 		fourthHeader:Dock(TOP)
	 		fourthHeader:DockMargin(5, 10, 0, 10)
			fourthHeader.Paint = function(self, w, h)
	 			draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(2))
	 			draw.SimpleText("Primary Text Colour", "JCLarge", 10, h / 2, JC.GetColor(5), 0, 1)
			end
	 			local fourthColor = colorSheet:Add("DColorMixer")

	 		-- Fifth colour header.
	 		local fifthHeader = colorSheet:Add("DPanel")
	 		fifthHeader:SetSize(colorSheet:GetWide(), 20)
	 		fifthHeader:Dock(TOP)
			fifthHeader:DockMargin(5, 10, 0, 10)
			fifthHeader.Paint = function(self, w, h)
	 			draw.RoundedBox(0, 0, 0, 3, h, JC.GetColor(2))
 				draw.SimpleText("Secondary Text Colour", "JCLarge", 10, h / 2, JC.GetColor(5), 0, 1)
			end
				local fifthColor = colorSheet:Add("DColorMixer")

			-- Colour blocks.
			firstColor:Dock(TOP)
			firstColor:DockMargin(5, 0, 5, 0)
			firstColor:SetColor(JC.GetColor(1))
			function firstColor:ValueChanged()
				JC.SendColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
			 	JC.SaveColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
			end

			secondColor:Dock(TOP)
			secondColor:DockMargin(5, 5, 5, 0)
			secondColor:SetColor(JC.GetColor(2))
			function secondColor:ValueChanged()
				JC.SendColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
				JC.SaveColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
			end

			thirdColor:Dock(TOP)
			thirdColor:DockMargin(5, 5, 5, 0)
			thirdColor:SetColor(JC.GetColor(3))
			function thirdColor:ValueChanged()
				JC.SendColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
				JC.SaveColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
			end

		 	fourthColor:Dock(TOP)
		 	fourthColor:DockMargin(5, 5, 5, 0)
		 	fourthColor:SetColor(JC.GetColor(4))
		 	function fourthColor:ValueChanged()
		 		JC.SendColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
		 		JC.SaveColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
		 	end
	
		 	fifthColor:Dock(TOP)
		 	fifthColor:DockMargin(5, 5, 5, 0)
		 	fifthColor:SetColor(JC.GetColor(5))
		 	function fifthColor:ValueChanged()
		 		JC.SendColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
		 		JC.SaveColor(firstColor:GetColor(), secondColor:GetColor(), thirdColor:GetColor(), fourthColor:GetColor(), fifthColor:GetColor())
		 	end

		 	-- Default colours.
		 	local defaultFirstColor = Color(38, 166, 91)
			local deafultSecondColor = Color(30, 132, 72)
			local defaultThirdColor = Color(236, 240, 241)
			local defaultFourthColor = Color(255, 255, 255)
			local defaultFifthColor = Color(0, 0, 0)

			-- Reset colour button.
			local resetButton = colorSheet:Add("JButton")
			resetButton:SetSize(0, 30)
			resetButton:Dock(TOP)
			resetButton:DockMargin(5, 5, 5, 10)
			resetButton:SetText("Reset")
			resetButton.DoClick = function()
				JC.SendColor(defaultFirstColor, defaultSecondColor, defaultThirdColor, defaultFourthColor, defaultFifthColor)
			 	JC.SaveColor(defaultFirstColor, defaultSecondColor, defaultThirdColor, defaultFourthColor, defaultFifthColor)
			end

 		local settingSheet = vgui.Create("DScrollPanel")
 		local ape = vgui.Create("DButton", settingSheet)
 		ape:SetText("LOL")

	 	-- Paint the property sheet.
	 	propertySheet.Paint = function(self, w, h)
	 		draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3))

	 		for k, v in pairs(propertySheet.Items) do
	 			v.Tab:SetSize(0, 0)
	 			v.Tab:SetVisible(false)
	 		end
	 	end

 		-- Get location of tabs.
 		local propertySheet_x, propertySheet_y = propertySheet:GetPos()
 		local tabSelected = 1

	 	local function TabOneSelected()
	 		if (tabSelected == 1) then
	 			return JC.GetColor(2)
	 		else
	 			return JC.GetColor(1)
	 		end
	 	end

	 	local function TabTwoSelected()
	 		if (tabSelected == 2) then
	 			return JC.GetColor(1)
	 		else
	 			return JC.GetColor(2)
	 		end
	 	end

	 	-- New colour tab.
	 	local colorTab = vgui.Create("JTabbedButton", self)
	 	local settingTab = vgui.Create("JTabbedButton", self)

	 	colorTab:SetSize(ScrW() * 0.425, 40)
	 	colorTab:SetSelected(true)
	 	colorTab:SetPos(0, propertySheet_y)
	 	colorTab:SetText("Colours")
	 	colorTab.DoClick = function()
	 		for k, v in pairs(propertySheet.Items) do
	 			if (k == 1) then
	 				propertySheet:SetActiveTab(v.Tab)
	 				tabSelected = 1
	 				settingTab:SetSelected(false)
	 				colorTab:SetSelected(true)
	 			end
	 		end
	 	end

	 	-- New setting tab.
	 	settingTab:SetSize(ScrW() * 0.425, 40)
	 	settingTab:SetPos(colorTab:GetWide(), propertySheet_y)
	 	settingTab:SetText("Settings")
	 	settingTab.DoClick = function()
	 		for k, v in pairs(propertySheet.Items) do
	 			if (k == 2) then
	 				propertySheet:SetActiveTab(v.Tab)
	 				tabSelected = 2
	 				colorTab:SetSelected(true)
	 				settingTab:SetSelected(false)
	 			end
	 		end
		end

	-- Add the sheets to the main property sheet.
	propertySheet:AddSheet("Colours", colorSheet, "icon16/user.png")
	propertySheet:AddSheet("Settings", settingSheet, "icon16/box.png")
end

function PNL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, JC.GetColor(3))
end
vgui.Register("JSettings", PNL, "DFrame")