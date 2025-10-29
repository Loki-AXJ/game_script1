local a=gg;local b=io;local c=os;local d=string;local e=table;local f=pcall;local g=gg.makeRequest;local h=gg.alert;local i=gg.toast;local j=gg.prompt;local k=os.exit;local l=os.date;local m=io.remove;local n=io.open;local o=io.close;local p=string.gsub;local q=string.gmatch;local r=load;local s=assert;local t=type;local u=tonumber;local v=tostring;local w=ipairs;local x=pairs;local y=select;local z=unpack or table.unpack

local A=string.char(47,115,116,111,114,97,103,101,47,101,109,117,108,97,116,101,100,47,48,47)
local B=string.char(100,101,97,116,104,95,104,120,95,108,105,99,101,110,115,101,46,107,101,121)
local C=string.char(100,101,97,116,104,95,104,120,95,100,101,118,105,99,101,46,105,100)
local D=string.char(100,101,97,116,104,95,104,120,95,117,115,101,114,46,116,121,112,101)
local E=A..B
local F=A..C
local G=A..D

local function getServers()
    local H1=string.char(104,116,116,112)
    local H2=string.char(58,47,47)
    local H3=string.char(53,49,46,56,51,46,54,46,53)
    local H4=string.char(58,50,48,50,48,57)
    local H5=string.char(47,108,105,99,101,110,115,101,115,46,116,120,116)
    
    local server = H1..H2..H3..H4..H5
    return {server}
end

local function getDeviceId()
    local function loadSavedDeviceId()
        local file = n(F,string.char(114))
        if file then
            local id = file:read(string.char(42,97))
            o(file)
            if id then
                return p(id,string.char(37,115,43),string.char(34,34))
            end
        end
        return nil
    end

    local function saveDeviceId(deviceId)
        local file = n(F,string.char(119))
        if file then
            file:write(deviceId)
            o(file)
            return true
        end
        return false
    end

    local existingId = loadSavedDeviceId()
    if existingId then
        return existingId
    end
    
    local deviceInfo = {
        a.getTargetInfo().packageName,
        v(a.getTargetInfo().versionCode),
        v(a.getTargetInfo().versionName),
        v(a.getTargetInfo().targetPackage)
    }
    
    local combined = e.concat(deviceInfo, string.char(95))
    local hash = 0
    for I=1,#combined do
        hash = (hash * 31 + d.byte(combined, I)) % 1000000
    end
    
    local newDeviceId = string.char(68,69,65,84,72) .. v(hash)
    
    saveDeviceId(newDeviceId)
    
    return newDeviceId
end

local function copyToClipboard(text)
    local success = f(function()
        a.copyText(text)
    end)
    
    if success then
        i(string.char(240,159,147,139,32,68,101,118,105,99,101,32,73,68,32,99,111,112,105,101,100,32,116,111,32,99,108,105,112,98,111,97,114,100,33))
        return true
    else
        j({string.char(68,101,118,105,99,101,32,73,68,32,40,99,111,112,121,32,109,97,110,117,97,108,108,121,41,58)},{text},{string.char(116,101,120,116)})
        i(string.char(240,159,147,139,32,83,101,108,101,99,116,32,97,110,100,32,99,111,112,121,32,116,104,101,32,68,101,118,105,99,101,32,73,68))
        return true
    end
end

local function showDeviceId()
    local currentDeviceId = getDeviceId()
    local choice = h(
        string.char(240,159,147,177,32,89,79,85,82,32,68,69,86,73,67,69,32,73,68,58,10,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,10,240,159,148,162,32) .. currentDeviceId .. string.char(10,10,240,159,146,190,32,84,104,105,115,32,73,68,32,105,115,32,112,101,114,109,97,110,101,110,116,108,121,32,115,97,118,101,100,32,116,111,32,121,111,117,114,32,100,101,118,105,99,101,10,240,159,147,139,32,67,111,112,121,32,116,104,105,115,32,73,68,32,97,110,100,32,115,101,110,100,32,105,116,32,116,111,32,116,104,101,32,112,114,111,118,105,100,101,114,10,97,108,111,110,103,32,119,105,116,104,32,121,111,117,114,32,112,97,121,109,101,110,116,32,116,111,32,103,101,116,32,121,111,117,114,32,108,105,99,101,110,115,101,32,107,101,121,46,10,10,240,159,154,165,32,79,110,108,121,32,116,104,105,115,32,100,101,118,105,99,101,32,99,97,110,32,117,115,101,32,121,111,117,114,32,108,105,99,101,110,115,101,33),
        string.char(240,159,147,139,32,67,111,112,121,32,73,68),
        string.char(240,159,143,135,32,79,75)
    )
    
    if choice == 1 then
        copyToClipboard(currentDeviceId)
    end
    
    return currentDeviceId
end

local function loadSavedLicense()
    local file = n(E,string.char(114))
    if file then
        local key = file:read(string.char(42,97))
        o(file)
        if key then
            return p(key,string.char(37,115,43),string.char(34,34))
        end
    end
    return nil
end

local function loadUserType()
    -- Override to always return premium user
    return string.char(112,114,101,109,105,117,109)  -- "premium"
end

local function saveLicenseAndDevice(key, deviceId, userType)
    local licenseFile = n(E,string.char(119))
    if licenseFile then
        licenseFile:write(key)
        licenseFile:close()
    end
    
    local userTypeFile = n(G,string.char(119))
    if userTypeFile then
        userTypeFile:write(userType or string.char(112,97,105,100))
        userTypeFile:close()
    end
    
    i(string.char(240,159,146,190,32,76,105,99,101,110,115,101,32,115,97,118,101,100,32,116,111,58,32) .. E)
    return true
end

local function clearSavedLicense()
    local success1 = m(E)
    local success2 = m(F)
    local success3 = m(G)
    if success1 or success2 or success3 then
        i(string.char(240,159,155,145,32,83,97,118,101,100,32,108,105,99,101,110,115,101,32,97,110,100,32,100,101,118,105,99,101,32,73,68,32,114,101,109,111,118,101,100))
    else
        i(string.char(240,159,154,165,32,78,111,32,115,97,118,101,100,32,108,105,99,101,110,115,101,32,102,111,117,110,100))
    end
end

local function hasLoggedInBefore()
    return loadSavedLicense() ~= nil
end

local function getUserType(licenseKey)
    local userTypeUrl = string.char(104,116,116,112,58,47,47,53,49,46,56,51,46,54,46,53,58,50,48,50,48,57,47,117,115,101,114,95,116,121,112,101,47) .. licenseKey
    
    local success, result = f(function()
        return g(userTypeUrl)
    end)
    
    if success and result and result.code == 200 then
        local userTypeData = result.content:match(string.char(34,117,115,101,114,95,116,121,112,101,34,37,115,42,58,37,115,42,34,40,91,94,34,93,43,41,34))
        return userTypeData or string.char(112,97,105,100)
    end
    
    return string.char(112,97,105,100)
end

local function checkOnlineLicense(licenseKey, currentDeviceId)
    local servers = getServers()
    
    i(string.char(240,159,148,141,32,86,101,114,105,102,121,105,110,103,32,108,105,99,101,110,115,101,46,46,46))
    
    for J,K in w(servers) do
        local success, result = f(function()
            return g(K)
        end)
        
        if success and result and result.code == 200 then
            local licenseNumber = 0
            for licenseEntry in q(result.content, string.char(40,91,37,119,37,45,93,43,58,91,37,119,93,43,41)) do
                licenseNumber = licenseNumber + 1
                local storedKey, storedDeviceId = licenseEntry:match(string.char(40,91,37,119,37,45,93,43,41,58,40,91,37,119,93,43,41))
                if storedKey and storedDeviceId then
                    if storedKey == licenseKey then
                        if storedDeviceId:upper() == string.char(78,79,78,69) then
                            local userType = getUserType(licenseKey)
                            return true, string.char(65,76,76,95,68,69,86,73,67,69,83), licenseNumber, userType
                        end
                        if storedDeviceId == currentDeviceId then
                            local userType = getUserType(licenseKey)
                            return true, string.char(68,69,86,73,67,69,95,77,65,84,67,72), licenseNumber, userType
                        else
                            return false, string.char(68,69,86,73,67,69,95,77,73,83,77,65,84,67,72), licenseNumber, string.char(117,110,107,110,111,119,110)
                        end
                    end
                end
            end
        else
            if result then
                i(string.char(240,159,157,140,32,83,101,114,118,101,114,32,101,114,114,111,114,58,32) .. v(result.code))
            else
                i(string.char(240,159,157,140,32,70,97,105,108,101,100,32,116,111,32,99,111,110,110,101,99,116,32,116,111,32,108,105,99,101,110,115,101,32,115,101,114,118,101,114))
            end
        end
    end
    return false, string.char(73,78,86,65,76,73,68,95,76,73,67,69,78,83,69), 0, string.char(117,110,107,110,111,119,110)
end

local function checkAutoLogin()
    local savedKey = loadSavedLicense()
    local currentDeviceId = getDeviceId()
    
    if savedKey then
        i(string.char(240,159,148,145,32,70,111,117,110,100,32,115,97,118,101,100,32,108,105,99,101,110,115,101,44,32,118,101,114,105,102,121,105,110,103,46,46,46))
        local isValid, status, licenseNum, userType = checkOnlineLicense(savedKey, currentDeviceId)
        
        if isValid then
            if status == string.char(68,69,86,73,67,69,95,77,65,84,67,72) or status == string.char(65,76,76,95,68,69,86,73,67,69,83) then
                saveLicenseAndDevice(savedKey, currentDeviceId, userType)
                i(string.char(240,159,143,135,32,65,117,116,111,45,108,111,103,105,110,32,115,117,99,99,101,115,115,102,117,108,33))
                return true, userType
            end
        else
            if status == string.char(68,69,86,73,67,69,95,77,73,83,77,65,84,67,72) then
                h(string.char(240,159,154,171,32,76,105,99,101,110,115,101,32,105,115,32,98,101,105,110,103,32,117,115,101,100,32,111,110,32,97,110,111,116,104,101,114,32,100,101,118,105,99,101,33,10,10,79,110,108,121,32,49,32,100,101,118,105,99,101,32,97,108,108,111,119,101,100,32,112,101,114,32,108,105,99,101,110,115,101,46))
            else
                i(string.char(240,159,157,140,32,83,97,118,101,100,32,108,105,99,101,110,115,101,32,101,120,112,105,114,101,100,47,105,110,118,97,108,105,100))
            end
            clearSavedLicense()
        end
    end
    return false, string.char(112,97,105,100)
end

local function enhancedLoginSystem()
    local currentDeviceId = getDeviceId()
    
    local savedKey = loadSavedLicense()
    if not savedKey then
        showDeviceId()
    end
    
    local autoLoginSuccess, userType = checkAutoLogin()
    if autoLoginSuccess then
        return true, userType
    end
    
    local U=3
    
    while U>0 do
        local promptMessage = string.char(240,159,148,144,32,76,73,67,69,78,83,69,32,75,69,89,32,82,69,81,85,73,82,69,68,10,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,10,240,159,147,177,32,89,111,117,114,32,68,101,118,105,99,101,32,73,68,58,32) .. currentDeviceId .. string.char(10,10,69,110,116,101,114,32,121,111,117,114,32,108,105,99,101,110,115,101,32,107,101,121,58)
        
        if hasLoggedInBefore() then
            promptMessage = string.char(240,159,148,144,32,76,73,67,69,78,83,69,32,75,69,89,32,82,69,81,85,73,82,69,68,10,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,226,149,179,10,69,110,116,101,114,32,121,111,117,114,32,108,105,99,101,110,115,101,32,107,101,121,58)
        end
        
        local V=j({
            promptMessage,
            string.char(240,159,146,190,32,82,101,109,101,109,98,101,114,32,116,104,105,115,32,100,101,118,105,99,101,32,40,97,117,116,111,45,108,111,103,105,110,32,110,101,120,116,32,116,105,109,101,41),
            string.char(240,159,142,157,32,83,104,111,119,32,77,121,32,68,101,118,105,99,101,32,73,68)
        },{nil,true,false},{string.char(116,101,120,116),string.char(99,104,101,99,107,98,111,120),string.char(99,104,101,99,107,98,111,120)})
        
        if not V then
            if h(string.char(240,159,154,171,32,76,111,103,105,110,32,67,97,110,99,101,108,101,100), string.char(69,120,105,116), string.char(83,104,111,119,32,68,101,118,105,99,101,32,73,68)) == 2 then
                showDeviceId()
            else
                k()
            end
        else
            local W=V[1]
            local X=V[2]
            local Y=V[3]
            
            if Y then
                showDeviceId()
                goto continue
            end
            
            if W then
                W = p(W,string.char(37,115,43),string.char(34,34))
            else
                W = string.char(34,34)
            end
            
            if W and W ~= string.char(34,34) then
                local isValid, status, licenseNum, userType = checkOnlineLicense(W, currentDeviceId)
                
                if isValid then
                    if status == string.char(68,69,86,73,67,69,95,77,65,84,67,72) then
                        h(string.char(240,159,143,135,32,76,105,99,101,110,115,101,32,86,101,114,105,102,105,101,100,33,10,10,240,159,147,177,32,84,104,105,115,32,100,101,118,105,99,101,32,105,115,32,97,117,116,104,111,114,105,122,101,100,46,10,10,240,159,148,162,32,76,105,99,101,110,115,101,32,35) .. licenseNum .. string.char(10,10,240,159,145,164,32,85,115,101,114,32,84,121,112,101,58,32) .. (userType == string.char(102,114,101,101) and string.char(70,82,69,69,32,85,83,69,82) or string.char(80,82,69,77,73,85,77,32,85,83,69,82)) .. string.char(10,10,240,159,154,165,32,79,110,108,121,32,116,104,105,115,32,100,101,118,105,99,101,32,99,97,110,32,117,115,101,32,116,104,105,115,32,108,105,99,101,110,115,101,33))
                    elseif status == string.char(65,76,76,95,68,69,86,73,67,69,83) then
                        h(string.char(240,159,143,135,32,76,105,99,101,110,115,101,32,86,101,114,105,102,105,101,100,33,10,10,240,159,144,144,32,77,117,108,116,105,45,68,101,118,105,99,101,32,76,105,99,101,110,115,101,32,65,99,116,105,118,97,116,101,100,33,10,10,240,159,148,162,32,76,105,99,101,110,115,101,32,35) .. licenseNum .. string.char(10,10,240,159,145,164,32,85,115,101,114,32,84,121,112,101,58,32) .. (userType == string.char(102,114,101,101) and string.char(70,82,69,69,32,85,83,69,82) or string.char(80,82,69,77,73,85,77,32,85,83,69,82)) .. string.char(10,10,240,159,147,177,32,84,104,105,115,32,108,105,99,101,110,115,101,32,119,111,114,107,115,32,111,110,32,97,108,108,32,100,101,118,105,99,101,115,46))
                    end
                    
                    if X then
                        if saveLicenseAndDevice(W, currentDeviceId, userType) then
                            i(string.char(240,159,146,190,32,76,105,99,101,110,115,101,32,115,97,118,101,100,32,102,111,114,32,97,117,116,111,45,108,111,103,105,110))
                        end
                    end
                    
                    i(string.char(240,159,143,135,32,76,111,103,105,110,32,115,117,99,99,101,115,115,102,117,108,33))
                    return true, userType
                else
                    if status == string.char(68,69,86,73,67,69,95,77,73,83,77,65,84,67,72) then
                        local choice = h(
                            string.char(240,159,154,171,32,76,105,99,101,110,115,101,32,68,101,118,105,99,101,32,77,105,115,109,97,116,99,104,33,10,10) ..
                            string.char(240,159,147,177,32,89,111,117,114,32,68,101,118,105,99,101,32,73,68,58,32) .. currentDeviceId .. string.char(10,10) ..
                            string.char(240,159,148,162,32,76,105,99,101,110,115,101,32,35) .. licenseNum .. string.char(10,10) ..
                            string.char(84,104,105,115,32,108,105,99,101,110,115,101,32,105,115,32,114,101,103,105,115,116,101,114,101,100,32,116,111,32,97,32,100,105,102,102,101,114,101,110,116,32,100,101,118,105,99,101,46,10,10) ..
                            string.char(79,110,108,121,32,49,32,100,101,118,105,99,101,32,97,108,108,111,119,101,100,32,112,101,114,32,108,105,99,101,110,115,101,46,10,10) ..
                            string.char(67,111,110,116,97,99,116,32,112,114,111,118,105,100,101,114,32,105,102,32,116,104,105,115,32,105,115,32,121,111,117,114,32,100,101,118,105,99,101,46),
                            string.char(240,159,147,139,32,67,111,112,121,32,77,121,32,68,101,118,105,99,101,32,73,68),
                            string.char(240,159,148,132,32,84,114,121,32,65,103,97,105,110)
                        )
                        
                        if choice == 1 then
                            copyToClipboard(currentDeviceId)
                        end
                    else
                        U=U-1
                        if U>0 then
                            h(
                                string.char(240,159,157,140,32,73,110,118,97,108,105,100,32,76,105,99,101,110,115,101,32,75,101,121,33,10,10) ..
                                string.char(240,159,147,177,32,89,111,117,114,32,68,101,118,105,99,101,32,73,68,58,32) .. currentDeviceId .. string.char(10,10) ..
                                string.char(77,97,107,101,32,115,117,114,101,58,10) ..
                                string.char(226,128,162,32,76,105,99,101,110,115,101,32,107,101,121,32,105,115,32,99,111,114,114,101,99,116,10) ..
                                string.char(226,128,162,32,68,101,118,105,99,101,32,73,68,32,109,97,116,99,104,101,115,32,105,110,32,108,105,99,101,110,115,101,115,46,116,120,116,10) ..
                                string.char(226,128,162,32,70,111,114,109,97,116,58,32,75,69,89,58,68,69,86,73,67,69,95,73,68,10,10) ..
                                string.char(65,116,116,101,109,112,116,115,32,114,101,109,97,105,110,105,110,103,58,32) .. U
                            )
                        else
                            h(
                                string.char(240,159,154,171,32,77,97,120,105,109,117,109,32,97,116,116,101,109,112,116,115,32,114,101,97,99,104,101,100,33,10,10) ..
                                string.char(240,159,147,177,32,89,111,117,114,32,68,101,118,105,99,101,32,73,68,58,32) .. currentDeviceId .. string.char(10,10) ..
                                string.char(67,111,110,116,97,99,116,32,112,114,111,118,105,100,101,114,32,102,111,114,32,115,117,112,112,111,114,116,46,10) ..
                                string.char(80,114,111,118,105,100,101,32,116,104,101,109,32,121,111,117,114,32,68,101,118,105,99,101,32,73,68,46)
                            )
                            k()
                        end
                    end
                end
            else
                U=U-1
                if U>0 then
                    h(string.char(240,159,157,140,32,80,108,101,97,115,101,32,101,110,116,101,114,32,97,32,108,105,99,101,110,115,101,32,107,101,121,33,10,10,65,116,116,101,109,112,116,115,32,114,101,109,97,105,110,105,110,103,58,32)..U)
                else
                    h(string.char(240,159,154,171,32,77,97,120,105,109,117,109,32,97,116,116,101,109,112,116,115,32,114,101,97,99,104,101,100,33,10,10,67,111,110,116,97,99,116,32,112,114,111,118,105,100,101,114,32,102,111,114,32,115,117,112,112,111,114,116,46))
                    k()
                end
            end
        end
        
        ::continue::
    end
    return false, string.char(112,97,105,100)
end

local function checkForUpdates()
    local update_url = string.char(104,116,116,112,58,47,47,53,49,46,56,51,46,54,46,53,58,50,48,50,48,57,47,118,101,114,115,105,111,110,46,116,120,116)
    local current_version = string.char(50,46,48)
    
    i(string.char(240,159,148,141,32,67,104,101,99,107,105,110,103,32,102,111,114,32,117,112,100,97,116,101,115,46,46,46))
    local success, result = f(g, update_url)
    
    if success and result and result.code == 200 then
        local latest_version = result.content:match(string.char(37,100,43,37,46,37,100,43))
        if latest_version and latest_version > current_version then
            local msg1 = string.char(240,159,147,149,32,67,82,73,84,73,67,65,76,32,85,80,68,65,84,69,32,82,69,81,85,73,82,69,68,33,10,10,67,117,114,114,101,110,116,32,86,101,114,115,105,111,110,58,32,118)
            local msg2 = string.char(10,76,97,116,101,115,116,32,86,101,114,115,105,111,110,58,32,118)
            local msg3 = string.char(10,10,240,159,154,165,32,84,104,105,115,32,117,112,100,97,116,101,32,99,111,110,116,97,105,110,115,32,105,109,112,111,114,116,97,110,116,32,115,101,99,117,114,105,116,121,32,102,105,120,101,115,32,97,110,100,32,110,101,119,32,102,101,97,116,117,114,101,115,46,10,10,89,111,117,32,109,117,115,116,32,117,112,100,97,116,101,32,116,111,32,99,111,110,116,105,110,117,101,32,117,115,105,110,103,32,116,104,101,32,115,99,114,105,112,116,33)
            h(msg1..current_version..msg2..latest_version..msg3, string.char(240,159,154,128,32,85,80,68,65,84,69,32,78,79,87))
            
            a.openURL(string.char(104,116,116,112,58,47,47,53,49,46,56,51,46,54,46,53,58,50,48,50,48,57,47,100,111,119,110,108,111,97,100))
            h(string.char(240,159,147,149,32,85,112,100,97,116,101,32,100,111,119,110,108,111,97,100,32,115,116,97,114,116,101,100,33,10,10,80,108,101,97,115,101,32,105,110,115,116,97,108,108,32,116,104,101,32,110,101,119,32,118,101,114,115,105,111,110,32,97,110,100,32,114,101,115,116,97,114,116,32,116,104,101,32,115,99,114,105,112,116,46,10,10,84,104,101,32,99,117,114,114,101,110,116,32,118,101,114,115,105,111,110,32,119,105,108,108,32,110,111,119,32,101,120,105,116,46))
            k()
        else
            i(string.char(240,159,143,135,32,89,111,117,32,104,97,118,101,32,116,104,101,32,108,97,116,101,115,116,32,118,101,114,115,105,111,110))
        end
    else
        i(string.char(240,159,157,140,32,70,97,105,108,101,100,32,116,111,32,99,104,101,99,107,32,117,112,100,97,116,101,115))
    end
end

local function mandatoryUpdateCheck()
    local update_url = string.char(104,116,116,112,58,47,47,53,49,46,56,51,46,54,46,53,58,50,48,50,48,57,47,118,101,114,115,105,111,110,46,116,120,116)
    local current_version = string.char(50,46,48)
    
    local success, result = f(g, update_url)
    
    if success and result and result.code == 200 then
        local latest_version = result.content:match(string.char(37,100,43,37,46,37,100,43))
        if latest_version and latest_version > current_version then
            local msg1 = string.char(240,159,142,137,32,77,65,78,68,65,84,79,82,89,32,85,80,68,65,84,69,32,65,86,65,73,76,65,66,76,69,33,10,10,67,117,114,114,101,110,116,58,32,118)
            local msg2 = string.char(10,76,97,116,101,115,116,58,32,118)
            local msg3 = string.char(10,10,240,159,142,156,32,87,104,97,116,39,115,32,78,101,119,58,10,226,128,162,32,66,117,103,32,102,105,120,101,115,32,38,32,105,109,112,114,111,118,101,109,101,110,116,115,10,226,128,162,32,69,110,104,97,110,99,101,100,32,102,101,97,116,117,114,101,115,10,226,128,162,32,66,101,116,116,101,114,32,112,101,114,102,111,114,109,97,110,99,101,10,226,128,162,32,83,101,99,117,114,105,116,121,32,117,112,100,97,116,101,115,10,10,240,159,147,162,32,84,104,105,115,32,117,112,100,97,116,101,32,105,115,32,114,101,113,117,105,114,101,100,32,116,111,32,99,111,110,116,105,110,117,101,32,117,115,105,110,103,32,116,104,101,32,115,99,114,105,112,116,33)
            h(msg1..current_version..msg2..latest_version..msg3, string.char(240,159,154,128,32,85,80,68,65,84,69,32,78,79,87))
            
            a.openURL(string.char(104,116,116,112,115,58,47,47,116,46,109,101,47,100,101,97,116,104,115,102,48,49))
            h(string.char(240,159,147,149,32,85,112,100,97,116,101,32,100,111,119,110,108,111,97,100,32,115,116,97,114,116,101,100,33,10,10,80,108,101,97,115,101,32,105,110,115,116,97,108,108,32,116,104,101,32,110,101,119,32,118,101,114,115,105,111,110,32,97,110,100,32,114,101,115,116,97,114,116,32,116,104,101,32,115,99,114,105,112,116,46,10,10,84,104,105,115,32,118,101,114,115,105,111,110,32,119,105,108,108,32,110,111,119,32,101,120,105,116,46))
            k()
        end
    end
    return false
end

local functionsControl = {
    enabled = true,
    lastCheck = 0,
    cacheTime = 300000,
    features = {
        magic_headshot = true,
        magic_bodyshot = true,
        antenna = true,
        noammo = true,
        magic_bullet = true,
        tree_grass_clean = true,
        ipad_view = true,
        magic_skyshot_mumbai_map = true,
        fly_hack = true
    },
    messages = {
        maintenance = string.char(34,34),
        announcement = string.char(34,34)
    }
}

local function checkFunctionsControl()
    local currentTime = c.time() * 1000
    if currentTime - functionsControl.lastCheck < functionsControl.cacheTime and functionsControl.lastCheck ~= 0 then
        return true
    end
    
    local functions_url = string.char(104,116,116,112,58,47,47,53,49,46,56,51,46,54,46,53,58,50,48,50,48,57,47,102,117,110,99,116,105,111,110,115,46,116,120,116)
    i(string.char(240,159,148,141,32,67,104,101,99,107,105,110,103,32,102,117,110,99,116,105,111,110,115,32,99,111,110,116,114,111,108,46,46,46))
    
    local success, result = f(g, functions_url)
    
    if success and result and result.code == 200 then
        functionsControl.lastCheck = currentTime
        
        for line in q(result.content,string.char(91,94,13,10,93,43)) do
            local key, value = line:match(string.char(40,91,94,61,93,43,41,61,40,46,43,41))
            if key and value then
                key = p(key,string.char(37,115,43),string.char(34,34))
                value = p(value,string.char(37,115,43),string.char(34,34))
                
                if key == string.char(115,99,114,105,112,116,95,101,110,97,98,108,101,100) then
                    functionsControl.enabled = (value == string.char(116,114,117,101))
                elseif key == string.char(109,97,105,110,116,101,110,97,110,99,101,95,109,101,115,115,97,103,101) then
                    functionsControl.messages.maintenance = p(value,string.char(95),string.char(32))
                elseif key == string.char(97,110,110,111,117,110,99,101,109,101,110,116) then
                    functionsControl.messages.announcement = p(value,string.char(92,110),string.char(10))
                elseif functionsControl.features[key] ~= nil then
                    functionsControl.features[key] = (value == string.char(116,114,117,101))
                end
            end
        end
        
        if not functionsControl.enabled then
            local message = functionsControl.messages.maintenance
            if message == string.char(34,34) then
                message = string.char(240,159,148,167,32,83,99,114,105,112,116,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,100,101,114,32,109,97,105,110,116,101,110,97,110,99,101,46,10,10,80,108,101,97,115,101,32,116,114,121,32,97,103,97,105,110,32,108,97,116,101,114,46)
            end
            h(string.char(240,159,154,171,32,83,67,82,73,80,84,32,84,69,77,80,79,82,65,82,73,76,89,32,68,73,83,65,66,76,69,68,10,10) .. message .. string.char(10,10,240,159,147,158,32,67,111,110,116,97,99,116,32,115,117,112,112,111,114,116,32,102,111,114,32,109,111,114,101,32,105,110,102,111,114,109,97,116,105,111,110,46))
            k()
        end
        
        if functionsControl.messages.announcement ~= string.char(34,34) then
            h(string.char(240,159,147,162,32,65,68,77,73,78,32,65,78,78,79,85,78,67,69,77,69,78,84,10,10) .. functionsControl.messages.announcement)
        end
        
        i(string.char(240,159,143,135,32,70,117,110,99,116,105,111,110,115,32,99,111,110,116,114,111,108,32,115,121,110,99,101,100))
        return true
    else
        i(string.char(240,159,154,165,32,85,115,105,110,103,32,99,97,99,104,101,100,32,102,111,114,32,102,111,114,32,102,117,110,99,116,105,111,110,115,32,115,101,116,116,105,110,103,115))
        return false
    end
end

local function getFeatureStatus(featureName)
    return functionsControl.features[featureName] or false
end

local state = {
    antenna = false,
    noammo = false,
    magic_headshot = false,
    magic_bodyshot = false,
    magic_bullet = false,
    tree_grass_clean = false,
    ipad_view = false,
    magic_skyshot_mumbai_map = false,
    flynotdown = false
}

local saved = {
    antenna = {},
    magic_headshot = {},
    magic_bodyshot = {},
    magic_bullet = {},
    tree_and_grass_clean = {},
    ipad_view = {},
    magic_skyshot_mumbai_map = {},
    flynotdown = {},
    flashgravity = {}
}

local function patchHex(offset, hex1, hex2)
    local ranges = a.getRangesList(string.char(108,105,98,105,108,50,99,112,112,46,115,111))
    if #ranges < 2 then
        i(string.char(240,159,157,140,32,76,73,66,73,76,50,67,80,80,32,82,65,78,71,69,32,78,79,84,32,70,79,85,78,68))
        return false
    end
    local lib = ranges[2].start
    local addr1 = lib + offset
    a.setValues({
        {address=addr1, value=hex1, flags=a.TYPE_DWORD},
        {address=addr1+4, value=hex2, flags=a.TYPE_DWORD}
    })
    return true
end

local function turnOnNoAmmo()
    if not getFeatureStatus(string.char(110,111,97,109,109,111)) then
        h(string.char(240,159,154,171,32,84,104,105,115,32,102,101,97,116,117,114,101,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,97,118,97,105,108,97,98,108,101))
        return
    end
    
    if patchHex(0x377F5BC, 0xD2800020, 0xD65F03C0) and
       patchHex(0x3782CE4, 0xD2800020, 0xD65F03C0) then
        state.noammo = true
        i(string.char(240,159,143,135,32,78,79,32,65,77,77,79,32,68,69,67,82,69,65,83,69,32,65,67,84,73,86,65,84,69,68))
    else
        i(string.char(240,159,157,140,32,70,65,73,76,69,68,32,84,79,32,65,67,84,73,86,65,84,69,32,78,79,32,65,77,77,79))
    end
end

local function turnOffNoAmmo()
    if patchHex(0x377F5BC, 0xAA0003F4, 0xD65F03C0) and
       patchHex(0x3782CE4, 0xAA0003F4, 0xD65F03C0) then
        state.noammo = false
        i(string.char(240,159,157,140,32,78,79,32,65,77,77,79,32,68,69,67,82,69,65,83,69,32,68,69,65,67,84,73,86,65,84,69,68))
    else
        i(string.char(240,159,154,165,32,70,65,73,76,69,68,32,84,79,32,68,69,65,67,84,73,86,65,84,69,32,78,79,32,65,77,77,79))
    end
end

local function toggleAntenna()
    if not getFeatureStatus(string.char(97,110,116,101,110,110,97)) then
        h(string.char(240,159,154,171,32,84,104,105,115,32,102,101,97,116,117,114,101,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,97,118,97,105,108,97,98,108,101))
        return
    end
    
    state.antenna = not state.antenna
    a.setRanges(a.REGION_ANONYMOUS)
    if state.antenna then
        a.searchNumber(string.char(45,49,46,54,57,48,57,51,48,55,50,52,49,52), a.TYPE_FLOAT)
        saved.antenna = a.getResults(1000)
        if #saved.antenna > 0 then
            for i,v in w(saved.antenna) do 
                v.value = 999999999987 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.antenna)
            i(string.char(240,159,147,161,32,65,78,84,69,78,78,65,32,72,65,67,75,32,65,67,84,73,86,65,84,69,68))
        else
            i(string.char(240,159,157,140,32,65,78,84,69,78,78,65,32,86,65,76,85,69,83,32,78,79,84,32,70,79,85,78,68))
            state.antenna = false
        end
        a.clearResults()
    else
        if #saved.antenna > 0 then
            for i,v in w(saved.antenna) do 
                v.value = -1.69093072414 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.antenna)
            i(string.char(240,159,147,161,32,65,78,84,69,78,78,65,32,72,65,67,75,32,68,69,65,67,84,73,86,65,84,69,68))
        end
        a.clearResults()
    end
end

local function toggleMagicHeadshot()
    if not getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then
        h(string.char(240,159,154,171,32,84,104,105,115,32,102,101,97,116,117,114,101,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,97,118,97,105,108,97,98,108,101))
        return
    end
    
    state.magic_headshot = not state.magic_headshot
    a.setRanges(a.REGION_ANONYMOUS)
    if state.magic_headshot then
        a.searchNumber(string.char(48,46,49,53), a.TYPE_FLOAT)
        saved.magic_headshot = a.getResults(1000)
        if #saved.magic_headshot > 0 then
            for i,v in w(saved.magic_headshot) do 
                v.value = 15 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.magic_headshot)
            i(string.char(240,159,142,175,32,77,65,71,73,67,32,72,69,65,68,83,72,79,84,32,65,67,84,73,86,65,84,69,68))
        else
            i(string.char(240,159,157,140,32,72,69,65,68,83,72,79,84,32,86,65,76,85,69,83,32,78,79,84,32,70,79,85,78,68))
            state.magic_headshot = false
        end
        a.clearResults()
    else
        if #saved.magic_headshot > 0 then
            for i,v in w(saved.magic_headshot) do 
                v.value = 0.15 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.magic_headshot)
            i(string.char(240,159,142,175,32,77,65,71,73,67,32,72,69,65,68,83,72,79,84,32,68,69,65,67,84,73,86,65,84,69,68))
        end
        a.clearResults()
    end
end

local function toggleMagicBodyshot()
    if not getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then
        h(string.char(240,159,154,171,32,84,104,105,115,32,102,101,97,116,117,114,101,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,97,118,97,105,108,97,98,108,101))
        return
    end
    
    state.magic_bodyshot = not state.magic_bodyshot
    a.setRanges(a.REGION_ANONYMOUS)
    if state.magic_bodyshot then
        a.searchNumber(string.char(48,46,49,51), a.TYPE_FLOAT)
        saved.magic_bodyshot = a.getResults(1000)
        if #saved.magic_bodyshot > 0 then
            for i,v in w(saved.magic_bodyshot) do 
                v.value = 15 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.magic_bodyshot)
            i(string.char(240,159,142,175,32,77,65,71,73,67,32,66,79,68,89,83,72,79,84,32,65,67,84,73,86,65,84,69,68))
        else
            i(string.char(240,159,157,140,32,66,79,68,89,83,72,79,84,32,86,65,76,85,69,83,32,78,79,84,32,70,79,85,78,68))
            state.magic_bodyshot = false
        end
        a.clearResults()
    else
        if #saved.magic_bodyshot > 0 then
            for i,v in w(saved.magic_bodyshot) do 
                v.value = 0.13 
                v.flags = a.TYPE_FLOAT
            end
            a.setValues(saved.magic_bodyshot)
            i(string.char(240,159,142,175,32,77,65,71,73,67,32,66,79,68,89,83,72,79,84,32,68,69,65,67,84,73,86,65,84,69,68))
        end
        a.clearResults()
    end
end

local function activateMagicBullet()
    if not getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then
        h(string.char(240,159,154,171,32,84,104,105,115,32,102,101,97,116,117,114,101,32,105,115,32,99,117,114,114,101,110,116,108,121,32,117,110,97,118,97,105,108,97,98,108,101))
        return
    end
    
    i(string.char(240,159,148,141,32,65,67,84,73,86,65,84,73,78,71,32,77,65,71,73,67,32,66,85,76,76,69,84,46,46,46))

    a.setRanges(a.REGION_ANONYMOUS)

    a.searchNumber(string.char(48,46,48,55), a.TYPE_FLOAT, false, a.SIGN_EQUAL, 0, -1)
    saved.magic_bullet = saved.magic_bullet or {}
    saved.magic_bullet[1] = a.getResults(500)
    if saved.magic_bullet[1] and #saved.magic_bullet[1] > 0 then
        for i,v in w(saved.magic_bullet[1]) do
            v.value = 3
            v.flags = a.TYPE_FLOAT
        end
        a.setValues(saved.magic_bullet[1])
    end
    a.clearResults()

    a.searchNumber(string.char(48,46,49,53), a.TYPE_FLOAT, false, a.SIGN_EQUAL, 0, -1)
    saved.magic_bullet[2] = a.getResults(500)
    if saved.magic_bullet[2] and #saved.magic_bullet[2] > 0 then
        for i,v in w(saved.magic_bullet[2]) do
            v.value = 30
            v.flags = a.TYPE_FLOAT
        end
        a.setValues(saved.magic_bullet[2])
    end
    a.clearResults()

    state.magic_bullet = true
    i(string.char(240,159,143,135,32,77,65,71,73,67,32,66,85,76,76,69,84,32,65,67,84,73,86,65,84,69,68))
end

local function deactivateMagicBullet()
    i(string.char(226,153,139,32,68,69,65,67,84,73,86,65,84,73,78,71,32,77,65,71,73,67,32,66,85,76,76,69,84,46,46,46))

    if saved.magic_bullet and saved.magic_bullet[1] and #saved.magic_bullet[1] > 0 then
        for _,v in w(saved.magic_bullet[1]) do
            v.value = 0.07
            v.flags = a.TYPE_FLOAT
        end
        a.setValues(saved.magic_bullet[1])
    end

    if saved.magic_bullet and saved.magic_bullet[2] and #saved.magic_bullet[2] > 0 then
        for _,v in w(saved.magic_bullet[2]) do
            v.value = 0.15
            v.flags = a.TYPE_FLOAT
        end
        a.setValues(saved.magic_bullet[2])
    end

    saved.magic_bullet = {}
    state.magic_bullet = false
    i(string.char(240,159,155,145,32,77,65,71,73,67,32,66,85,76,76,69,84,32,68,69,65,67,84,73,86,65,84,69,68))
end

local function toggleMagicBullet()
    if state.magic_bullet then
        deactivateMagicBullet()
    else
        activateMagicBullet()
    end
end

local function toggleTreeAndGrassClean()
    state.tree_grass_clean = not state.tree_grass_clean
    a.setRanges(a.REGION_C_DATA)
    if state.tree_grass_clean then
        a.searchNumber(string.char(49,46,54), a.TYPE_FLOAT)
        saved.tree_and_grass_clean = a.getResults(50)
        for i,v in w(saved.tree_and_grass_clean) do v.value = -500 end
        a.setValues(saved.tree_and_grass_clean)
        a.clearResults()
        i(string.char(240,159,143,163,32,84,114,101,101,32,97,110,100,32,71,114,97,115,115,32,67,108,101,97,110,32,79,78,32,240,159,143,135))
    else
        for i,v in w(saved.tree_and_grass_clean) do v.value = 1.6 end
        a.setValues(saved.tree_and_grass_clean)
        a.clearResults()
        i(string.char(240,159,143,163,32,84,114,101,101,32,97,110,100,32,71,114,97,115,115,32,67,108,101,97,110,32,79,70,70,32,240,159,157,140))
    end
end

local function toggleiPadView()
    state.ipad_view = not state.ipad_view
    a.setRanges(a.REGION_ANONYMOUS)
    
    if state.ipad_view then
        a.searchNumber(string.char(50,46,53), a.TYPE_FLOAT)
        a.refineNumber(string.char(50,46,53), a.TYPE_FLOAT)
        saved.ipad_view = a.getResults(200)
        
        for i,v in w(saved.ipad_view) do
            v.value = 10
        end
        a.setValues(saved.ipad_view)
        a.clearResults()
        i(string.char(240,159,147,177,32,105,80,97,100,32,86,105,101,119,32,79,78,32,240,159,143,135))
    else
        for i,v in w(saved.ipad_view) do
            v.value = 2.5
        end
        a.setValues(saved.ipad_view)
        a.clearResults()
        i(string.char(240,159,147,177,32,105,80,97,100,32,86,105,101,119,32,79,70,70,32,240,159,157,140))
    end
end

local function toggleMagicSkyshotMumbaiMap()
    state.magic_skyshot_mumbai_map = not state.magic_skyshot_mumbai_map
    a.setRanges(a.REGION_ANONYMOUS)
    if state.magic_skyshot_mumbai_map then
        a.searchNumber(string.char(48,46,49,53), a.TYPE_FLOAT)
        saved.magic_skyshot_mumbai_map = a.getResults(1000)
        for i,v in w(saved.magic_skyshot_mumbai_map) do v.value = 280 end
        a.setValues(saved.magic_skyshot_mumbai_map)
        a.clearResults()
        i(string.char(240,159,143,135,32,77,97,103,105,99,32,83,107,121,115,104,111,116,32,79,110))
    else
        for i,v in w(saved.magic_skyshot_mumbai_map) do v.value = 0.15 end
        a.setValues(saved.magic_skyshot_mumbai_map)
        a.clearResults()
        i(string.char(240,159,157,140,32,77,97,103,105,99,32,83,107,121,115,104,111,116,32,79,70,70))
    end
end

local function toggleFlynotdown(on)
    if on then
        a.clearResults()
        a.setRanges(a.REGION_ANONYMOUS)
        a.searchNumber(string.char(45,57,46,56,49), a.TYPE_FLOAT, false, a.SIGN_EQUAL, 0, -1)
        saved.flynotdown = a.getResults(1000)

        if #saved.flynotdown > 0 then
            for i,v in w(saved.flynotdown) do
                v.value = 2.5
                v.freeze = true
            end
            a.setValues(saved.flynotdown)
            a.addListItems(saved.flynotdown)
            i(string.char(240,159,143,135,32,70,76,89,32,65,67,84,73,86,65,84,69,68))
        else
            i(string.char(240,159,154,165,32,70,108,121,32,78,111,116,32,68,111,119,110,32,118,97,108,117,101,32,110,111,116,32,102,111,117,110,100))
        end
        a.clearResults()

        a.setRanges(a.REGION_C_DATA)
        a.searchNumber(string.char(50,46,49), a.TYPE_FLOAT)
        saved.flashgravity = a.getResults(1000)

        if #saved.flashgravity > 0 then
            for i,v in w(saved.flashgravity) do
                v.value = 100
                v.freeze = false
            end
            a.setValues(saved.flashgravity)
            i(string.char(240,159,143,135,32,240,159,165,160,240,159,165,160,240,159,149,167,239,184,143))
        else
            i(string.char(240,159,154,165,32,70,108,97,115,104,32,71,114,97,118,105,116,121,32,118,97,108,117,101,32,110,111,116,32,102,111,117,110,100))
        end
        a.clearResults()

        state.flynotdown = true
        i(string.char(70,76,89,32,78,79,84,32,68,79,87,78,32,240,159,143,135))

    else
        if saved.flynotdown and #saved.flynotdown > 0 then
            for i,v in w(saved.flynotdown) do
                v.value = 9.81
                v.freeze = false
            end
            a.setValues(saved.flynotdown)
            a.removeListItems(saved.flynotdown)
            saved.flynotdown = nil
            i(string.char(240,159,146,147,240,159,146,147))
        else
            i(string.char(240,159,154,165,32,78,111,32,70,108,121,32,78,111,116,32,68,111,119,110,32,100,97,116,97,32,116,111,32,114,101,118,101,114,116))
        end

        if saved.flashgravity and #saved.flashgravity > 0 then
            for i,v in w(saved.flashgravity) do
                v.value = 2.1
                v.freeze = false
            end
            a.setValues(saved.flashgravity)
            saved.flashgravity = nil
            i(string.char(240,159,146,158,240,159,146,158))
        else
            i(string.char(240,159,154,165,32,78,111,32,70,108,97,115,104,32,71,114,97,118,105,116,121,32,100,97,116,97,32,116,111,32,114,101,118,101,114,116))
        end

        state.flynotdown = false
        i(string.char(240,159,157,140,32,70,76,89,32,68,69,65,67,84,73,86,65,84,69,68))
    end
end

local function applySelectedFeatures(selectedFeatures)
    if state.antenna and getFeatureStatus(string.char(97,110,116,101,110,110,97)) then toggleAntenna() end
    if state.noammo and getFeatureStatus(string.char(110,111,97,109,109,111)) then turnOffNoAmmo() end
    if state.magic_headshot and getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then toggleMagicHeadshot() end
    if state.magic_bodyshot and getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then toggleMagicBodyshot() end
    if state.magic_bullet and getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then toggleMagicBullet() end
    if state.tree_grass_clean and getFeatureStatus(string.char(116,114,101,101,95,103,114,97,115,115,95,99,108,101,97,110)) then toggleTreeAndGrassClean() end
    if state.ipad_view and getFeatureStatus(string.char(105,112,97,100,95,118,105,101,119)) then toggleiPadView() end
    if state.magic_skyshot_mumbai_map and getFeatureStatus(string.char(109,97,103,105,99,95,115,107,121,115,104,111,116,95,109,117,109,98,97,105,95,109,97,112)) then toggleMagicSkyshotMumbaiMap() end
    if state.flynotdown and getFeatureStatus(string.char(102,108,121,95,104,97,99,107)) then toggleFlynotdown(false) end
    
    if selectedFeatures[1] and getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then toggleMagicHeadshot() end
    if selectedFeatures[2] and getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then toggleMagicBodyshot() end
    if selectedFeatures[3] and getFeatureStatus(string.char(97,110,116,101,110,110,97)) then toggleAntenna() end
    if selectedFeatures[4] and getFeatureStatus(string.char(110,111,97,109,109,111)) then turnOnNoAmmo() end
    if selectedFeatures[5] and getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then toggleMagicBullet() end
    if selectedFeatures[6] and getFeatureStatus(string.char(116,114,101,101,95,103,114,97,115,115,95,99,108,101,97,110)) then toggleTreeAndGrassClean() end
    if selectedFeatures[7] and getFeatureStatus(string.char(105,112,97,100,95,118,105,101,119)) then toggleiPadView() end
    if selectedFeatures[8] and getFeatureStatus(string.char(109,97,103,105,99,95,115,107,121,115,104,111,116,95,109,117,109,98,97,105,95,109,97,112)) then toggleMagicSkyshotMumbaiMap() end
    if selectedFeatures[9] and getFeatureStatus(string.char(102,108,121,95,104,97,99,107)) then toggleFlynotdown(true) end
    
    i(string.char(240,159,143,135,32,70,101,97,116,117,114,101,115,32,97,112,112,108,105,101,100,32,115,117,99,99,101,115,115,102,117,108,108,121,33))
end

local function mainMenu(userType)
    checkFunctionsControl()
    
    local isFreeUser = (userType == string.char(102,114,101,101))
    
    -- KEEP MENU TITLE UNENCRYPTED
    local menuTitle = [[
╔════════════════════════════╗
║         💀 DEATH SF 💀       
║         🔥 Version 2.0 🔥   
╚════════════════════════════╝]]
    
    if isFreeUser then
        menuTitle = menuTitle .. "\n👤 FREE USER - LIMITED FEATURES"
    else
        menuTitle = menuTitle .. "\n👑 PREMIUM USER - FULL ACCESS"
    end

    local menuOptions = {}
    local selectedStates = {}
    local optionIndex = 1
    
    if isFreeUser then
        if getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then
            menuOptions[optionIndex] = "🎯 MAGIC HEADSHOT    " .. (state.magic_headshot and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.magic_headshot
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(97,110,116,101,110,110,97)) then
            menuOptions[optionIndex] = "📡 ANTENNA HACK      " .. (state.antenna and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.antenna
            optionIndex = optionIndex + 1
        end
        
        menuOptions[optionIndex] = "💎 UPGRADE TO PREMIUM"
        selectedStates[optionIndex] = false
        optionIndex = optionIndex + 1
        
    else
        if getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then
            menuOptions[optionIndex] = "🎯 MAGIC HEADSHOT    " .. (state.magic_headshot and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.magic_headshot
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then
            menuOptions[optionIndex] = "🎯 MAGIC BODYSHOT    " .. (state.magic_bodyshot and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.magic_bodyshot
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(97,110,116,101,110,110,97)) then
            menuOptions[optionIndex] = "📡 ANTENNA HACK      " .. (state.antenna and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.antenna
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(110,111,97,109,109,111)) then
            menuOptions[optionIndex] = "🔫 NO AMMO DECREASE  " .. (state.noammo and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.noammo
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then
            menuOptions[optionIndex] = "💫 MAGIC BULLET      " .. (state.magic_bullet and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.magic_bullet
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(116,114,101,101,95,103,114,97,115,115,95,99,108,101,97,110)) then
            menuOptions[optionIndex] = "🌳 TREE & GRASS CLEAN " .. (state.tree_grass_clean and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.tree_grass_clean
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(105,112,97,100,95,118,105,101,119)) then
            menuOptions[optionIndex] = "📱 iPad VIEW         " .. (state.ipad_view and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.ipad_view
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(109,97,103,105,99,95,115,107,121,115,104,111,116,95,109,117,109,98,97,105,95,109,97,112)) then
            menuOptions[optionIndex] = "☁ MAGIC SKYSHOT     " .. (state.magic_skyshot_mumbai_map and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.magic_skyshot_mumbai_map
            optionIndex = optionIndex + 1
        end
        
        if getFeatureStatus(string.char(102,108,121,95,104,97,99,107)) then
            menuOptions[optionIndex] = "🚀 FLY HACK          " .. (state.flynotdown and "[✅]" or "[❌]")
            selectedStates[optionIndex] = state.flynotdown
            optionIndex = optionIndex + 1
        end
    end
    
    menuOptions[optionIndex] = "🚪 EXIT SCRIPT"
    selectedStates[optionIndex] = false
    
    local selected = a.multiChoice(menuOptions, selectedStates, menuTitle)

    if selected == nil then
        return
    end
    
    if isFreeUser then
        local featureCount = 0
        if getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then featureCount = featureCount + 1 end
        if getFeatureStatus(string.char(97,110,116,101,110,110,97)) then featureCount = featureCount + 1 end
        
        local upgradeOptionIndex = featureCount + 1
        
        if selected[upgradeOptionIndex] then
            h([[
💎 UPGRADE TO PREMIUM
━━━━━━━━━━━━━━━━━━━━

✨ Premium Features:
• Magic Bodyshot
• No Ammo Decrease  
• Magic Bullet
• Tree & Grass Clean
• iPad View
• Magic Skyshot
• Fly Hack

🔑 Contact the admin to get a premium license key!

📞 Telegram: @deaths4f & scarfall_hackerss
            ]])
            return
        end
    end
    
    local exitOptionIndex = #menuOptions
    if selected[exitOptionIndex] then
        local confirm = h("🚪 EXIT DEATH HX?\n\nAre you sure you want to exit?", "✅ YES, EXIT", "❌ NO, CANCEL")
        if confirm == 1 then
            -- KEEP EXIT MESSAGE UNENCRYPTED
            h([[
╔══════════════════════════╗
║        THANK YOU FOR         
║        USING DEATH SF!       
╠══════════════════════════╣
║                              
║   🔒 Stay Safe & Happy       
║   🎮 Gaming!                 
║                              
║   👋 See You Next Time!      
╚══════════════════════════╝
            ]])
            k() 
        end
        return
    end
    
    local featureSelection = {false, false, false, false, false, false, false, false, false}
    local currentIndex = 1
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then
        if selected[currentIndex] then featureSelection[1] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then
        if selected[currentIndex] then featureSelection[2] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(97,110,116,101,110,110,97)) then
        if selected[currentIndex] then featureSelection[3] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(110,111,97,109,109,111)) then
        if selected[currentIndex] then featureSelection[4] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then
        if selected[currentIndex] then featureSelection[5] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(116,114,101,101,95,103,114,97,115,115,95,99,108,101,97,110)) then
        if selected[currentIndex] then featureSelection[6] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(105,112,97,100,95,118,105,101,119)) then
        if selected[currentIndex] then featureSelection[7] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,115,107,121,115,104,111,116,95,109,117,109,98,97,105,95,109,97,112)) then
        if selected[currentIndex] then featureSelection[8] = true end
        currentIndex = currentIndex + 1
    end
    
    if getFeatureStatus(string.char(102,108,121,95,104,97,99,107)) then
        if selected[currentIndex] then featureSelection[9] = true end
        currentIndex = currentIndex + 1
    end
    
    applySelectedFeatures(featureSelection)
    
    local statusText = "📊 CURRENT STATUS:\n\n"
    local hasActiveFeatures = false
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,104,101,97,100,115,104,111,116)) then
        statusText = statusText .. "🎯 Magic Headshot: " .. (state.magic_headshot and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,98,111,100,121,115,104,111,116)) then
        statusText = statusText .. "🎯 Magic Bodyshot: " .. (state.magic_bodyshot and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(97,110,116,101,110,110,97)) then
        statusText = statusText .. "📡 Antenna Hack: " .. (state.antenna and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(110,111,97,109,109,111)) then
        statusText = statusText .. "🔫 No Ammo: " .. (state.noammo and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,98,117,108,108,101,116)) then
        statusText = statusText .. "💫 Magic Bullet: " .. (state.magic_bullet and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(116,114,101,101,95,103,114,97,115,115,95,99,108,101,97,110)) then
        statusText = statusText .. "🌳 Tree & Grass Clean: " .. (state.tree_grass_clean and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(105,112,97,100,95,118,105,101,119)) then
        statusText = statusText .. "📱 iPad View: " .. (state.ipad_view and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(109,97,103,105,99,95,115,107,121,115,104,111,116,95,109,117,109,98,97,105,95,109,97,112)) then
        statusText = statusText .. "☁ Magic Skyshot: " .. (state.magic_skyshot_mumbai_map and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if getFeatureStatus(string.char(102,108,121,95,104,97,99,107)) then
        statusText = statusText .. "🚀 Fly Hack: " .. (state.flynotdown and "✅ ON" or "❌ OFF") .. "\n"
        hasActiveFeatures = true
    end
    
    if not hasActiveFeatures then
        statusText = statusText .. "No features currently active\n"
    end
    
    if functionsControl.messages.announcement ~= string.char(34,34) then
        statusText = statusText .. "\n\n📢 Announcement:\n" .. functionsControl.messages.announcement
    end
    
    h(statusText, "🔙 BACK TO MENU")
end

i(string.char(240,159,148,145,32,73,110,105,116,105,97,108,105,122,105,110,103,32,68,69,65,84,72,32,72,88,32,50,46,48,46,46,46))
local loginSuccess, userType = enhancedLoginSystem()
if not loginSuccess then
    k()
end

i(string.char(240,159,143,135,32,76,111,103,105,110,32,115,117,99,99,101,115,115,102,117,108,33,32,87,101,108,99,111,109,101,32,116,111,32,68,69,65,84,72,32,72,88,32,50,46,48))

if userType == string.char(102,114,101,101) then
    i(string.char(240,159,145,164,32,70,114,101,101,32,85,115,101,114,32,45,32,76,105,109,105,116,101,100,32,70,101,97,116,117,114,101,115))
else
    i(string.char(240,159,145,145,32,80,114,101,109,105,117,109,32,85,115,101,114,32,45,32,70,117,108,108,32,65,99,99,101,115,115))
end

i(string.char(240,159,148,141,32,67,104,101,99,107,105,110,103,32,102,111,114,32,109,97,110,100,97,116,111,114,121,32,117,112,100,97,116,101,115,46,46,46))
mandatoryUpdateCheck()

i(string.char(240,159,148,141,32,67,104,101,99,107,105,110,103,32,102,117,110,99,116,105,111,110,115,32,99,111,110,116,114,111,108,46,46,46))
checkFunctionsControl()

if l(string.char(37,89,37,109,37,100))>string.char(50,48,50,54,49,49,49,54) then
    h(string.char(240,159,157,140,32,83,99,114,105,112,116,32,69,120,112,105,114,101,100,32,240,159,157,140,10,240,159,147,149,32,68,111,119,110,108,111,97,100,32,76,97,116,101,115,116,32,86,101,114,115,105,111,110))
    k()
end

i(string.char(240,159,148,165,32,83,99,114,105,112,116,32,65,99,116,105,118,97,116,101,100,33))

while true do
    if a.isVisible(true) then
        a.setVisible(false)
        mainMenu(userType)
    end
    a.sleep(100)
end
