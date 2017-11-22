AddCSLuaFile()

-- Setup initial variables.
JC = {}
JC.Version = "0.1.0"

-- Setup debug.
JC.Debug = {}
JC.Debug.Prefix = "[JC " .. JC.Version .. "] "
JC.Debug.Init_Prefix = "[Init] "
JC.Debug.Include_Prefix = "[Include] "
JC.Debug.Adding_Prefix = "[Adding] "
JC.Debug.Shared_Prefix = "[Including and Adding] "
JC.Debug.DB_Prefix = "[Database] "

JC.Debug.Server_Color = Color(0, 255, 255)
JC.Debug.Success_Color = Color(0, 255, 0)
JC.Debug.Error_Color = Color(255, 0, 0)
JC.Debug.Text_Color = Color(255, 255, 255)

-- User settings setup.
JC.Settings = {}

-- Initialise everything.
function JC.InitialiseAll()
	MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.Init_Prefix)
	MsgC(JC.Debug.Text_Color, "JYCore was ")
	MsgC(JC.Debug.Success_Color, "successfully ")
	MsgC(JC.Debug.Text_Color, "initialised.\n")
end

JC.InitialiseAll()

-- File inclusion print statements.
function JC.PrintServerFileType(fileName)
	MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.Include_Prefix)
	MsgC(JC.Debug.Success_Color, "Successfully ")
	MsgC(JC.Debug.Text_Color, "included " .. fileName .. ".\n")
end

function JC.PrintSharedFileType(fileName)
	MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.Shared_Prefix)
	MsgC(JC.Debug.Success_Color, "Successfully ")
	MsgC(JC.Debug.Text_Color, "included and added " .. fileName .. ".\n")
end

function JC.PrintClientFileType(fileName)
	MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.Adding_Prefix)
	MsgC(JC.Debug.Success_Color, "Successfully ")
	MsgC(JC.Debug.Text_Color, "added " .. fileName .. ".\n")
end

-- Create the server list database.
function JC.CreateServerDB()
	if (sql.TableExists("server_list")) then
		MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
		MsgC(JC.Debug.Text_Color, "The table 'server_list' already exists.\n")
	else
		if (!sql.TableExists("server_list")) then
			local query = "CREATE TABLE server_list \n" .. 
			[[
				(
					id INTEGER PRIMARY KEY AUTOINCREMENT,
					name VARCHAR(50),
					ip VARCHAR(50)
				)
			]]

			result = sql.Query(query)

			if (sql.TableExists("server_list")) then
				MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
				MsgC(JC.Debug.Success_Color, "Successfully ")
				MsgC(JC.Debug.Text_Color, "created the 'server_list' table.\n")
			else
				MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
				MsgC(JC.Debug.Error_Color, "Error: ")
				MsgC(JC.Debug.Text_Color, "the 'server_list' table could not be created.\n")
			end
		end
	end
end
hook.Add("Initialize", "Database Initialize", JC.CreateServerDB)

function JC.AddServer(serverName, ip)
	local name = sql.QueryValue("SELECT name FROM server_list WHERE name='" .. serverName .."'")

	if (name == serverName) then
		MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
		MsgC(JC.Debug.Text_Color, "This result already exists.\n")
	else
		sql.Query("INSERT INTO server_list(name, ip) VALUES( '" .. serverName .. "', '" .. ip .. "')")
		MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
		MsgC(JC.Debug.Success_Color, "Successfully ")
		MsgC(JC.Debug.Text_Color, "added the result into the table.\n")
	end
end

function JC.GetServerName(serverName)
	local name = sql.QueryValue("SELECT name FROM server_list WHERE name='" .. serverName .. "'")

	if (name) then
		return name
	else
		MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
		MsgC(JC.Debug.Error_Color, "Error: ")
		MsgC(JC.Debug.Text_Color, "could not get server name.\n")
	end
end

function JC.GetServerIP(serverName)
	local ip = sql.QueryValue("SELECT ip FROM server_list WHERE name='" .. serverName .. "'")
	
	if (ip) then
		return ip
	else
		MsgC(JC.Debug.Server_Color, JC.Debug.Prefix .. JC.Debug.DB_Prefix)
		MsgC(JC.Debug.Error_Color, "Error: ")
		MsgC(JC.Debug.Text_Color, "could not get server name.\n")
	end
end

-- Messy file inclusion section.
function JC.LoadFiles(folder, filePrefix)
	local files, folders = file.Find("jycore/" .. folder .. "/*", "LUA")

	for k, v in pairs(files) do
		local filetype = string.Left(files[k], 2)

		if (SERVER) then
			if not (filePrefix) then
				if (filetype == "sv") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				elseif (filetype == "cl") then
					AddCSLuaFile("jycore/" .. folder .. "/" .. files[k])
					JC.PrintClientFileType(files[k])
				elseif (filetype == "sh") then
					AddCSLuaFile("jycore/" .. folder .. "/" .. files[k])
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintSharedFileType(files[k])
				end
			else
				if (filePrefix == "shared") then
					AddCSLuaFile("jycore/" .. folder .. "/" .. files[k])
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintSharedFileType(files[k])
				elseif (filePrefix == "server") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				elseif (filePrefix == "client") then
					AddCSLuaFile("jycore/" .. folder .. "/" .. files[k])
					JC.PrintClientFileType(files[k])
				end
			end
		elseif (CLIENT) then
			if not (filePrefix) then
				if (filetype == "cl") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				elseif (filetype == "sh") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				end
			else
				if (filePrefix == "shared") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				elseif (filePrefix == "client") then
					include("jycore/" .. folder .. "/" .. files[k])
					JC.PrintServerFileType(files[k])
				end
			end
		end
	end
end

-- Include and add the config file manually.
AddCSLuaFile("jycore/sh_config.lua")
include("jycore/sh_config.lua")

-- The files and folders to include.
-- Add any folders or files here that you create.
JC.LoadFiles("core")
JC.LoadFiles("vgui", "client")
JC.LoadFiles("utilities")