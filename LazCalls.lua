local LSM = LibStub("LibSharedMedia-3.0") 
local LazCalls = LibStub("AceAddon-3.0"):NewAddon("LazCalls", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0")
-- local AceConsole = LibStub("AceConsole-3.0")
-- local AceComm = LibStub("AceComm-3.0")
-- local AceSerializer = LibStub("AceSerializer-3.0")

function LazCalls:OnInitialize()

    local colorString = "FF52FF0E"
    local commPrefix = "LazCalls"

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

    function LazCalls:OnCommReceived(prefix, message, distribution, sender)
        local deserializedTable = {LazCalls:Deserialize(message)}
		if (not deserializedTable[1]) then
            LazCalls:Print("Somethings up")
			return
		end

		tremove(deserializedTable, 1)
		local prefix, player, realm, coreVersion, arg6, arg7, arg8, arg9 = unpack(deserializedTable)
		player = sender
        LazCalls:Print(player)
    end

    -- AceComm:RegisterComm(commPrefix .. "request")
    -- AceComm:RegisterComm(commPrefix .. "reply")




    LazCalls:RegisterChatCommand("laz", "LazCallsSlashProcessor")

    function LazCalls:LazCallsSlashProcessor(input) 
        if input == "version" then
            local addonVersion = C_AddOns.GetAddOnMetadata("LazCalls", "Version")
            LazCalls:Print("LazCalls Version: ", addonVersion)
            -- AceComm:SendCommMessage(commPrefix .. "request", "requesting version", "RAID")
        else 
            LazCalls:Print("LazCalls")
            LazCalls:Print("Loaded Files: ")
            for _, val in ipairs(soundVals) do
                LazCalls:Print("|c" .. colorString .. val[1])
            end
        end
    end
    

end