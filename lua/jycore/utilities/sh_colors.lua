-- Create all colours to be used throughout the project.
JC.Colors = {}
JC.Colors.Transparent = Color(0, 0, 0, 0)
JC.Colors.Black = Color(0, 0, 0)
JC.Colors.White = Color(255, 255, 255)
JC.Colors.Pearl_White = Color(236, 240, 241)
JC.Colors.Light_Grey = Color(189, 195, 199)
JC.Colors.Grey = Color(149, 165, 166)
JC.Colors.Dark_Grey = Color(41, 41, 41)
JC.Colors.Light_Blue = Color(25, 181, 254)
JC.Colors.Blue = Color(18, 151, 224)
JC.Colors.Dark_Blue = Color(0, 87, 160)
JC.Colors.Grey_Blue = Color(44, 62, 80)
JC.Colors.Light_Green = Color(62, 220, 129)
JC.Colors.Green = Color(46, 204, 113)
JC.Colors.Dark_Green = Color(0, 108, 17)
JC.Colors.Orange = Color(243, 156, 18)
JC.Colors.Dark_Orange = Color(230, 126, 34)
JC.Colors.Yellow = Color(241, 196, 15)
JC.Colors.Dark_Red = Color(192, 57, 43)
JC.Colors.Red = Color(231, 76, 60)
JC.Colors.Dark_Purple = Color(78, 4, 109)
JC.Colors.Purple = Color(142, 68, 173)
JC.Colors.Dark_Brown = Color(94, 44, 11)
JC.Colors.Brown = Color(126, 76, 43)
JC.Colors.Teal = Color(22, 160, 133)
JC.Colors.Cyan = Color(55, 219, 208)
JC.Colors.Fuchsia = Color(202, 44, 104)
JC.Colors.Magenta = Color(234, 76, 136)
JC.Colors.Highlight = Color(139, 195, 74)

-- Colour changer.
-- Credit to Kurt Stolle for the colour shceme code. https://github.com/kurt-stolle/exclserver/blob/master/lua/exclserver/util/sh_color.lua
local mainColor = Color(38, 166, 91)
local secondColor = Color(30, 132, 72)
local thirdColor = Color(236, 240, 241)
local fourthColor = Color(255, 255, 255)
local fifthColor = Color(0, 0, 0)

function JC.SaveColor()
	if (!file.IsDir("jycore", "DATA")) then file.CreateDir("jycore") end

	file.Write("jycore/colors.txt", util.TableToJSON{main=mainColor,secondColor=secondColor,third=thirdColor,fourth=fourthColor,fifth=fifthColor})
end

function JC.GetColor(number)
	if (type(number) == "number") then
		if (number == 1) then
			return mainColor
		elseif (number == 2) then
			return secondColor
		elseif (number == 3) then
			return thirdColor
		elseif (number == 4) then
			return fourthColor
		elseif (number == 5) then
			return fifthColor
		end
	end

	return mainColor, secondColor, thirdColor, fourthColor, fifthColor
end

function JC.SendColor(main, second, third, fourth, fifth)
	if (!main || !second || !third || !fourth || !fifth) then
		mainColor = Color(38, 166, 19)
		secondColor = Color(30, 132, 72)
		thirdColor = Color(236, 240, 241)
		fourthColor = Color(255, 255, 255)
		fifthColor = Color(0, 0, 0)

		return
	end

	mainColor.r = main.r
	mainColor.g = main.g
	mainColor.b = main.b

	secondColor.r = second.r
	secondColor.g = second.g
	secondColor.b = second.b

	thirdColor.r = third.r
	thirdColor.g = third.g
	thirdColor.b = third.b

	fourthColor.r = fourth.r
	fourthColor.g = fourth.g
	fourthColor.b = fourth.b

	fifthColor.r = fifth.r
	fifthColor.g = fifth.g
	fifthColor.b = fifth.b
end

if (file.Exists("jycore/colors.txt", "DATA")) then
	local v = util.JSONToTable(file.Read("jycore/colors.txt", "DATA"))
	JC.SendColor(v.main, v.second, v.third, v.fourth, v.fifth)
end