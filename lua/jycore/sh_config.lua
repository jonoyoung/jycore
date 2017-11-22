-- This is the file you can use to customise all of the settings.

JC.Settings.ServerName = "Sample Community" -- Change this to the name of your server or community.
JC.Settings.OpenKey = "F3" -- You can set this to F1, F2, F3 and F4.

-- URLs
JC.Settings.MotdUrl = "https://jyoung.co" -- Set this to your MOTD url.
JC.Settings.Website = "https://jyoung.co" -- Set this to your url for links.
JC.Settings.Donation = "https://jyoung.co" -- Set this to your url for your donation link.
JC.Settings.Forum = "https://jyoung.co" -- Set this to your url for your forum link.

JC.Settings.CurrencyName = "points"

-- The message for the information page tab, set this to what ever you would like it to read.
JC.Settings.InfoText = [[
Sample Community is a friendly gaming community with a strong emphasis on uniqueness and fun.

We think that to be unique you need to bring something new and fun to the table, that will
make people want to keep coming back.

We believe that our community possesses these qualities. With our custom menu system it makes
it possible for users to find everything they will need in the one place. With leaderboards to
keep track of you and your friend's stats, all the way through to a store to keep your player
looking a bit more fancy.

Below are a couple of the commands that run on our servers.
        - F3 opens the JYCore Menu System.
        - !thirdperson toggles thirdperson. (If you have access to it.)
        - !rtv starts a vote to change the current map.

Enjoy your stay on our server and we look forward to hearing your comments and suggestions. 
(You can check out our forum by clicking on the forum button in this menu or visiting
sample.com/forums/)

Regards,
Sample Community.

JYCore 0.1.0
]]

-- Here is all of the servers in a list.
-- These are just examples use this format to add your own servers.
-- Don't touch the function.
function JC.InitServers()
	JC.AddServer("Deathrun", "10.1.1.1") -- Just add, remove or edit these.
	JC.AddServer("BHop", "10.1.1.2") -- Just add, remove or edit these.
end
hook.Add("Initialize", "Initialize Servers", JC.InitServers)