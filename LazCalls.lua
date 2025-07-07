local LSM = LibStub("LibSharedMedia-3.0") 
local LazCalls = LibStub("AceAddon-3.0"):NewAddon("LazCalls", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0")

function LazCalls:OnInitialize()

    local colorString = "FF52FF0E"
    local versionMatch = "FF1EFF0C"
    local verionsMisMatch = "FFFF4700"
    local addonVersion = C_AddOns.GetAddOnMetadata("LazCalls", "Version")

    local soundVals = {
        {"Bait Adds|r", [[Interface\Addons\LazCalls\sound\Bait Adds.ogg]]},
        {"Bait Frontal|r", [[Interface\Addons\LazCalls\sound\Bait Frontal.ogg]]},
        {"Blue Team Soak|r", [[Interface\Addons\LazCalls\sound\Blue Team Soak.ogg]]},
        {"Break Shield|r", [[Interface\Addons\LazCalls\sound\Break Shield.ogg]]},
        {"CC Adds|r", [[Interface\Addons\LazCalls\sound\CC-Adds.ogg]]},
        {"Circles to Markers|r", [[Interface\Addons\LazCalls\sound\Circles to Markers.ogg]]},
        {"Circles to the Left|r", [[Interface\Addons\LazCalls\sound\Circles to the Left.ogg]]},
        {"Circles to the Right|r", [[Interface\Addons\LazCalls\sound\Circle to the Right.ogg]]},
        {"Clear Puddles|r", [[Interface\Addons\LazCalls\sound\Clear Puddles.ogg]]},
        {"Dodge Circles|r", [[Interface\Addons\LazCalls\sound\Dodge-Circles.ogg]]},
        {"DPS Adds|r", [[Interface\Addons\LazCalls\sound\DPS Adds.ogg]]},
        {"Everyone Soak|r", [[Interface\Addons\LazCalls\sound\Everyone-Soak.ogg]]},
        {"Everyone Spread Out|r", [[Interface\Addons\LazCalls\sound\Everyone-Spread-Out.ogg]]},
        {"Everyone Stack|r", [[Interface\Addons\LazCalls\sound\Everyone-Stack.ogg]]},
        {"Focus Big Add|r", [[Interface\Addons\LazCalls\sound\Focus Big Add.ogg]]},
        {"Melee Spread Out|r", [[Interface\Addons\LazCalls\sound\Melee Spread Out.ogg]]},
        {"Melee Stack|r", [[Interface\Addons\LazCalls\sound\Melee-Stack.ogg]]},
        {"Range Spread-Out|r", [[Interface\Addons\LazCalls\sound\Range-Spread-Out.ogg]]},
        {"Range Stack|r", [[Interface\Addons\LazCalls\sound\Range-Stack.ogg]]},
        {"Red Team Soak|r", [[Interface\Addons\LazCalls\sound\Red Team Soak.ogg]]},
        {"Soak Puddles|r", [[Interface\Addons\LazCalls\sound\Soak Puddles.ogg]]},
        {"Soak Soak Soak Soak Soak|r", [[Interface\Addons\LazCalls\sound\Soak Soak Soak Soak Soak.ogg]]},
        {"Tanks - Drop in Corner|r", [[Interface\Addons\LazCalls\sound\Tanks - Drop in Corner.ogg]]},
    }

    for _, val in ipairs(soundVals) do
        LSM:Register("sound", "|c" .. colorString .. val[1], val[2])
        -- LSM:Register("sound", val[1], val[2])
    end

    function LazCalls:OnCommReceived(commPrefix, message, channel, source)
        local deserializedTable = {LazCalls:Deserialize(message)}
		if (not deserializedTable[1]) then
            LazCalls:Print("Somethings up")
			return
		end

		tremove(deserializedTable, 1)
		local message, player = unpack(deserializedTable)
		player = source

        if(message == "REQUEST") then
            LazCalls:SendCommMessage("LAZCALLS", LazCalls:Serialize(addonVersion), "WHISPER", player)
        elseif channel == "WHISPER" then
            if(message == addonVersion) then
                message = "|c" .. versionMatch .. message
            else
                message = "|c" .. verionsMisMatch .. message
            end
            LazCalls:Print(player, message)
        end
        
    end

    LazCalls:RegisterComm("LAZCALLS")
    -- AceComm:RegisterComm(commPrefix .. "reply")

    LazCalls:RegisterChatCommand("laz", "LazCallsSlashProcessor")

    function LazCalls:LazCallsSlashProcessor(input) 
        if input == "version" then
            LazCalls:Print("LazCalls Version Check:")
            LazCalls:Print("Your Version: ", addonVersion)
            LazCalls:Print("------------------------")
            LazCalls:SendCommMessage("LAZCALLS", LazCalls:Serialize("REQUEST"), "GUILD")
        else 
            LazCalls:Print("LazCalls")
            LazCalls:Print("Loaded Files: ")
            for _, val in ipairs(soundVals) do
                LazCalls:Print("|c" .. colorString .. val[1])
            end
        end
    end
    

end