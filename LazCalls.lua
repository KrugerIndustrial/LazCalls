local LSM = LibStub("LibSharedMedia-3.0") 
local LazCalls = LibStub("AceAddon-3.0"):NewAddon("LazCalls", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0")
-- local AceConsole = LibStub("AceConsole-3.0")
-- local AceComm = LibStub("AceComm-3.0")
-- local AceSerializer = LibStub("AceSerializer-3.0")

function LazCalls:OnInitialize()

    local colorString = "FF52FF0E"
    local versionMatch = "FF1EFF0C"
    local verionsMisMatch = "FFFF4700"
    local addonVersion = C_AddOns.GetAddOnMetadata("LazCalls", "Version")

    local soundVals = {
        {"Move To Diamond|r", [[Interface\Addons\LazCalls\sound\MoveToDiamond.ogg]]},
        {"Move To Diamond_02|r", [[Interface\Addons\LazCalls\sound\MoveToDiamond.ogg]]},
        {"CN01-Blind Swipe|r", [[Interface\Addons\LazCalls\sound\CN01-Blind Swipe.ogg]]},
        {"CN01-Earsplitting Screech|r", [[Interface\Addons\LazCalls\sound\CN01-Earsplitting Screech.ogg]]},
        {"CN01-Echoing Screech|r", [[Interface\Addons\LazCalls\sound\CN01-Echoing Screech.ogg]]},
        {"CN01-Echolocation|r", [[Interface\Addons\LazCalls\sound\CN01-Echolocation.ogg]]}
    }

    for _, val in ipairs(soundVals) do
        LSM:Register("sound", "|c" .. colorString .. val[1], val[2])
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