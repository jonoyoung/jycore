-- Creating the function that toggles the menu.
util.AddNetworkString("MenuToggle")

function JC.GetMenuKey(key)
	local keyToBind = ""

	if (key == "F4") then
		keyToBind = "ShowSpare2"
	elseif (key == "F3") then
		keyToBind = "ShowSpare1"
	elseif (key == "F2") then
		keyToBind = "ShowTeam"
	elseif (key == "F1") then
		keyToBind = "ShowHelp"
	else
		keyToBind = ""
	end

	return keyToBind
end

function JC.SendMenu(ply)
	net.Start("MenuToggle")
	net.Send(ply)
end

hook.Add(JC.GetMenuKey(JC.Settings.OpenKey), "MenuToggle", function(ply)
	JC.SendMenu(ply)
end)