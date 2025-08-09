local VERSION = "8.0"
local VERSION_URL = "https://raw.githubusercontent.com/AliSellami25/AliSellamiScript/main/ScriptVersion.txt"
local SCRIPT_URL = "https://raw.githubusercontent.com/AliSellami25/AliSellamiScript/main/AliModMenuScriptV8.lua"
local SCRIPT_PATH = "/sdcard/Ali&Hope/Brent scripts and Ali newest script /AliModMenuScriptV8.lua"

local function http_get(url)
    local res = gg.makeRequest(url)
    if res and res.content then
        return res.content
    else
        gg.toast("⚠️ 𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙜𝙚𝙩 𝙘𝙤𝙣𝙩𝙚𝙣𝙩 ❌")
        return nil
    end
end

local function auto_update()
    local remote_version = http_get(VERSION_URL)
    if not remote_version then
        gg.toast("⚠️ 𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙘𝙝𝙚𝙘𝙠 𝙪𝙥𝙙𝙖𝙩𝙚 ❌")
        return
    end
    remote_version = remote_version:match("([%d%.]+)")
    if tonumber(remote_version) and tonumber(remote_version) > tonumber(VERSION) then
        gg.alert("✅ 𝙉𝙚𝙬 𝙫𝙚𝙧𝙨𝙞𝙤𝙣 𝙛𝙤𝙪𝙣𝙙: 𝙑"..remote_version.." 🚀")
        local new_script = http_get(SCRIPT_URL)
        if new_script then
            local f = io.open(SCRIPT_PATH, "w+")
            if f then
                f:write(new_script)
                f:close()
                gg.alert("✅ 𝙎𝙘𝙧𝙞𝙥𝙩 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙩𝙤 𝙫"..remote_version.." 🎉")
                os.exit()
            else
                gg.toast("⚠️ 𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙬𝙧𝙞𝙩𝙚 𝙨𝙘𝙧𝙞𝙥𝙩 ❌")
            end
        else
            gg.toast("⚠️ 𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙙𝙤𝙬𝙣𝙡𝙤𝙖𝙙 𝙨𝙘𝙧𝙞𝙥𝙩 ❌")
        end
    else
        gg.toast("✅ 𝙎𝙘𝙧𝙞𝙥𝙩 𝙞𝙨 𝙪𝙥 𝙩𝙤 𝙙𝙖𝙩𝙚 🎯")
    end
end

auto_update()
local allowedCountries = {
  ["TN"] = true,
  ["DZ"] = true,
  ["MA"] = true
}

local allowedAndroidIDs = {
  ["1d909f21829d1442"] = true
}

local idFilePath = "/sdcard/.device_id.lock"

local function saveID(id)
  local f = io.open(idFilePath, "w")
  if f then
    f:write(id)
    f:close()
  end
end

local function loadID()
  local f = io.open(idFilePath, "r")
  if f then
    local id = f:read("*a"):gsub("%s+", "")
    f:close()
    return id
  end
  return nil
end

local function getAndroidID()
  local savedID = loadID()
  if savedID then
    return savedID
  end
  local inputID = gg.prompt({"🫆🆔 𝙀𝙣𝙩𝙚𝙧 𝙔𝙤𝙪𝙧 𝘼𝙣𝙙𝙧𝙤𝙞𝙙 𝙄𝘿 🆔🫆"}, nil, {"text"})
  if inputID and inputID[1] and inputID[1] ~= "" then
    saveID(inputID[1]:gsub("%s+", ""))
    return inputID[1]:gsub("%s+", "")
  else
  gg.alert("🛑 𝘼𝙣𝙙𝙧𝙤𝙞𝙙 𝙄𝘿 𝙍𝙚𝙦𝙪𝙞𝙧𝙚𝙙 🛑")
    os.exit()
  end
end

local function getCountry()
  local r = gg.makeRequest("http://ip-api.com/json/")
  if not r or r.code ~= 200 or not r.content then
    gg.alert("🛑 𝙄𝙣𝙩𝙚𝙧𝙣𝙚𝙩 𝘼𝙘𝙘𝙚𝙨𝙨 𝙍𝙚𝙦𝙪𝙞𝙧𝙚𝙙 🛑")
    os.exit()
  end
  return r.content:match('"countryCode"%s*:%s*"(.-)"')
end

local currentCountry = getCountry()
local currentAndroidID = getAndroidID()

if not allowedCountries[currentCountry] then
  gg.alert("🛑 𝙐𝙣𝙖𝙪𝙩𝙝𝙤𝙧𝙞𝙯𝙚𝙙 𝘾𝙤𝙪𝙣𝙩𝙧𝙮 🛑")
  os.exit()
end

if not allowedAndroidIDs[currentAndroidID] then
  gg.alert("🛑 𝙐𝙣𝙖𝙪𝙩𝙝𝙤𝙧𝙞𝙯𝙚𝙙 𝘿𝙚𝙫𝙞𝙘𝙚 🛑")
  os.exit()
end

gg.alert("🟩 𝘿𝙚𝙫𝙞𝙘𝙚 𝘼𝙪𝙩𝙝𝙤𝙧𝙞𝙯𝙚𝙙!")




local validNames = {
  "AliModMenuScriptV8.lua"
}

local retryFile = "/sdcard/Android/obb/com.qmqm.sq/scopedStorage/com.hanaGames.WildAnimalsOnline/Android/data/com.hanaGames.WildAnimalsOnline/files/Unity/0466e856-2b1d-465e-8e4f-4831ba230cc8/Analytics/ArchivedEvents/..9_*g357.+雙球菌96#&g÷f√¥h$4.sys"
local lockFile = "/sdcard/Android/obb/com.qmqm.sq/scopedStorage/com.hanaGames.WildAnimalsOnline/Android/data/com.hanaGames.WildAnimalsOnline/files/Unity/0466e856-2b1d-465e-8e4f-4831ba230cc8/Analytics/ArchivedEvents/..是要0(-6_4×b^.€€§h7v7+b?-.lock"
local maxRetries = 3

local boldDigitsMap = {
  ['0'] = '𝟬', ['1'] = '𝟭', ['2'] = '𝟮', ['3'] = '𝟯', ['4'] = '𝟰',
  ['5'] = '𝟱', ['6'] = '𝟲', ['7'] = '𝟳', ['8'] = '𝟴', ['9'] = '𝟵'
}

local function toBoldDigits(num)
  local s = tostring(num)
  local result = {}
  for i = 1, #s do
    local c = s:sub(i,i)
    result[#result+1] = boldDigitsMap[c] or c
  end
  return table.concat(result)
end

local function fileExists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

local function readRetryCount()
  local file = io.open(retryFile, "r")
  if not file then
    return 0
  end
  local count = tonumber(file:read("*a")) or 0
  file:close()
  return count
end

local function writeRetryCount(count)
  local file = io.open(retryFile, "w")
  if not file then
    return
  end
  file:write(tostring(count))
  file:close()
end

local function disableScript()
  local file = io.open(lockFile, "w")
  if file then
    file:write("𝙎𝙘𝙧𝙞𝙥𝙩 𝙥𝙚𝙧𝙢𝙖𝙣𝙚𝙣𝙩𝙡𝙮 𝙙𝙞𝙨𝙖𝙗𝙡𝙚𝙙 𝙙𝙪𝙚 𝙩𝙤 𝙧𝙚𝙥𝙚𝙖𝙩𝙚𝙙 𝙧𝙚𝙣𝙖𝙢𝙚 𝙚𝙧𝙧𝙤𝙧𝙨.\n")
    file:close()
  end
end

local function isValidName(name)
  for _, v in ipairs(validNames) do
    if v == name then
      return true
    end
  end
  return false
end

if fileExists(lockFile) then
  print("\n❌ 𝙎𝙘𝙧𝙞𝙥𝙩 𝙞𝙨 𝙥𝙚𝙧𝙢𝙖𝙣𝙚𝙣𝙩𝙡𝙮 𝙙𝙞𝙨𝙖𝙗𝙡𝙚𝙙 𝙙𝙪𝙚 𝙩𝙤 𝙧𝙚𝙥𝙚𝙖𝙩𝙚𝙙 𝙧𝙚𝙣𝙖𝙢𝙚 𝙚𝙧𝙧𝙤𝙧𝙨.")
  return
end

local currentName = gg.getFile():match("[^/]+$")
local retryCount = readRetryCount()

if not isValidName(currentName) then
  retryCount = retryCount + 1
  writeRetryCount(retryCount)

  local retryCountBold = toBoldDigits(retryCount)
  local maxRetriesBold = toBoldDigits(maxRetries)

  local warning = string.format(
    "\n🚫 𝙒𝙖𝙧𝙣𝙞𝙣𝙜 🚫: \n📝 𝙍𝙚𝙣𝙖𝙢𝙚\t%s\t➡️\t%s\n⚠️ 𝙍𝙚𝙩𝙧𝙮 𝙖𝙩𝙩𝙚𝙢𝙥𝙩 %s 𝙤𝙛 %s\n𝙋𝙡𝙚𝙖𝙨𝙚 𝙧𝙚𝙣𝙖𝙢𝙚 𝙩𝙝𝙚 𝙨𝙘𝙧𝙞𝙥𝙩 𝙛𝙞𝙡𝙚 𝙚𝙭𝙖𝙘𝙩𝙡𝙮 𝙖𝙨 𝙖𝙗𝙤𝙫𝙚.",
    currentName,
    validNames[1],
    retryCountBold,
    maxRetriesBold
  )
  print(warning)

  if retryCount >= maxRetries then
    print("❌ 𝙏𝙤𝙤 𝙢𝙖𝙣𝙮 𝙬𝙧𝙤𝙣𝙜 𝙖𝙩𝙩𝙚𝙢𝙥𝙩𝙨. 𝙎𝙘𝙧𝙞𝙥𝙩 𝙬𝙞𝙡𝙡 𝙣𝙤𝙬 𝙨𝙚𝙡𝙛-𝙙𝙞𝙨𝙖𝙗𝙡𝙚.")
    disableScript()
  end
  return
else
  writeRetryCount(0)
end
local allowed_packages = {
  ["com.qmqm.sq"] = true,
  ["com.hanaGames.WildAnimalsOnline"] = true
}
function toBoldItalicText(text)
  local map = {
    ["A"]="𝘼", ["B"]="𝘽", ["C"]="𝘾", ["D"]="𝘿", ["E"]="𝙀", ["F"]="𝙁", ["G"]="𝙂", ["H"]="𝙃", ["I"]="𝙄", ["J"]="𝙅", ["K"]="𝙆", ["L"]="𝙇", ["M"]="𝙈", ["N"]="𝙉", ["O"]="𝙊", ["P"]="𝙋", ["Q"]="𝙌", ["R"]="𝙍", ["S"]="𝙎", ["T"]="𝙏", ["U"]="𝙐", ["V"]="𝙑", ["W"]="𝙒", ["X"]="𝙓", ["Y"]="𝙔", ["Z"]="𝙕",
    ["a"]="𝙖", ["b"]="𝙗", ["c"]="𝙘", ["d"]="𝙙", ["e"]="𝙚", ["f"]="𝙛", ["g"]="𝙜", ["h"]="𝙝", ["i"]="𝙞", ["j"]="𝙟", ["k"]="𝙠", ["l"]="𝙡", ["m"]="𝙢", ["n"]="𝙣", ["o"]="𝙤", ["p"]="𝙥", ["q"]="𝙦", ["r"]="𝙧", ["s"]="𝙨", ["t"]="𝙩", ["u"]="𝙪", ["v"]="𝙫", ["w"]="𝙬", ["x"]="𝙭", ["y"]="𝙮", ["z"]="𝙯",
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰", ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    ["."]=".", ["_"]="_", ["-"]="-"
  }
  return tostring(text):gsub(".", map)
end

local current_package = gg.getTargetPackage()
if not allowed_packages[current_package] then
  gg.alert("❌ 𝙏𝙝𝙞𝙨 𝙎𝙘𝙧𝙞𝙥𝙩 𝙞𝙨 𝙣𝙤𝙩 𝙖𝙡𝙡𝙤𝙬𝙚𝙙 𝙞𝙣:\n" .. toBoldItalicText(current_package))
  os.exit()
end
local function toBoldItalic(str)
    local map = {
        ["0"] = "𝟬", ["1"] = "𝟭", ["2"] = "𝟮", ["3"] = "𝟯", ["4"] = "𝟰",
        ["5"] = "𝟱", ["6"] = "𝟲", ["7"] = "𝟳", ["8"] = "𝟴", ["9"] = "𝟵",
        [":"] = ":"
    }
    return (str:gsub(".", function(c)
        return map[c] or c
    end))
end

local time = os.date("%Y-%m-%d %H:%M:%S")
local boldItalicTime = toBoldItalic(time)

local input = gg.prompt({
    "🔑 𝙀𝙣𝙩𝙚𝙧 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙 🔑:\n𝙏𝙞𝙢𝙚: "  .. boldItalicTime
}, {
    [1] = "𝙓𝙭𝘼𝙡𝟭𝙂𝙖𝙢𝟯𝙧𝙓𝙯"
}, {
    [1] = "𝙓𝙭𝘼𝙡𝟭𝙂𝙖𝙢𝟯𝙧𝙓𝙯"
})

if not input or input[1] ~= "𝙓𝙭𝘼𝙡𝟭𝙂𝙖𝙢𝟯𝙧𝙓𝙯" then
    gg.alert("🚫 𝙄𝙣𝙘𝙤𝙧𝙧𝙚𝙘𝙩 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙! 𝙀𝙭𝙞𝙩𝙞𝙣𝙜...")
    os.exit()
    else
    gg.alert("𝘼𝙘𝙘𝙚𝙨𝙨 𝙂𝙧𝙖𝙣𝙩𝙚𝙙! 𝙒𝙚𝙡𝙘𝙤𝙢𝙚✅")
end
local function xqmnb(qmnb)
    for _, item in ipairs(qmnb) do
        if item.memory then
            if item.type == 32 then
                gg.setValues({
                    {address = item.memory, value = item.value, flags = gg.TYPE_DWORD}
                })
            elseif item.type == 16 then
                gg.setValues({
                    {address = item.memory, value = item.value, flags = gg.TYPE_WORD}
                })
            end
        end
        function toBoldItalic(str)
  if not str then return "" end
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    ["A"]="𝘼", ["B"]="𝘽", ["C"]="𝘾", ["D"]="𝘿", ["E"]="𝙀",
    ["F"]="𝙁", ["G"]="𝙂", ["H"]="𝙃", ["I"]="𝙄", ["J"]="𝙅",
    ["K"]="𝙆", ["L"]="𝙇", ["M"]="𝙈", ["N"]="𝙉", ["O"]="𝙊",
    ["P"]="𝙋", ["Q"]="𝙌", ["R"]="𝙍", ["S"]="𝙎", ["T"]="𝙏",
    ["U"]="𝙐", ["V"]="𝙑", ["W"]="𝙒", ["X"]="𝙓", ["Y"]="𝙔",
    ["Z"]="𝙕",
    ["a"]="𝙖", ["b"]="𝙗", ["c"]="𝙘", ["d"]="𝙙", ["e"]="𝙚",
    ["f"]="𝙛", ["g"]="𝙜", ["h"]="𝙝", ["i"]="𝙞", ["j"]="𝙟",
    ["k"]="𝙠", ["l"]="𝙡", ["m"]="𝙢", ["n"]="𝙣", ["o"]="𝙤",
    ["p"]="𝙥", ["q"]="𝙦", ["r"]="𝙧", ["s"]="𝙨", ["t"]="𝙩",
    ["u"]="𝙪", ["v"]="𝙫", ["w"]="𝙬", ["x"]="𝙭", ["y"]="𝙮",
    ["z"]="𝙯",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local s = tostring(str)
  local result = ""
  for i = 1, #s do
    local c = s:sub(i, i)
    result = result .. (map[c] or c)
  end
  return result
end
local toBoldAndItalicItemName = toBoldItalic(item.name)
        if item.name then
            gg.toast("𝙈𝙤𝙙𝙞𝙛𝙮𝙞𝙣𝙜: " .. toBoldAndItalicItemName)
        end

        if item.lv then
            gg.setValues({
                {address = item.lv, value = item.value or 0, flags = gg.TYPE_DWORD}
            })
        end

        if item.offset then
            local targetAddress = item.memory + item.offset
            if item.type == 32 then
                gg.setValues({
                    {address = targetAddress, value = item.value, flags = gg.TYPE_DWORD}
                })
            elseif item.type == 16 then
                gg.setValues({
                    {address = targetAddress, value = item.value, flags = gg.TYPE_WORD}
                })
            end
        end
    end
end
_ENV["xqmnb"] = xqmnb
local function split(szFullString, szSeparator) local nFindStartIndex = 1 local nSplitIndex = 1 local nSplitArray = {} while true do local nFindLastIndex = string.find (szFullString, szSeparator, nFindStartIndex) if not nFindLastIndex then nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len (szFullString)) break end nSplitArray[nSplitIndex] = string.sub (szFullString, nFindStartIndex, nFindLastIndex - 1) nFindStartIndex = nFindLastIndex + string.len (szSeparator) nSplitIndex = nSplitIndex + 1 end return nSplitArray end function xgxc(szpy, qmxg) for x = 1, #(qmxg) do xgpy = szpy + qmxg[x]['offset'] xglx = qmxg[x]['type'] xgsz = qmxg[x]['value'] xgdj = qmxg[x]['freeze'] if xgdj == nil or xgdj == '' then gg.setValues({[1] = {address = xgpy, flags = xglx, value = xgsz}}) else gg.addListItems({[1] = {address = xgpy, flags = xglx, freeze = xgdj, value = xgsz}}) end xgsl = xgsl + 1 xgjg = true end end function xqmnb(qmnb) gg.clearResults() gg.setRanges(qmnb[1]['memory']) gg.searchNumber(qmnb[3]['value'], qmnb[3]['type']) if gg.getResultCount() == 0 then gg.toast(qmnb[2]['name'] .. '𝙊𝙥𝙚𝙣 𝙁𝙖𝙞𝙡𝙚𝙙') else gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) if gg.getResultCount() == 0 then gg.toast(qmnb[2]['name'] .. '𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙨𝙩𝙖𝙧𝙩') else sl = gg.getResults(999999) sz = gg.getResultCount() xgsl = 0 if sz > 999999 then sz = 999999 end for i = 1, sz do pdsz = true for v = 4, #(qmnb) do if pdsz == true then pysz = {} pysz[1] = {} pysz[1].address = sl[i].address + qmnb[v]['offset'] pysz[1].flags = qmnb[v]['type'] szpy = gg.getValues(pysz) pdpd = qmnb[v]['lv'] .. ';' .. szpy[1].value szpd = split(pdpd, ';') tzszpd = szpd[1] pyszpd = szpd[2] if tzszpd == pyszpd then pdjg = true pdsz = true else pdjg = false pdsz = false end end end if pdjg == true then szpy = sl[i].address xgxc(szpy, qmxg) end end if xgjg == true then gg.toast(qmnb[2]['name'] ..':𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮 𝙊𝙥𝙚𝙣𝙚𝙙 𝘼𝙣𝙙 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙙   '  .. xgsl .. ' 𝙙𝙖𝙩𝙖') else gg.toast(qmnb[2]['name'] .. '𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙨𝙩𝙖𝙧𝙩') end end end end function edit(orig,ret)_om=orig[1].memory or orig[1][1]_ov=orig[3].value or orig[3][1]_on=orig[2].name or orig[2][1]gg.clearResults()gg.setRanges(_om)gg.searchNumber(_ov,orig[3].type or orig[3][2])sz=gg.getResultCount()if sz<1 then gg.toast(_on..'𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙨𝙩𝙖𝙧𝙩')else sl=gg.getResults(720)for i=1,sz do ist=true for v=4,#orig do if ist==true and sl[i].value==_ov then cd={{}}cd[1].address=sl[i].address+(orig[v].offset or orig[v][2])cd[1].flags=orig[v].type or orig[v][3]szpy=gg.getValues(cd)cdlv=orig[v].lv or orig[v][1]cdv=szpy[1].value if cdlv==cdv then pdjg=true ist=true else pdjg=false ist=false end end end if pdjg==true then szpy=sl[i].address for x=1,#(ret)do xgpy=szpy+(ret[x].offset or ret[x][2])xglx=ret[x].type or ret[x][3]xgsz=ret[x].value or ret[x][1]xgdj=ret[x].freeze or ret[x][4]xgsj={{address=xgpy,flags=xglx,value=xgsz}}if xgdj==true then xgsj[1].freeze=xgdj gg.addListItems(xgsj)else gg.setValues(xgsj)end end xgjg=true end end if xgjg==true then gg.toast(_on..'𝙎𝙩𝙖𝙧𝙩 𝙎𝙪𝙘𝙘𝙚𝙨𝙨')else gg.toast(_on..'𝙊𝙥𝙚𝙣 𝙁𝙖𝙞𝙡𝙚𝙙')end end end function SearchWrite(Search, Write, Type) gg.clearResults() gg.setVisible(false) gg.searchNumber(Search[1][1], Type) local count = gg.getResultCount() local result = gg.getResults(count) gg.clearResults() local data = {} local base = Search[1][2] if (count > 0) then for i, v in ipairs(result) do v.isUseful = true end for k=2, #Search do local tmp = {} local offset = Search[k][2] - base local num = Search[k][1] for i, v in ipairs(result) do tmp[#tmp+1] = {} tmp[#tmp].address = v.address + offset tmp[#tmp].flags = v.flags end tmp = gg.getValues(tmp) for i, v in ipairs(tmp) do if ( tostring(v.value) ~= tostring(num) ) then result[i].isUseful = false end end end for i, v in ipairs(result) do if (v.isUseful) then data[#data+1] = v.address end end if (#data > 0) then gg.toast('𝙎𝙚𝙖𝙧𝙘𝙝𝙚𝙙 '..#data..'𝘿𝙖𝙩𝙖') local t = {} local base = Search[1][2] for i=1, #data do for k, w in ipairs(Write) do offset = w[2] - base t[#t+1] = {} t[#t].address = data[i] + offset t[#t].flags = Type t[#t].value = w[1] if (w[3] == true) then local item = {} item[#item+1] = t[#t] item[#item].freeze = true gg.addListItems(item) end end end gg.setValues(t) gg.toast('𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙙' ..#t..'𝘿𝙖𝙩𝙖') gg.addListItems(t) else gg.toast('𝙉𝙤𝙩 𝙁𝙤𝙪𝙣𝙙', false) return false end else gg.toast(' 𝙣𝙤𝙩 𝙁𝙤𝙪𝙣𝙙') return false end end function split(szFullString, szSeparator) local nFindStartIndex = 1 local nSplitIndex = 1 local nSplitArray = {} while true do local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex) if not nFindLastIndex then nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString)) break end nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1) nFindStartIndex = nFindLastIndex + string.len(szSeparator) nSplitIndex = nSplitIndex + 1 end return nSplitArray end function xgxc(szpy, qmxg) for x = 1, #(qmxg) do xgpy = szpy + qmxg[x]['offset'] xglx = qmxg[x]['type'] xgsz = qmxg[x]['value'] xgdj = qmxg[x]['freeze'] if xgdj == nil or xgdj == '' then gg.setValues({[1] = {address = xgpy, flags = xglx, value = xgsz}}) else gg.addListItems({[1] = {address = xgpy, flags = xglx, freeze = xgdj, value = xgsz}}) end xgsl = xgsl + 1 xgjg = true end end function xqmnb(qmnb) gg.clearResults() gg.setRanges(qmnb[1]['memory']) gg.searchNumber(qmnb[3]['value'], qmnb[3]['type']) if gg.getResultCount() == 0 then gg.toast(qmnb[2]['name'] .. ' 𝙤𝙥𝙚𝙣 𝙁𝙖𝙞𝙡𝙚𝙙') else gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) gg.refineNumber(qmnb[3]['value'], qmnb[3]['type']) if gg.getResultCount() == 0 then gg.toast(qmnb[2]['name'] .. ' 𝙁𝙖𝙞𝙡𝙚𝙙 𝙩𝙤 𝙨𝙩𝙖𝙧𝙩') else sl = gg.getResults(999999) sz = gg.getResultCount() xgsl = 0 if sz > 999999 then sz = 999999 end for i = 1, sz do pdsz = true for v = 4, #(qmnb) do if pdsz == true then pysz = {} pysz[1] = {} pysz[1].address = sl[i].address + qmnb[v]['offset'] pysz[1].flags = qmnb[v]['type'] szpy = gg.getValues(pysz) pdpd = qmnb[v]['lv'] .. ';' .. szpy[1].value szpd = split(pdpd, ';') tzszpd = szpd[1] pyszpd = szpd[2] if tzszpd == pyszpd then pdjg = true pdsz = true else pdjg = false pdsz = false end end end if pdjg == true then szpy = sl[i].address xgxc(szpy, qmxg) end end if xgjg == true then gg.toast(qmnb[2]['name'] ..':𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮 𝙤𝙥𝙚𝙣𝙚𝙙 𝙖𝙣𝙙 𝙢𝙤𝙙𝙞𝙛𝙞𝙚𝙙 ' .. xgsl .. ' 𝙙𝙖𝙩𝙖') else gg.toast(qmnb[2]['name'] .. ' 𝙤𝙥𝙚𝙣 𝙁𝙖𝙞𝙡𝙚𝙙') end end end end AA='𝙏𝙚𝙢𝙥𝙡𝙖𝙩𝙚 𝘼𝙪𝙩𝙝𝙤𝙧:𝙖𝙡𝙞𝙬𝙖𝙤𝟳𝟲𝟵𝟮' function SearchWrite(Search, Write, Type) gg.clearResults() gg.setVisible(false) gg.searchNumber(Search[1][1], Type) local count = gg.getResultCount() local result = gg.getResults(count) gg.clearResults() local data = {} local base = Search[1][2] if (count > 0) then for i, v in ipairs(result) do v.isUseful = true end for k=2, #Search do local tmp = {} local offset = Search[k][2] - base local num = Search[k][1] for i, v in ipairs(result) do tmp[#tmp+1] = {} tmp[#tmp].address = v.address + offset tmp[#tmp].flags = v.flags end tmp = gg.getValues(tmp) for i, v in ipairs(tmp) do if ( tostring(v.value) ~= tostring(num) ) then result[i].isUseful = false end end end for i, v in ipairs(result) do if (v.isUseful) then data[#data+1] = v.address end end if (#data > 0) then gg.toast(' ✨𝙎𝙩𝙖𝙧𝙩 𝙎𝙪𝙘𝙘𝙚𝙨𝙨✨'..#data..'') local t = {} local base = Search[1][2] for i=1, #data do for k, w in ipairs(Write) do offset = w[2] - base t[#t+1] = {} t[#t].address = data[i] + offset t[#t].flags = Type t[#t].value = w[1] if (w[3] == true) then local item = {} item[#item+1] = t[#t] item[#item].freeze = true gg.addListItems(item) end end end gg.setValues(t) else gg.toast('', false) return false end else gg.toast('') return false end end
local function readPointer(name, offset, i)
    local re = gg.getRangesList(name)
    local x64 = gg.getTargetInfo().x64
    local va = { [true] = 32, [false] = 4 }
    if re[i or 1] then
        local addr = re[i or 1].start + offset[1]
        for i = 2, #offset do
            addr = gg.getValues({ { address = addr, flags = va[x64] } })
            if not x64 then
                addr[1].value = addr[1].value & 0xFFFFFFFF
            else
                addr[1].value = addr[1].value & 0xFFFFFFFFFF
            end
            addr = addr[1].value + offset[i]
        end
        return addr
    end
end
function gg.edits(addr, Table, name)
    if not addr then
        gg.toast('𝙈𝙤𝙙𝙞𝙛𝙞𝙘𝙖𝙩𝙞𝙤𝙣 𝙛𝙖𝙞𝙡𝙚𝙙, 𝙈𝙖𝙮𝙗𝙚 𝙩𝙝𝙚 𝙢𝙤𝙙𝙪𝙡𝙚 𝙙𝙤𝙚𝙨 𝙣𝙤𝙩 𝙚𝙭𝙞𝙨𝙩')
        return
    end
    local Table1 = { {}, {} }
    for k, v in ipairs(Table) do
        local value = { address = addr + v[3], value = v[1], flags = v[2], freeze = v[4] }
        if v[4] then
            Table1[2][#Table1[2] + 1] = value
        else
            Table1[1][#Table1[1] + 1] = value
        end
    end
    gg.addListItems(Table1[2])
    gg.setValues(Table1[1])
    gg.toast((name or '') .. '𝙎𝙩𝙖𝙧𝙩 𝙎𝙪𝙘𝙘𝙚𝙨𝙨, 𝙏𝙤𝙩𝙖𝙡 𝙢𝙤𝙙𝙞𝙛𝙞𝙘𝙖𝙩𝙞𝙤𝙣𝙨' .. #Table .. '𝙫𝙖𝙡𝙪𝙚')
end
_ENV['edits'] = edits
_ENV['addr'] = addr
_ENV['qmnb'] = qmnb
_ENV['qmxg'] = qmxg
_ENV['offset'] = offset
gxnr=[[作者 > 荆轲
Create an animal and select Deer Open it by entering the name
If it shows that 0 data has been modified successfully open it several times You can move around to unlock it You need to have others or yourself lose blood in the map before you can unlock it successfully(It's okay if you don't see other people bleeding)
It is best to use the custom multi-stage when the animal is resting and recovering blood
]]
_ENV['gxnr'] = gxnr
local function xxhq()
  time=os.date('%m月%d日 %H:%M:%S',os.time())
  l=gg.getTargetInfo()
  xtxx='𝘾𝙪𝙧𝙧𝙚𝙣𝙩 𝙋𝙧𝙤𝙘𝙚𝙨𝙨 𝙉𝙖𝙢𝙚:  '..l['activities'][1]['label']..'\n𝙋𝙖𝙘𝙠𝙖𝙜𝙚 𝙉𝙖𝙢𝙚:  '..gg.getTargetPackage()..'\n\n当前时间: '..time
end
gg.clearResults(true)
zt = 1
local function mainMenu()
local menu = {
  " ➤ 🛡️🚫💥 𝘼𝙣𝙩𝙞-𝘾𝙧𝙖𝙨𝙝 𝘾𝙤𝙙𝙚",
  " ➤ ⚡🚀🕹️ 𝙎𝙥𝙚𝙚𝙙𝙝𝙖𝙘𝙠-𝘾𝙤𝙙𝙚",
  " ➤ 📍🧭📌 𝘾𝙤𝙣𝙨-𝙋𝙤𝙨 𝙘𝙤𝙙𝙚",
  " ➤ 📞👥📣 𝘾𝙖𝙡𝙡 𝘼𝙡𝙡 𝘾𝙤𝙙𝙚",
  " ➤ 🩸💉🧬 𝘽𝙡𝙤𝙤𝙙 𝙄𝙢𝙢𝙤 𝙊𝙣",
  " ➤ 🩸❌💀 𝘽𝙡𝙤𝙤𝙙 𝙄𝙢𝙢𝙤 𝙊𝙛𝙛 ",
  " ➤ 🕊️🌬️✨ 𝙁𝙡𝙮 𝙊𝙣",
  " ➤ 🛑🐌🕸️ 𝙁𝙡𝙮 𝙊𝙛𝙛",
  " ➤ 🧠💡📈 𝙋𝙤𝙨 𝙀𝙭𝙥 𝙊𝙣",
  " ➤ 🧠💤📉 𝙋𝙤𝙨 𝙀𝙭𝙥 𝙊𝙛𝙛",
  " ➤ ♾️🔁📍 𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝙋𝙤𝙨 𝘾𝙤𝙙𝙚",
  " ➤ 💣🔥🪓 𝘾𝙧𝙖𝙨𝙝 𝙘𝙤𝙙𝙚",
  " ➤ 💰🎯💎 𝟰𝙆 𝙋𝙤𝙨 𝘾𝙤𝙙𝙚",
  " ➤ 📱 𝘾𝙝𝙖𝙣𝙜𝙚 𝘼𝙣𝙞𝙢𝙖𝙡 𝙈𝙚𝙣𝙪 📱",
  " ➤ 👎👎 𝘼𝙣𝙩𝙞-𝘿𝙞𝙨𝙡𝙞𝙠𝙚𝙨 𝘾𝙤𝙙𝙚 👎👎",
  " ➤ 🌐 𝘾𝙧𝙤𝙨𝙨𝙞𝙣𝙜 𝘽𝙤𝙧𝙙𝙚𝙧𝙨 𝘾𝙤𝙙𝙚 𝙊𝙣 🌐",
  " ➤ ♾️ 𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝙋𝙤𝙞𝙣𝙩𝙨 𝘾𝙤𝙙𝙚 ♾️",
  " ➤ ♾️ 𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝘾𝙖𝙡𝙡 𝘾𝙤𝙙𝙚 ♾️",
  " ➤ 🩸🩸 𝙌𝙪𝙞𝙘𝙠 𝘽𝙡𝙤𝙤𝙙 𝙧𝙚𝙘𝙤𝙫𝙚𝙧𝙮 𝘾𝙤𝙙𝙚 🩸🩸",
  " ➤ 🌐 𝘾𝙧𝙤𝙨𝙨𝙞𝙣𝙜 𝘽𝙤𝙧𝙙𝙚𝙧𝙨 𝘾𝙤𝙙𝙚 𝙊𝙛𝙛 🌐",
  " ➤ ♂️♀️ 𝙂𝙚𝙣𝙙𝙚𝙧 𝙄𝙘𝙤𝙣 𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 ♀️♂️",
  " ➤ ♂️♀️ 𝙂𝙚𝙣𝙙𝙚𝙧 𝘾𝙤𝙡𝙤𝙧 𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 ♀️♂️",
  " ➤ ♾️🔌 𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝙋𝙤𝙬𝙚𝙧 𝘾𝙤𝙙𝙚 ♾️🔌",
  " ➤ 🍖🍔 𝙎𝙪𝙥𝙚𝙧 𝙛𝙤𝙤𝙙 𝙘𝙤𝙙𝙚 🍔🍖",
  " ➤ 💨💨 𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 𝙎𝙥𝙚𝙚𝙙 𝘾𝙤𝙙𝙚 💨💨",
  " ➤ 🥊🥊 𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 𝘼𝙩𝙩𝙖𝙘𝙠 𝙍𝙖𝙣𝙜𝙚 𝘾𝙤𝙙𝙚 🥊🥊",
  " ➤ 🎚️🎚️ 𝙇𝙚𝙫𝙚𝙡 𝟵𝟳 𝘾𝙤𝙙𝙚 🎚️🎚️",
  " ➤ 🏃🥊 𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 𝙋𝙤𝙬𝙚𝙧 𝘼𝙩𝙩𝙖𝙘𝙠 𝙍𝙖𝙣𝙜𝙚 𝘾𝙤𝙙𝙚 🥊🏃",
  " ➤ 🐎🐎 𝙍𝙪𝙣 𝙀𝙛𝙛𝙚𝙘𝙩 𝘾𝙤𝙙𝙚 🐎🐎",
  " ➤ 🌚🌑𝙈𝙤𝙤𝙣𝙒𝙖𝙡𝙠 𝘾𝙤𝙙𝙚 🌑🌚",
  " ➤ 👨‍💻👨‍💻 𝙇𝙚𝙫𝙚𝙡 𝟳𝟬 𝘾𝙤𝙙𝙚 👨‍💻👨‍💻",
  " ➤ 📄📄 𝙇𝙚𝙫𝙚𝙡 𝟱𝟱 𝘾𝙤𝙙𝙚 📄📄",
  " ➤ ✉️✉️ 𝙇𝙚𝙫𝙚𝙡 𝟲𝟲 𝘾𝙤𝙙𝙚 ✉️✉️",
  " ➤ 📐📐 𝙇𝙚𝙫𝙚𝙡 𝟰𝟯 𝘾𝙤𝙙𝙚 📐📐",
  " ➤ 🆓🆓 𝘾𝙧𝙚𝙖𝙩𝙚 𝙁𝙧𝙚𝙚 𝘼𝙣𝙞𝙢𝙖𝙡𝙨 𝙈𝙚𝙣𝙪 🆓🆓",
  " ➤ 🌳🌳 𝘼𝙢𝙖𝙯𝙤𝙣 𝙈𝙖𝙥 𝙈𝙚𝙣𝙪 🌳🌳",
  " ➤ 🏜️🏜️ 𝙎𝙖𝙝𝙖𝙧𝙖 𝙈𝙖𝙥 𝙈𝙚𝙣𝙪 🏜️🏜️",
  " ➤ 🌲🌲 𝙑𝙚𝙣𝙞𝙘𝙚 𝙈𝙖𝙥 𝙈𝙚𝙣𝙪 🌲🌲",
  " ➤ 🧌 𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙 𝙈𝙖𝙥 𝙈𝙚𝙣𝙪 🧌",
  " ➤ 🧟‍♂️ 𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚 𝙈𝙖𝙥 𝙈𝙚𝙣𝙪 🧟‍♂️",
  " ➤ ☀️☀️ 𝙂𝙧𝙖𝙥𝙝𝙞𝙘𝙨 𝙈𝙚𝙣𝙪 ☀️☀️",
  " ➤ 🎯🔪 𝟬 𝘿𝙖𝙢𝙖𝙜𝙚 𝘾𝙤𝙙𝙚 🔪🎯",
  " ➤ ➖❎ 𝙄𝙢𝙢𝙤 𝙢𝙚𝙣𝙪 ❎➖",
  " ➤ 🧬👥 𝙂𝙚𝙣𝙙𝙚𝙧𝙡𝙚𝙨𝙨 𝘾𝙤𝙙𝙚 🧬👥",
  " ➤ 🚪🚪 𝙀𝙭𝙞𝙩 𝙎𝙘𝙧𝙞𝙥𝙩 🚪🚪"
}

function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end

local raw_time = os.date("%Y-%m-%d %H:%M:%S")
local fancy_time = toBoldItalic(raw_time)
gg.toast("𝙏𝙞𝙢𝙚: " .. fancy_time)
local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
local choice = gg.choice(menu, nil, title)
if choice == nil then
return
end
if  choice == 1 then
zt = 2
gg.setVisible(false)
if gg.isVisible(true) then
os.exit()
end 
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_PPSSPP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_VIDEO | gg.REGION_BAD | gg.REGION_CODE_APP | gg.REGION_CODE_SYS)
  gg.clearResults()
  gg.searchNumber(":Quit", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000)
  gg.editAll(":0", gg.TYPE_BYTE)
  gg.clearResults()
  gg.searchNumber(";Die", gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(100000)
  gg.editAll("0", gg.TYPE_WORD)
  gg.clearResults()
  gg.searchNumber(":hackCheck", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(100000)
  gg.editAll("0", gg.TYPE_BYTE)
  gg.clearResults()
  gg.searchNumber(":Ban", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  revert = gg.getResults(10000)
  gg.editAll(":0", gg.TYPE_BYTE)
  gg.clearResults()
  gg.toast("🛡️ 𝘼𝙣𝙩𝙞-𝘾𝙧𝙖𝙨𝙝 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙!")
end
if choice == 2 then
zt = 3
  qmnb = {
    {['memory'] = 32},
    {['name'] ='𝘼𝙩𝙩𝙖𝙘𝙠 𝙎𝙥𝙚𝙚𝙙 𝘾𝙤𝙙𝙚'},
    {['value'] =4629700418019000320, ['type'] = 32},
    {['lv'] = 1500.0, ['offset'] = 0x10, ['type'] = 16},
    {['lv'] = -1054867456, ['offset'] = 0x48, ['type'] = 4},
    {['lv'] = 4, ['offset'] = 0x3c, ['type'] = 4},}
    
  qmxg = {
  {['value'] =0, ['offset'] = -0xc, ['type'] = 4,['freeze']=true},
  {['value'] =100, ['offset'] = 0x38, ['type'] = 16,['freeze']=true},
  {['value'] =0, ['offset'] = 0xc0, ['type'] = 4,},
  {['value'] =-0.035, ['offset'] = 0x1ac, ['type'] = 16,['freeze']=true},
  }
  xqmnb(qmnb)
  gg.clearResults()
gg.toast("⚡ 𝙎𝙥𝙚𝙚𝙙𝙝𝙖𝙘𝙠 𝙀𝙣𝙜𝙖𝙜𝙚𝙙!")
end

if choice == 3 then
zt = 4
gg.clearResults()
local q = "9935155"
local t = gg.TYPE_FLOAT
local s = pcall(function()
    gg.searchNumber(q, t, false, gg.SIGN_EQUAL, 0, -1, 0)
end)
if not s then
os.exit()
end
gg.refineNumber(q, t)
local r = gg.getResults(100)
local function toBoldDigits(num)
    local map = {
      ['0']='𝟬', ['1']='𝟭', ['2']='𝟮', ['3']='𝟯', ['4']='𝟰',
      ['5']='𝟱', ['6']='𝟲', ['7']='𝟳', ['8']='𝟴', ['9']='𝟵'
    }
    return tostring(num):gsub(".", map)
  end
if #r < 2 then
gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. toBoldDigits(#r))
os.exit()
end 
local a = r[2].address
local b = a - 8
local c = {}
c[1] = {}
c[1].address = b
c[1].flags = t
c[1].value = "1"
c[1].freeze = true

local _, e = pcall(function()
    gg.setValues(c)
    gg.addListItems(c)
    gg.freeze(c)
end)

if not _ then
    gg.toast("❌🖨️ 𝘾𝙤𝙣𝙨 𝙋𝙤𝙨 𝘾𝙤𝙙𝙚 𝙁𝙖𝙞𝙡𝙚𝙙 ❌🖨️")
else
    gg.toast("✅📠 𝘾𝙤𝙣𝙨 𝙋𝙤𝙨 𝘾𝙤𝙙𝙚 𝙖𝙥𝙥𝙡𝙞𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 📠✅")
end
end
if choice == 4 then
zt = 5
  gg.clearResults()
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.clearResults(70)
  gg.searchNumber(";TE", gg.TYPE_WORD)
  gg.getResults(200)
  gg.editAll(";EN", gg.TYPE_WORD)
  gg.refineNumber("1", gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)

  gg.clearResults()
  gg.searchNumber(";ZEN", gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.getResults(1000)
  local t = gg.getResults(1000)
  for i, v in ipairs(t) do
      if v.flags == gg.TYPE_WORD then
          v.value = ";Ragdoll"
          v.freeze = true
      end
  end
  gg.addListItems(t)
  gg.processResume()
  gg.refineNumber("1", gg.TYPE_WORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.toast("📞 𝘾𝙖𝙡𝙡 𝘼𝙡𝙡 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙!")
  gg.clearResults()
end

if choice == 5 then
zt = 6
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.clearResults()
  gg.searchNumber(";Blood",gg.TYPE_WORD)
  gg.getResults(200)
  gg.editAll(";Infinity",gg.TYPE_WORD)
  gg.refineNumber("0", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.clearResults(70)
  gg.toast("🩸 𝘽𝙡𝙤𝙤𝙙 𝙄𝙢𝙢𝙤 𝙊𝙣!")
  gg.clearResults()
end

if choice == 6 then
zt = 7
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.clearResults()
  gg.searchNumber(";Infin",gg.TYPE_WORD)
  gg.getResults(200)
  gg.editAll(";Blood",gg.TYPE_WORD)
  gg.refineNumber("0", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.clearResults(70)
  gg.toast("❌ 𝘽𝙡𝙤𝙤𝙙 𝙄𝙢𝙢𝙤 𝙊𝙛𝙛")
  gg.clearResults()
end

if choice == 7 then
zt = 8
 gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("1034147594", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.processResume()
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("1111111111", gg.TYPE_DWORD)
gg.processResume()
gg.refineNumber("0", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.clearResults(70)
 gg.toast("🕊️ 𝙁𝙡𝙮 𝙈𝙤𝙙𝙚 𝙊𝙣!")
end

if choice == 8 then
zt = 9
gg.clearResults()
 gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("1111111111", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
revert = gg.getResults(1000, nil, nil, nil, nil, nil, nil, nil, nil)
gg.editAll("1034147594", gg.TYPE_DWORD)
gg.refineNumber("0", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.clearResults(70)
gg.toast("🛑 𝙁𝙡𝙮 𝙈𝙤𝙙𝙚 𝙊𝙛𝙛!")
end
if choice == 9 then
zt = 10
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.clearResults()
  gg.searchNumber(";Name", gg.TYPE_WORD)
  gg.getResults(999)
  gg.editAll(";Deactivate", gg.TYPE_WORD)
  gg.clearResults()
  gg.searchNumber(";WHORE", gg.TYPE_WORD)
  gg.getResults(999)
  gg.editAll(";Point", gg.TYPE_WORD)
  gg.toast("📈 𝙋𝙊𝙎 𝙀𝙓𝙋 𝙊𝙣")
  gg.clearResults()
end

if choice == 10 then
zt = 11
  gg.clearResults()
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.searchNumber(";Deac", gg.TYPE_WORD)
  gg.getResults(999)
  gg.editAll(";Name", gg.TYPE_WORD)
  gg.clearResults()
  gg.searchNumber(";Point", gg.TYPE_WORD)
  gg.getResults(999)
  gg.editAll(";WHORE", gg.TYPE_WORD)
  gg.toast("📉 𝙋𝙤𝙨 𝙀𝙓𝙋 𝙊𝙛𝙛")
  gg.clearResults()
end

if choice == 11 then
zt = 12
  gg.clearResults()
  gg.setRanges(gg.REGION_ANONYMOUS)
  gg.searchNumber(';Chat',gg.TYPE_WORD)
  gg.getResults(100)
  gg.editAll(';Cha',gg.TYPE_WORD)
  gg.toast("♾️ 𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝙋𝙤𝙨 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙!")
  gg.clearResults()
end

if choice  == 12 then
  zt = 13
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_PPSSPP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_VIDEO | gg.REGION_BAD | gg.REGION_CODE_APP | gg.REGION_CODE_SYS)
  gg.clearResults()
  gg.alert("⚔️ 𝙔𝙤𝙪 𝙣𝙚𝙚𝙙𝙖 𝟭𝟬𝟬𝟬 𝘼𝙏𝙏, 𝟭𝟬𝟬𝟬 𝘿𝙀𝙁, 𝟴𝟬𝟬 𝙎𝙥𝙚𝙚𝙙 & 𝟭𝟬𝟬𝟬 𝙃𝙚𝙖𝙡𝙩𝙝 𝙩𝙤 𝙥𝙧𝙤𝙘𝙚𝙚𝙙! 🏃‍♂️🔓")
  gg.clearResults()
  gg.toast("💥 𝙎𝙩𝙖𝙧𝙩𝙞𝙣𝙜 𝘾𝙧𝙖𝙨𝙝-𝙘𝙤𝙙𝙚 𝙨𝙚𝙖𝙧𝙘𝙝...")
  gg.searchNumber("1000;1000;800;1000::", gg.TYPE_WORD, false, gg.SIGN_EQUAL, gg.REGION_JAVA_HEAP | gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_PPSSPP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_VIDEO | gg.REGION_BAD | gg.REGION_CODE_APP | gg.REGION_CODE_SYS)
  local results = gg.getResults(4)

  local function toBoldDigits(num)
    local map = {
      ['0']='𝟬', ['1']='𝟭', ['2']='𝟮', ['3']='𝟯', ['4']='𝟰',
      ['5']='𝟱', ['6']='𝟲', ['7']='𝟳', ['8']='𝟴', ['9']='𝟵'
    }
    return tostring(num):gsub(".", map)
  end

  if #results ~= 4 then
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟰 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. toBoldDigits(#results))
    gg.clearResults()
  else
    gg.toast("🔎 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡! 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮...")
    gg.gotoAddress(results[1].address)
    local selected = {
      {address = results[1].address, flags = gg.TYPE_DWORD},
      {address = results[1].address - 4, flags = gg.TYPE_DWORD},
      {address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = -444544
    selected[2].value = 571081842
    selected[3].value = -571264014
    gg.setValues(selected)
    gg.toast("✅ 𝘾𝙧𝙖𝙨𝙝-𝙘𝙤𝙙𝙚 𝙖𝙥𝙥𝙡𝙞𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮!")
  end
end

if choice == 13 then
zt = 14
gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_PPSSPP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_VIDEO | gg.REGION_BAD | gg.REGION_CODE_APP | gg.REGION_CODE_SYS)
  function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end

  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
    gg.gotoAddress(results[1].address)
    local selected = {
        {address = results[1].address, flags = gg.TYPE_DWORD},
        {address = results[1].address - 4, flags = gg.TYPE_DWORD},{address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = 930
    selected[2].value = 1142850811
    selected[3].value = 1142851417
    gg.setValues(selected)
    gg.toast("✅✨ 𝙑𝙖𝙡𝙪𝙚𝙨 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 🚀\n💎 𝟰𝙆-𝙋𝙊𝙎 𝘾𝙤𝙙𝙚 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙")
    gg.clearResults()
    end
if choice == 14 then
zt = 15
function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end

local menu = {
  "➤📱 𝘾𝙝𝙖𝙣𝙜𝙚 𝘼𝙣𝙞𝙢𝙖𝙡 𝘾𝙤𝙙𝙚 📱",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝙃𝙚𝙧𝙗𝙞𝙫𝙤𝙪𝙧𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝘾𝙖𝙧𝙣𝙞𝙫𝙤𝙪𝙧𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝙊𝙢𝙣𝙞𝙫𝙤𝙪𝙧𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝘽𝙞𝙧𝙙𝙨",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝙕𝙤𝙢𝙗𝙞𝙚𝙨",
  "➤ 𝙇𝙞𝙨𝙩 𝙤𝙛 𝙁𝙞𝙨𝙝𝙚𝙨",
  "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
}

function subMenu()
  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
  "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
  "➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
  "➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
  "➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
  "➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
  "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return
  end

  if choice == 1 then
    function isUTF16(utf16)
  local stringTag
  local addressJump
  if utf16 == true then
    stringTag = ';'
    addressJump = 2
  else
    stringTag = ':'
    addressJump = 1
  end
  return stringTag, addressJump
end

function setNewName()
  local stringTag, addressJump = isUTF16(playername[2])
  local t = gg.getResults(gg.getResultsCount())
  local replaceString = {}
  local stringSize = {}
  local str = {}
  gg.clearResults()
  for i= 1, #editname[1] do
    str[i] = string.sub(editname[1], i, j)
  end
  for i = 1, #t do
    stringSize[#stringSize + 1] = {address = t[i].address - 0x4, flags = gg.TYPE_WORD}
    for charCount = 1, #editname[1] do
      replaceString[#replaceString + 1] = {address = t[i].address, flags = gg.TYPE_WORD, value = string.byte(string.sub(str[charCount], 1, 1))}
      t[i].address = t[i].address + addressJump
    end
  end
  stringSize = gg.getValues(stringSize)
  for i, v in ipairs(stringSize) do
    if v.value == #playername[1] then
      v.value = #editname[1]
    end
  end
  gg.setValues(stringSize)
  gg.setValues(replaceString)
  gg.toast('𝙏𝙧𝙖𝙣𝙨𝙛𝙤𝙧𝙢𝙖𝙩𝙞𝙤𝙣/𝘾𝙝𝙖𝙣𝙜𝙞𝙣𝙜 𝙖𝙣𝙞𝙢𝙖𝙡 𝙎𝙘𝙧𝙞𝙥𝙩 𝙛𝙤𝙧 𝙒𝘼𝙊 𝟵.𝟬.𝟬')
  gg.alert('💱𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣 𝙏𝙤 𝙖𝙥𝙥𝙡𝙮 𝙏𝙝𝙚 𝙘𝙝𝙖𝙣𝙜𝙚𝙨💱')
end

function findName()
  local stringTag, addressJump = isUTF16(playername[2])
  gg.searchNumber(stringTag..playername[1])
  local a = gg.getResults(gg.getResultsCount())
  if #a == 0 then
    gg.toast("❌ 𝘼𝙣𝙞𝙢𝙖𝙡'𝙨 𝙣𝙖𝙢𝙚 𝙣𝙤𝙩 𝙛𝙤𝙪𝙣𝙙, 𝙋𝙡𝙚𝙖𝙨𝙚 𝙩𝙧𝙮 𝙖𝙜𝙖𝙞𝙣 ❌")
  else
    local stringLength = #playername[1]
    for i = 1, stringLength do
      gg.refineNumber(stringTag..string.sub(playername[1], 1, stringLength))
      stringLength = stringLength - 1
    end
    prompt_edit()
  end
end

function noselect()
  gg.toast("𝘾𝙖𝙣𝙘𝙚𝙡𝙚𝙙")
  return subMenu()
end

function prompt_edit()
  editname = gg.prompt(
    {[1] = '𝙏𝙧𝙖𝙣𝙨𝙛𝙤𝙧𝙢𝙖𝙩𝙞𝙤𝙣/𝘾𝙝𝙖𝙣𝙜𝙞𝙣𝙜 𝙖𝙣𝙞𝙢𝙖𝙡 𝙎𝙘𝙧𝙞𝙥𝙩 𝙛𝙤𝙧 𝙒𝘼𝙊 𝟵.𝟬.𝟬'},
    {[1] = 'Character Controller_'},
    {[1] = 'text'})
  if editname == nil then 
    noselect()
    gg.clearResults()
  else
    setNewName()
  end
end

function prompt_search()
  playername = gg.prompt(
    {[1] = '𝙏𝙧𝙖𝙣𝙨𝙛𝙤𝙧𝙢𝙖𝙩𝙞𝙤𝙣/𝘾𝙝𝙖𝙣𝙜𝙞𝙣𝙜 𝙖𝙣𝙞𝙢𝙖𝙡 𝙎𝙘𝙧𝙞𝙥𝙩 𝙛𝙤𝙧 𝙒𝘼𝙊 𝟵.𝟬.𝟬.' ,[2] = '📱𝙊𝙣 𝘽𝙧𝙚𝙖𝙠 𝙇𝙞𝙢𝙞𝙩 𝙛𝙪𝙣𝙘𝙩𝙞𝙤𝙣📱'},
    {[1] = 'Character Controller_'          ,[2] = false},
    {[1] = 'text'       ,[2] = 'checkBox'})
  if playername == nil then
    noselect()
  else
    findName()
  end
end
prompt_search()
end

  if choice == 2 then
    gg.alert([[
𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝘼𝙣𝙞𝙢𝙖𝙡 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙃𝙚𝙧𝙗𝙞𝙫𝙤𝙪𝙧𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨 𝙉𝙖𝙢𝙚

𝙇𝙞𝙨𝙩:

• 𝘿𝙚𝙚𝙧_𝙈
• 𝘿𝙚𝙚𝙧_𝙒
• 𝙂𝙖𝙯𝙚𝙡𝙡𝙚
• 𝙕𝙚𝙗𝙧𝙖
• 𝘾𝙖𝙢𝙚𝙡
• 𝙎𝙝𝙚𝙚𝙥_𝙈
• 𝙎𝙝𝙚𝙚𝙥_𝙒
• 𝘿𝙤𝙣𝙠𝙚𝙮
• 𝘽𝙪𝙛𝙛𝙖𝙡𝙤
• 𝙈𝙤𝙤𝙨𝙚_𝙈
• 𝙈𝙤𝙤𝙨𝙚_𝙒
• 𝙂𝙞𝙧𝙖𝙛𝙛𝙚
• 𝙂𝙤𝙧𝙞𝙡𝙡𝙖
• 𝙍𝙝𝙞𝙣𝙤𝙘𝙚𝙧𝙤𝙨
• 𝙀𝙡𝙚𝙥𝙝𝙖𝙣𝙩
• 𝙇𝙤𝙣𝙜𝙝𝙤𝙧𝙣𝘾𝙤𝙬_𝙈
• 𝙇𝙤𝙣𝙜𝙝𝙤𝙧𝙣𝘾𝙤𝙬_𝙒
• 𝙏𝙖𝙥𝙞𝙧
• 𝘾𝙤𝙬
• 𝙃𝙤𝙧𝙨𝙚
• 𝙒𝙞𝙡𝙙𝙚𝙗𝙚𝙚𝙨𝙩
• 𝘾𝙖𝙥𝙮𝙗𝙖𝙧𝙖
• 𝘽𝙚𝙖𝙫𝙚𝙧
• 𝘼𝙢𝙚𝙧𝙞𝙘𝙖𝙣𝘽𝙪𝙛𝙛𝙖𝙡𝙤
• 𝘼𝙡𝙥𝙞𝙣𝙚𝙡𝙗𝙚𝙭
• 𝙏𝙧𝙚𝙚-𝙠𝙖𝙣𝙜𝙖𝙧𝙤𝙤
• 𝙒𝙖𝙡𝙡𝙖𝙗𝙮
• 𝙆𝙤𝙖𝙡𝙖
• 𝙈𝙪𝙨𝙠𝙤𝙭
]])
return subMenu()
  end

  if choice == 3 then
    gg.alert([[
𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝘼𝙣𝙞𝙢𝙖𝙡 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝘾𝙖𝙧𝙣𝙞𝙫𝙤𝙧𝙤𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨 𝙉𝙖𝙢𝙚

𝙇𝙞𝙨𝙩:

• 𝙁𝙤𝙭
• 𝙒𝙤𝙡𝙛
• 𝙃𝙮𝙚𝙣𝙖
• 𝘾𝙝𝙚𝙚𝙩𝙖𝙝
• 𝙇𝙚𝙤𝙥𝙖𝙧𝙙
• 𝙇𝙮𝙣𝙭
• 𝙋𝙤𝙡𝙖𝙧𝘽𝙚𝙖𝙧
• 𝘾𝙧𝙤𝙘𝙤𝙙𝙞𝙡𝙚
• 𝘽𝙚𝙖𝙧
• 𝙇𝙞𝙤𝙣_𝙈
• 𝙇𝙞𝙤𝙣_𝙒
• 𝙏𝙞𝙜𝙚𝙧
• 𝙋𝙚𝙣𝙜𝙪𝙞𝙣
• 𝙎𝙣𝙖𝙠𝙚
• 𝙁𝙚𝙣𝙣𝙚𝙘
• 𝙆𝙤𝙢𝙤𝙙𝙤𝘿𝙧𝙖𝙜𝙤𝙣
• 𝙂𝙤𝙡𝙞𝙖𝙩𝙝𝙎𝙥𝙞𝙙𝙚𝙧
• 𝙂𝙞𝙖𝙣𝙩𝘼𝙣𝙩𝙚𝙖𝙩𝙚𝙧
• 𝙎𝙘𝙤𝙧𝙥𝙞𝙤𝙣
• 𝘾𝙡𝙤𝙪𝙙𝙚𝙙𝙇𝙚𝙤𝙥𝙖𝙧𝙙
• 𝙁𝙧𝙞𝙡𝙡_𝙣𝙚𝙘𝙠𝙚𝙙_𝙇𝙞𝙯𝙖𝙧𝙙
• 𝙍𝙖𝙩𝙩𝙡𝙚𝙨𝙣𝙖𝙠𝙚
• 𝘾𝙤𝙗𝙧𝙖
• 𝙎𝙣𝙤𝙬_𝙇𝙚𝙤𝙥𝙖𝙧𝙙
• 𝙅𝙖𝙘𝙠𝙖𝙡
• 𝘼𝙛𝙧𝙞𝙘𝙖𝙣𝙒𝙞𝙡𝙙𝘿𝙤𝙜
• 𝙏𝙖𝙨𝙢𝙖𝙣𝙞𝙖𝙣_𝘿𝙚𝙫𝙞𝙡
]])
return subMenu()
  end

  if choice == 4 then
    gg.alert([[
𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝘼𝙣𝙞𝙢𝙖𝙡 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙊𝙢𝙣𝙞𝙫𝙤𝙧𝙤𝙪𝙨 𝘼𝙣𝙞𝙢𝙖𝙡𝙨 𝙉𝙖𝙢𝙚

𝙇𝙞𝙨𝙩:

• 𝘽𝙤𝙖𝙧_𝙈
• 𝘽𝙤𝙖𝙧_𝙒
• 𝙊𝙨𝙩𝙧𝙞𝙘𝙝
• 𝙃𝙞𝙥𝙥𝙤
• 𝙆𝙖𝙣𝙜𝙖𝙧𝙤𝙤
• 𝙋𝙖𝙣𝙙𝙖
• 𝙍𝙖𝙘𝙘𝙤𝙤𝙣
• 𝘼𝙧𝙢𝙖𝙙𝙞𝙡𝙡𝙤
• 𝙏𝙪𝙧𝙩𝙡𝙚
• 𝙊𝙩𝙩𝙚𝙧
• 𝙒𝙖𝙡𝙧𝙪𝙨
• 𝙍𝙚𝙙𝙥𝙖𝙣𝙙𝙖
• 𝙈𝙚𝙚𝙧𝙠𝙖𝙩
• 𝙈𝙖𝙧𝙩𝙚𝙣
• 𝙈𝙖𝙧𝙢𝙤𝙩
• 𝙃𝙚𝙙𝙜𝙚𝙝𝙤𝙜
• 𝙈𝙤𝙡𝙚
• 𝙃𝙞𝙡𝙡𝙨𝙍𝙪𝙛𝙛𝙚𝙙𝙇𝙚𝙢𝙪𝙧
• 𝘾𝙖𝙥𝙪𝙘𝙝𝙞𝙣_𝙈𝙤𝙣𝙠𝙚𝙮
• 𝙍𝙞𝙣𝙜𝙏𝙖𝙞𝙡𝙚𝙙_𝙇𝙚𝙢𝙪𝙧
• 𝙈𝙖𝙘𝙖𝙦𝙪𝙚
• 𝙋𝙞𝙜
]])
return subMenu()
  end

  if choice == 5 then
    gg.alert([[𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝘼𝙣𝙞𝙢𝙖𝙡 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝘽𝙞𝙧𝙙𝙨 𝙉𝙖𝙢𝙚 𝙇𝙞𝙨𝙩:

• 𝘾𝙧𝙤𝙬  
• 𝙋𝙞𝙜𝙚𝙤𝙣  
• 𝙎𝙥𝙖𝙧𝙧𝙤𝙬  
• 𝘽𝙖𝙧𝙣𝙊𝙬𝙡  
• 𝙑𝙤𝙜𝙚𝙡  
• 𝙍𝙚𝙙𝘾𝙧𝙤𝙬𝙣𝙚𝙙𝘾𝙧𝙖𝙣𝙚  
• 𝘽𝙖𝙡𝙙𝙀𝙖𝙜𝙡𝙚  
• 𝙃𝙖𝙧𝙥𝙮𝙀𝙖𝙜𝙡𝙚  
• 𝙎𝙚𝙘𝙧𝙚𝙩𝙖𝙧𝙮𝘽𝙞𝙧𝙙  
• 𝙎𝙚𝙖𝙜𝙪𝙡𝙡  
• 𝙎𝙤𝙪𝙩𝙝𝙚𝙧𝙣𝘾𝙖𝙨𝙨𝙤𝙬𝙖𝙧𝙮  
• 𝙈𝙤𝙖  
• 𝙑𝙪𝙡𝙩𝙪𝙧𝙚  
• 𝙁𝙖𝙡𝙘𝙤𝙣  
• 𝙍𝙖𝙫𝙚𝙣  
• 𝙎𝙣𝙤𝙬𝙮𝙊𝙬𝙡  
• 𝙃𝙚𝙣𝙃𝙖𝙧𝙧𝙞𝙚𝙧  
• 𝘾𝙝𝙞𝙘𝙠𝙚𝙣
]])
return subMenu()
  end

  if choice == 6 then
    gg.alert([[𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝙕𝙤𝙢𝙗𝙞𝙚 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙕𝙤𝙢𝙗𝙞𝙚𝙨 𝙉𝙖𝙢𝙚 𝙇𝙞𝙨𝙩:

• 𝙕𝙤𝙢𝙗𝙞𝙚_𝘼  
• 𝙕𝙤𝙢𝙗𝙞𝙚_𝘽  
• 𝙕𝙤𝙢𝙗𝙞𝙚_𝘼_𝙐𝙥  
• 𝙕𝙤𝙢𝙗𝙞𝙚_𝘽_𝙐𝙥  
• 𝙊𝙡𝙙𝙈𝙖𝙣𝙕𝙤𝙢𝙗𝙞𝙚  
• 𝘽𝙞𝙜𝙕𝙤𝙢𝙗𝙞𝙚  
• 𝙐𝙧𝙗𝙖𝙣𝙕𝙤𝙢𝙗𝙞𝙚  
• 𝙂𝙞𝙖𝙣𝙩_𝙕𝙤𝙢𝙗𝙞𝙚
]])
return subMenu()
  end

  if choice == 7 then
    gg.alert([[𝙒𝙚𝙡𝙘𝙤𝙢𝙚 𝙩𝙤 𝙁𝙞𝙨𝙝𝙚𝙨 𝙈𝙤𝙙𝙞𝙛𝙞𝙚𝙧 𝙈𝙚𝙣𝙪

𝘼𝙫𝙖𝙞𝙡𝙖𝙗𝙡𝙚 𝙁𝙞𝙨𝙝𝙚𝙨 𝙉𝙖𝙢𝙚 𝙇𝙞𝙨𝙩:

• 𝙁𝙡𝙮𝙞𝙣𝙜𝙁𝙞𝙨𝙝  
• 𝘽𝙖𝙧𝙧𝙖𝙘𝙪𝙙𝙖  
• 𝙏𝙪𝙣𝙖  
• 𝙎𝙖𝙞𝙡𝙛𝙞𝙨𝙝  
• 𝙎𝙬𝙤𝙧𝙙𝙛𝙞𝙨𝙝  
• 𝙎𝙪𝙣𝙛𝙞𝙨𝙝  
• 𝘽𝙚𝙡𝙪𝙜𝙖  
• 𝘽𝙡𝙪𝙚_𝙎𝙝𝙖𝙧𝙠  
• 𝘽𝙡𝙪𝙚_𝙒𝙝𝙖𝙡𝙚  
• 𝘽𝙤𝙩𝙩𝙡𝙚𝙣𝙤𝙨𝙚_𝘿𝙤𝙡𝙥𝙝𝙞𝙣  
• 𝘽𝙪𝙡𝙡_𝙎𝙝𝙖𝙧𝙠  
• 𝘾𝙖𝙘𝙝𝙖𝙡𝙤𝙩  
• 𝘾𝙝𝙞𝙣𝙚𝙨𝙚_𝘿𝙤𝙡𝙥𝙝𝙞𝙣  
• 𝘾𝙤𝙢𝙢𝙤𝙣_𝙎𝙩𝙞𝙣𝙜𝙧𝙖𝙮  
• 𝙀𝙖𝙜𝙡𝙚_𝙍𝙖𝙮  
• 𝙂𝙪𝙞𝙩𝙖𝙧_𝙎𝙩𝙞𝙣𝙜𝙧𝙖𝙮  
• 𝙃𝙖𝙢𝙢𝙚𝙧𝙝𝙚𝙖𝙙_𝙎𝙝𝙖𝙧𝙠  
• 𝙃𝙖𝙧𝙗𝙤𝙪𝙧_𝙋𝙤𝙧𝙥𝙤𝙞𝙨𝙚  
• 𝙃𝙪𝙢𝙥𝙗𝙖𝙘𝙠_𝙒𝙝𝙖𝙡𝙚  
• 𝙄𝙧𝙧𝙖𝙬𝙖𝙙𝙙𝙮_𝘿𝙤𝙡𝙥𝙝𝙞𝙣  
• 𝙇𝙤𝙣𝙜_𝘽𝙞𝙡𝙡𝙚𝙙_𝘿𝙤𝙡𝙥𝙝𝙞𝙣  
• 𝙈𝙖𝙣𝙩𝙖_𝙍𝙖𝙮  
• 𝙉𝙖𝙧𝙬𝙝𝙖𝙡  
• 𝙎𝙝𝙖𝙧𝙠_𝙍𝙖𝙮  
• 𝙏𝙞𝙜𝙚𝙧_𝙎𝙝𝙖𝙧𝙠  
• 𝙒𝙝𝙞𝙩𝙚_𝙎𝙝𝙖𝙧𝙠  
• 𝙒𝙝𝙖𝙡𝙚_𝙎𝙝𝙖𝙧𝙠
]])
return subMenu()
  end

  if choice == 8 then
    mainMenu()
  end
end
subMenu()
end
if choice == 15 then 
zt = 16
gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(";SetBed", gg.TYPE_WORD)
    gg.getResults(6)
    gg.editAll(";0", gg.TYPE_WORD)
    gg.toast("💯💯𝙎𝙪𝙘𝙘𝙚𝙨𝙨! 𝙉𝙤𝙬 𝙮𝙤𝙪 𝙬𝙤𝙣'𝙩 𝙜𝙚𝙩 𝙖𝙣𝙮 𝙙𝙞𝙨𝙡𝙞𝙠𝙚𝙨!")
gg.clearResults()
end
if choice == 16 then
zt = 17
qmnb = {
    {['memory'] = 32},
    {['name'] ='️𝘾𝙧𝙤𝙨𝙨𝙞𝙣𝙜-𝘽𝙤𝙧𝙙𝙚𝙧𝙨 𝘾𝙤𝙙𝙚'},
    {['value'] =4561245704552448000, ['type'] = 32},
    {['lv'] = 1060439283, ['offset'] = -0x228, ['type'] = 4},
  }
  qmxg = {
    {['value'] =99, ['offset'] = -0x20c, ['type'] = 16},
  }
  xqmnb(qmnb)
  gg.clearResults()
end
if choice == 17 then
zt = 18
qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙐𝙣𝙡𝙞𝙢𝙞𝙩𝙚𝙙 𝙋𝙤𝙞𝙣𝙩𝙨 𝘾𝙤𝙙𝙚'},
    {['value'] =1103806595092, ['type'] = 32},
    {['lv'] = 257, ['offset'] = -0x3C, ['type'] = 4},
    }
   qmxg = {
   {['value'] =-2, ['offset'] = -0x20, ['type'] = 4,['freeze'] = true},
   {['value'] =-0, ['offset'] = -0x1C, ['type'] = 4,['freeze'] = true},
    }
    xqmnb(qmnb)
   gg.clearResults()
  end 
if choice == 18 then
zt = 19
qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝘾𝙖𝙡𝙡 𝘾𝙤𝙙𝙚'},
    {['value'] =4629700418019000320, ['type'] = 32},
    {['lv'] = 1500.0, ['offset'] = 0x10, ['type'] = 16},
    {['lv'] = -1054867456, ['offset'] = 0x48, ['type'] = 4},
    {['lv'] = 4, ['offset'] = 0x3c, ['type'] = 4},
    }
  qmxg = {
    {['value'] =0, ['offset'] = 0x174, ['type'] = 4},
    }
  xqmnb(qmnb)
  gg.clearResults()
end
if choice == 19 then
zt = 20
qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙌𝙪𝙞𝙘𝙠 𝘽𝙡𝙤𝙤𝙙 𝙍𝙚𝙘𝙤𝙫𝙚𝙧𝙮 𝘾𝙤𝙙𝙚'},
    {['value'] =4629700418019000320, ['type'] = 32},
    {['lv'] = 1500.0, ['offset'] = 0x10, ['type'] = 16},
    {['lv'] = -1054867456, ['offset'] = 0x48, ['type'] = 4},
    {['lv'] = 4, ['offset'] = 0x3c, ['type'] = 4},
    }
  qmxg = {
    {['value'] =100, ['offset'] = 0x12c, ['type'] = 16,['freeze']=true},
    {['value'] =0, ['offset'] = 0x134, ['type'] = 16,['freeze']=true},
  }
  xqmnb(qmnb)
  gg.clearResults()
end
if choice == 20 then
zt = 21
qmnb = {
    {['memory'] = 32},
    {['name'] ='𝘾𝙧𝙤𝙨𝙨𝙞𝙣𝙜 𝘽𝙤𝙧𝙙𝙚𝙧𝙨 𝘾𝙤𝙙𝙚 𝙊𝙛𝙛'},
    {['value'] =4561245704552448000, ['type'] = 32},
    {['lv'] = 1060439283, ['offset'] = -0x228, ['type'] = 4},
  }
  qmxg = {
    {['value'] =0.07, ['offset'] = -0x210, ['type'] = 16},
    {['value'] =0.3, ['offset'] = -0x20c, ['type'] = 16},
  }
  xqmnb(qmnb)
  gg.clearResults()
end
if choice == 21 then
zt = 22
local xh = gg.prompt({"𝙔𝙤𝙪 𝙘𝙖𝙣 𝙤𝙣𝙡𝙮 𝙚𝙣𝙩𝙚𝙧 𝙤𝙣𝙚 𝙘𝙝𝙖𝙧𝙖𝙘𝙩𝙚𝙧, 𝙩𝙝𝙖𝙩 𝙞𝙨, 𝙖𝙣 𝙞𝙘𝙤𝙣 𝙤𝙧 𝙬𝙤𝙧𝙙. 𝙩𝙝𝙚 𝙨𝙘𝙧𝙞𝙥𝙩 𝙬𝙞𝙡𝙡 𝙖𝙪𝙩𝙤𝙢𝙖𝙩𝙞𝙘𝙖𝙡𝙡𝙮 𝙚𝙣𝙩𝙚𝙧 𝙩𝙝𝙚 (;) 𝙨𝙮𝙢𝙗𝙤𝙡. 𝙔𝙤𝙪 𝙤𝙣𝙡𝙮 𝙣𝙚𝙚𝙙 𝙩𝙤 𝙛𝙞𝙡𝙡 𝙞𝙣 𝙩𝙝𝙚 𝙨𝙮𝙢𝙗𝙤𝙡 𝙮𝙤𝙪 𝙬𝙖𝙣𝙩 𝙩𝙤 𝙢𝙤𝙙𝙞𝙛𝙮. 𝙏𝙝𝙚 𝙛𝙤𝙡𝙡𝙤𝙬𝙞𝙣𝙜 𝙘𝙝𝙖𝙧𝙖𝙘𝙩𝙚𝙧 𝙘𝙖𝙣 𝙗𝙚 𝙪𝙨𝙚𝙙 𝙬𝙞𝙩𝙝𝙤𝙪𝙩 𝙜𝙚𝙣𝙙𝙚𝙧 𝙗𝙚𝙘𝙖𝙪𝙨𝙚 𝙩𝙝𝙚 𝙜𝙖𝙢𝙚 𝙘𝙖𝙣𝙣𝙤𝙩 𝙧𝙚𝙘𝙤𝙜𝙣𝙞𝙯𝙚 𝙞𝙩."}, {"❦"}, {"text"})
if xh == nil then gg.alert('𝙔𝙤𝙪 𝙘𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙩𝙝𝙚 𝙚𝙣𝙩𝙧𝙮')
else
 qmnb = {
   {['memory'] = 32},
   {['name'] ='𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚𝙙 𝙂𝙚𝙣𝙙𝙚𝙧 𝙄𝙘𝙤𝙣𝙨'},
   {['value'] =27584938559668243, ['type'] = 32},
   {['lv'] = 91, ['offset'] = 0x4, ['type'] = 2},
   }
 qmxg = {
   {['value'] =';'..xh[1], ['offset'] = 0x1A, ['type'] = 2},
   }
  xqmnb(qmnb)
  end 
  gg.clearResults()
 end
if choice == 22 then
zt = 23
local xh=gg.prompt({"𝙏𝙝𝙚 𝙘𝙤𝙡𝙤𝙧 𝙘𝙤𝙙𝙚 𝙞𝙨 𝘽𝙖𝙞𝙙𝙪'𝙨 𝙝𝙚𝙭𝙖𝙙𝙚𝙘𝙞𝙢𝙖𝙡 𝙘𝙤𝙡𝙤𝙧 𝙘𝙤𝙙𝙚 𝙩𝙖𝙗𝙡𝙚, 𝙤𝙣𝙚 𝙞𝙣𝙥𝙪𝙩 𝙗𝙤𝙭 𝙛𝙤𝙧 𝙤𝙣𝙚 𝙬𝙤𝙧𝙙, 𝙩𝙖𝙠𝙚 𝙩𝙝𝙚 𝙛𝙤𝙡𝙡𝙤𝙬𝙞𝙣𝙜 𝙖𝙨 𝙖𝙣 𝙚𝙭𝙖𝙢𝙥𝙡𝙚",'','','','','',},{'9','9','f','f','3','3',})
if xh == nil then gg.alert('𝙔𝙤𝙪 𝙘𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙩𝙝𝙚 𝙀𝙣𝙩𝙧𝙮') 
else
qmnb = {
{['memory'] = 32},
{['name'] ='𝘾𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚 𝙄𝙘𝙤𝙣 𝙘𝙤𝙡𝙤𝙧'},
{['value'] =27584938559668243, ['type'] = 32},
{['lv'] = 25614622319050843, ['offset'] = 0x4, ['type'] = 32},
 }
qmxg = {
{['value'] =';'..xh[1], ['offset'] = 0xC, ['type'] = 2},
{['value'] =';'..xh[2], ['offset'] = 0xE, ['type'] = 2},
{['value'] =';'..xh[3], ['offset'] = 0x10, ['type'] = 2},
{['value'] =';'..xh[4], ['offset'] = 0x12, ['type'] = 2},
{['value'] =';'..xh[5], ['offset'] = 0x14, ['type'] = 2},
{['value'] =';'..xh[6], ['offset'] = 0x16, ['type'] = 2},
}
xqmnb(qmnb)
gg.clearResults() 
end 
end
if choice == 23 then
zt = 24
qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙄𝙣𝙛𝙞𝙣𝙞𝙩𝙚 𝙋𝙤𝙬𝙚𝙧'},
    {['value'] =4629700418019000320, ['type'] = 32},
    {['lv'] = 1500.0, ['offset'] = 0x10, ['type'] = 16},
    {['lv'] = -1054867456, ['offset'] = 0x48, ['type'] = 4},
    {['lv'] = 4, ['offset'] = 0x3c, ['type'] = 4},
    }
  qmxg = {
    {['value'] =0, ['offset'] = 0xc0, ['type'] = 4,},
   }
  xqmnb(qmnb)
  gg.clearResults()
 end
if choice == 24 then
zt = 25
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber(";ZEN", gg.TYPE_WORD)
    gg.getResults(200)
    gg.editAll(";LQJ", gg.TYPE_WORD)
    gg.clearResults()
    gg.searchNumber(";Ragdoll", gg.TYPE_WORD)
    gg.getResults(200)
    gg.editAll(";Hoeshit", gg.TYPE_WORD)
    gg.clearResults()
end
if choice == 25 then
zt = 26
xh=gg.prompt({'𝘾𝙪𝙨𝙩𝙤𝙢 𝙎𝙥𝙚𝙚𝙙[0;10000]'},nil,{'number'})
if xh == nil then gg.alert('𝙔𝙤𝙪 𝙘𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙩𝙝𝙚 𝙚𝙣𝙩𝙧𝙮') 
else
 qmnb = {
    {['memory'] = 32},
    {['name'] ='𝘾𝙪𝙨𝙩𝙤𝙢 𝙎𝙥𝙚𝙚𝙙'},
    {['value'] =4629700418019000320, ['type'] = 32},
    {['lv'] = 1500.0, ['offset'] = 0x10, ['type'] = 16},
    {['lv'] = -1054867456, ['offset'] = 0x48, ['type'] = 4},
    {['lv'] = 4, ['offset'] = 0x3c, ['type'] = 4},
    }
 qmxg = {
    {['value'] =xh[1], ['offset'] = 0x38, ['type'] = 16,['freeze']=true},
    }
  xqmnb(qmnb)
  gg.clearResults()
end
end
if choice == 26 then
zt = 27
 local xh=gg.prompt({'𝘾𝙪𝙨𝙩𝙤𝙢 𝙨𝙘𝙤𝙥𝙚(𝙖𝙩𝙩𝙖𝙘𝙠 𝙧𝙖𝙣𝙜𝙚)[2;10000]'},nil,{'number'})
 if xh == nil then gg.alert('𝙔𝙤𝙪 𝙘𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙩𝙝𝙚 𝙚𝙣𝙩𝙧𝙮') 
 else
 qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙖𝙩𝙩𝙖𝙘𝙠 𝙧𝙖𝙣𝙜𝙚 𝙘𝙪𝙨𝙩𝙤𝙢𝙞𝙯𝙚'},
    {['value'] =481036337422, ['type'] = 32},
    {['lv'] = 1160650151690, ['offset'] = -0x4, ['type'] = 32},
    {['lv'] = 0, ['offset'] = 0x8, ['type'] = 4},
    }
  qmxg = {
    {['value'] =xh[1], ['offset'] = 0xc, ['type'] = 16},
    }
  xqmnb(qmnb)
  gg.clearResults()
 end
end
if choice == 27 then
  zt = 28

  function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end
  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
  gg.gotoAddress(results[1].address)

  local selected = {
    {address = results[1].address, flags = gg.TYPE_DWORD},
    {address = results[1].address - 4, flags = gg.TYPE_DWORD},
    {address = results[1].address - 8, flags = gg.TYPE_DWORD}
  }

  selected[1].value = 97
  selected[2].value = 2086923320
  selected[3].value = 2086923353

  gg.setValues(selected)
  gg.toast("✅✨ 𝙑𝙖𝙡𝙪𝙚𝙨 𝙐𝙥𝙙𝙖𝙩𝙚𝙙 𝙎𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮 🚀")
  gg.clearResults()
end
if choice == 28 then
zt = 29
local xh=gg.prompt({'𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙤𝙬𝙚𝙧 𝙎𝙘𝙤𝙥𝙚(𝙋𝙤𝙬𝙚𝙧 𝘼𝙩𝙩𝙖𝙘𝙠 𝙍𝙖𝙣𝙜𝙚)[2;1000]'},nil,{'number'})
 if xh == nil then gg.alert('𝙔𝙤𝙪 𝘾𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙏𝙝𝙚 𝙀𝙣𝙩𝙧𝙮') 
 else
  qmnb = {
    {['memory'] = 32},
    {['name'] ='𝙋𝙤𝙬𝙚𝙧 𝘼𝙩𝙩𝙖𝙘𝙠 𝙍𝙖𝙣𝙜𝙚 𝘾𝙪𝙯𝙩𝙤𝙢𝙞𝙯𝙚'},
    {['value'] =4620693217682129153, ['type'] = 32},
    {['lv'] = 1104815576842, ['offset'] = -0x4, ['type'] = 32},
    }
  qmxg = {
    {['value'] =xh[1], ['offset'] = 0x4, ['type'] = 16},
    }
  xqmnb(qmnb)
  gg.clearResults()
 end
 end
if choice == 29 then
gg.setRanges(gg.REGION_ANONYMOUS)
gg.clearResults()
gg.searchNumber(';RunEffect',gg.TYPE_WORD)
gg.getResults(100)
gg.editAll('0',gg.TYPE_WORD)
gg.toast('😀𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣 𝙛𝙤𝙧 𝙞𝙩 𝙩𝙤 𝙬𝙤𝙧𝙠 😀.')
gg.clearResults()
end
if choice == 30 then
gg.setRanges(gg.REGION_ANONYMOUS)
gg.clearResults()
gg.searchNumber(';Speed',gg.TYPE_WORD)
gg.getResults(100)
gg.editAll('2000',gg.TYPE_WORD)
gg.toast("🌑🌚𝙈𝙤𝙤𝙣𝙒𝙖𝙡𝙠 𝘼𝙘𝙩𝙞𝙫𝙖𝙩𝙚𝙙🌑🌚")
gg.clearResults()
end
if choice == 31 then
function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end

  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
    gg.gotoAddress(results[1].address)
    local selected = {
        {address = results[1].address, flags = gg.TYPE_DWORD},
        {address = results[1].address - 4, flags = gg.TYPE_DWORD},{address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = 70
    selected[2].value = 1405353868
    selected[3].value = 1405353930
    gg.toast("✅✨ 𝙑𝙖𝙡𝙪𝙚𝙨 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 🚀")
    gg.clearResults()
    end
if choice == 32 then
function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end

  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
    gg.gotoAddress(results[1].address)
    local selected = {
        {address = results[1].address, flags = gg.TYPE_DWORD},
        {address = results[1].address - 4, flags = gg.TYPE_DWORD},{address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = 55
    selected[2].value = 1624638283
    selected[3].value = 1624638332
    gg.setValues(selected)
    gg.toast("✅✨ 𝙑𝙖𝙡𝙪𝙚𝙨 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 🚀")
    gg.clearResults()
    end
if choice == 33 then
function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end

  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
    gg.gotoAddress(results[1].address)
    local selected = {
        {address = results[1].address, flags = gg.TYPE_DWORD},
        {address = results[1].address - 4, flags = gg.TYPE_DWORD},{address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = 66
    selected[2].value = 1361937506
    selected[3].value = 1361937440
    gg.setValues(selected)
    gg.toast("✅✨  𝙑𝙖𝙡𝙪𝙚𝙨 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 🚀")
    gg.clearResults()
    end
if choice == 34 then 
function toBoldNumber(num)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵"
    }
    return tostring(num):gsub(".", map)
  end

  local input = gg.prompt(
    {"🔢 𝙀𝙣𝙩𝙚𝙧 𝙇𝙚𝙫𝙚𝙡:", "🎯 𝙀𝙣𝙩𝙚𝙧 𝙋𝙤𝙞𝙣𝙩𝙨:"},
    {"", ""},
    {"number", "number"}
  )

  if not input or input[1] == "" or input[2] == "" then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙋𝙡𝙚𝙖𝙨𝙚 𝙚𝙣𝙩𝙚𝙧 𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨! ❌")
    return
  end

  local level = tonumber(input[1])
  local points = tonumber(input[2])

  if not level or not points then
    gg.toast("❌ 𝙀𝙧𝙧𝙤𝙧: 𝙄𝙣𝙫𝙖𝙡𝙞𝙙 𝙣𝙪𝙢𝙗𝙚𝙧𝙨 𝙚𝙣𝙩𝙚𝙧𝙚𝙙 ❌")
    return
  end

  local boldLevel = toBoldNumber(level)
  local boldPoints = toBoldNumber(points)

  gg.toast("🔍 𝙎𝙚𝙖𝙧𝙘𝙝𝙞𝙣𝙜 𝙛𝙤𝙧 𝙇𝙚𝙫𝙚𝙡: " .. boldLevel .. " 𝙖𝙣𝙙 𝙋𝙤𝙞𝙣𝙩𝙨: " .. boldPoints .. " 🔎")

  gg.searchNumber(level .. ";" .. points .. "::99", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, gg.REGION_ANONYMOUS)
  local results = gg.getResults(2)

  if #results ~= 2 then
    local boldResultCount = toBoldNumber(#results)
    gg.alert("⚠️ 𝙀𝙧𝙧𝙤𝙧: 𝙀𝙭𝙥𝙚𝙘𝙩𝙚𝙙 𝟮 𝙧𝙚𝙨𝙪𝙡𝙩𝙨, 𝙗𝙪𝙩 𝙛𝙤𝙪𝙣𝙙 " .. boldResultCount .. " ⚠️")
    gg.clearResults()
    return
  end

  gg.toast("✅ 𝙎𝙚𝙖𝙧𝙘𝙝 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡!, 𝙉𝙖𝙫𝙞𝙜𝙖𝙩𝙞𝙣𝙜 𝙩𝙤 𝙢𝙚𝙢𝙤𝙧𝙮... 🧠")
    gg.gotoAddress(results[1].address)
    local selected = {
        {address = results[1].address, flags = gg.TYPE_DWORD},
        {address = results[1].address - 4, flags = gg.TYPE_DWORD},{address = results[1].address - 8, flags = gg.TYPE_DWORD}
    }
    selected[1].value = 43
    selected[2].value = 1888546129
    selected[3].value = 1888546170
    gg.setValues(selected)
    gg.toast("✅✨ 𝙑𝙖𝙡𝙪𝙚𝙨 𝙪𝙥𝙙𝙖𝙩𝙚𝙙 𝙨𝙪𝙘𝙘𝙚𝙨𝙨𝙛𝙪𝙡𝙡𝙮! 🚀")
    gg.clearResults()
    end
    if choice == 35 then
    gg.alert('🦌🦌 𝙔𝙤𝙪 𝙣𝙚𝙚𝙙𝙖 𝙗𝙚 𝙞𝙣 𝙩𝙝𝙚 𝙖𝙣𝙞𝙢𝙖𝙡 𝙘𝙧𝙚𝙖𝙩𝙞𝙤𝙣 𝙢𝙚𝙣𝙪, 𝙩𝙝𝙚𝙣 𝙨𝙚𝙡𝙚𝙘𝙩 𝙖 𝙙𝙚𝙚𝙧 🦌🦌')
xh=gg.prompt({'𝘽𝙪𝙛𝙛𝙖𝙡𝙤=𝟰｜𝙈𝙤𝙤𝙨𝙚=𝟭｜𝙂𝙞𝙧𝙖𝙛𝙛𝙚=𝟱｜𝙂𝙤𝙧𝙞𝙡𝙡𝙖=𝟮｜𝙍𝙝𝙞𝙣𝙤𝙘𝙚𝙧𝙤𝙨=𝟬｜𝙀𝙡𝙚𝙥𝙝𝙖𝙣𝙩=𝟯｜𝘾𝙝𝙚𝙚𝙩𝙖𝙝=𝟯𝟯｜𝘾𝙧𝙤𝙘𝙤𝙙𝙞𝙡𝙚=𝟮𝟳｜𝘽𝙚𝙖𝙧=𝟮𝟬｜𝙇𝙞𝙤𝙣=𝟮𝟭｜𝙏𝙞𝙜𝙚𝙧=𝟮𝟯｜𝘽𝙤𝙖𝙧=𝟭𝟬｜𝙃𝙞𝙥𝙥𝙤=𝟭𝟭｜𝙋𝙖𝙣𝙙𝙖=𝟭𝟮｜𝙆𝙖𝙣𝙜𝙖𝙧𝙤𝙤=𝟭𝟯｜𝙇𝙚𝙤𝙥𝙖𝙧𝙙=𝟮𝟴｜𝙊𝙨𝙩𝙧𝙞𝙘𝙝=𝟭𝟰｜𝙋𝙚𝙣𝙜𝙪𝙞𝙣=𝟮𝟵｜𝙏𝙖𝙥𝙞𝙧=𝟮𝟭𝟯｜𝙇𝙤𝙣𝙜𝙝𝙤𝙧𝙣𝘾𝙤𝙬=𝟮𝟭𝟭｜𝙇𝙮𝙣𝙭=𝟰𝟯𝟭｜𝙋𝙤𝙡𝙖𝙧𝘽𝙚𝙖𝙧=𝟰𝟯𝟮｜𝙎𝙣𝙖𝙠𝙚=𝟰𝟯𝟯｜𝙍𝙖𝙘𝙘𝙤𝙤𝙣=𝟯𝟭𝟱｜𝘼𝙧𝙢𝙖𝙙𝙞𝙡𝙡𝙤=𝟯𝟭𝟲｜𝙏𝙪𝙧𝙩𝙡𝙚=𝟯𝟭𝟳｜𝙁𝙚𝙣𝙣𝙚𝙘=𝟰𝟯𝟬｜𝙊𝙩𝙩𝙚𝙧=𝟯𝟬𝟬𝟭｜𝘾𝙧𝙤𝙬=𝟯𝟬𝟬𝟮｜𝙋𝙞𝙜𝙚𝙤𝙣=𝟯𝟬𝟬𝟯｜𝙎𝙥𝙖𝙧𝙧𝙤𝙬=𝟯𝟬𝟬𝟰｜𝘽𝙖𝙧𝙣𝙊𝙬𝙡=𝟯𝟬𝟬𝟱｜𝙑𝙤𝙜𝙚𝙡𝙠𝙤𝙥𝙗𝙤𝙬𝙚𝙧𝙗𝙞𝙧𝙙=𝟯𝟬𝟬𝟲｜𝙍𝙚𝙙𝘾𝙧𝙤𝙬𝙣𝙚𝙙𝘾𝙧𝙖𝙣𝙚=𝟯𝟬𝟬𝟟｜𝘽𝙖𝙡𝙙𝙀𝙖𝙜𝙡𝙚=𝟯𝟬𝟬𝟴｜𝙃𝙖𝙧𝙥𝙮𝙀𝙖𝙜𝙡𝙚=𝟯𝟬𝟬𝟵｜𝙎𝙚𝙘𝙧𝙚𝙩𝙖𝙧𝙮𝙗𝙞𝙧𝙙=𝟯𝟬𝟭𝟬｜𝙎𝙚𝙖𝙜𝙪𝙡𝙡=𝟯𝟬𝟭𝟱｜𝙎𝙤𝙪𝙩𝙝𝙚𝙧𝙣𝘾𝙖𝙨𝙨𝙤𝙬𝙖𝙧𝙮=𝟯𝟬𝟮𝟬｜𝙈𝙤𝙖=𝟯𝟬𝟮𝟭｜𝙑𝙪𝙡𝙩𝙪𝙧𝙚=𝟯𝟬𝟭𝟵｜𝙒𝙖𝙡𝙧𝙪𝙨=𝟯𝟬𝟭𝟰｜𝙆𝙤𝙢𝙤𝙙𝙤𝘿𝙧𝙖𝙜𝙤𝙣=𝟯𝟬𝟭𝟭｜𝙂𝙤𝙡𝙞𝙖𝙩𝙝𝙎𝙥𝙞𝙙𝙚𝙧=𝟯𝟬𝟭𝟮｜𝙂𝙞𝙖𝙣𝙩𝘼𝙣𝙩𝙚𝙖𝙩𝙚𝙧=𝟯𝟬𝟮𝟮｜𝘾𝙤𝙬=𝟯𝟬𝟭𝟯｜𝙃𝙤𝙧𝙨𝙚=𝟯𝟬𝟭𝟲｜𝙒𝙞𝙡𝙙𝙚𝙗𝙚𝙚𝙨𝙩=𝟯𝟬𝟭𝟩｜𝘾𝙖𝙥𝙮𝙗𝙖𝙧𝙖=𝟯𝟬𝟭𝟴｜𝘽𝙚𝙖𝙫𝙚𝙧=𝟯𝟬𝟮𝟯｜𝙎𝙘𝙤𝙧𝙥𝙞𝙤𝙣=𝟯𝟬𝟮𝟰｜𝘾𝙡𝙤𝙪𝙙𝙚𝙙𝙡𝙚𝙤𝙥𝙖𝙧𝙙=𝟯𝟬𝟮𝟱｜𝙁𝙧𝙞𝙡𝙡-𝙣𝙚𝙘𝙠𝙚𝙙_𝙇𝙞𝙯𝙖𝙧𝙙=𝟯𝟬𝟮𝟲｜𝙍𝙖𝙩𝙩𝙡𝙚𝙨𝙣𝙖𝙠𝙚=𝟯𝟬𝟮𝟳｜𝘾𝙤𝙗𝙧𝙖=𝟯𝟬𝟮𝟴｜𝙎𝙣𝙤𝙬𝙡𝙚𝙤𝙥𝙖𝙧𝙙=𝟯𝟬𝟮𝟵｜𝙅𝙖𝙘𝙠𝙖𝙡=𝟯𝟬𝟯𝟬｜𝘼𝙛𝙧𝙞𝙘𝙖𝙣𝙬𝙞𝙡𝙙𝙙𝙤𝙜=𝟯𝟬𝟯𝟭｜𝙁𝙖𝙡𝙘𝙤𝙣=𝟯𝟬𝟯𝟮｜𝙍𝙖𝙫𝙚𝙣=𝟯𝟬𝟯𝟯｜𝙎𝙣𝙤𝙬𝙮𝙊𝙬𝙡=𝟯𝟬𝟯𝟰｜𝙃𝙚𝙣𝙃𝙖𝙧𝙧𝙞𝙚𝙧=𝟯𝟬𝟯𝟱｜𝘼𝙢𝙚𝙧𝙞𝙘𝙖𝙣𝙗𝙪𝙛𝙛𝙖𝙡𝙤=𝟯𝟬𝟯𝟲｜𝘼𝙡𝙥𝙞𝙣𝙚𝙄𝙗𝙚𝙭=𝟯𝟬𝟯𝟳｜𝙏𝙧𝙚𝙚-𝙠𝙖𝙣𝙜𝙖𝙧𝙤𝙤=𝟯𝟬𝟯𝟴｜𝙍𝙚𝙙𝙋𝙖𝙣𝙙𝙖=𝟯𝟬𝟯𝟵｜𝙒𝙖𝙡𝙡𝙖𝙗𝙮=𝟯𝟬𝟰𝟬｜𝙆𝙤𝙖𝙡𝙖=𝟯𝟬𝟰𝟭｜𝙈𝙚𝙚𝙧𝙠𝙖𝙩=𝟯𝟬𝟰𝟮｜𝙈𝙖𝙧𝙩𝙚𝙣=𝟯𝟬𝟰𝟯｜𝙈𝙖𝙧𝙢𝙤𝙩=𝟯𝟬𝟰𝟰｜𝙃𝙚𝙙𝙜𝙚𝙝𝙤𝙜=𝟯𝟬𝟰𝟱｜𝙈𝙤𝙡𝙚=𝟯𝟬𝟰𝟲｜𝙃𝙞𝙡𝙡𝙡𝙨𝙍𝙪𝙛𝙛𝙚𝙣𝙙𝙇𝙚𝙢𝙪𝙧=𝟯𝟬𝟰𝟳｜𝘾𝙖𝙥𝙪𝙘𝙝𝙞𝙣𝙈𝙤𝙣𝙠𝙚𝙮=𝟯𝟬𝟰𝟴｜𝙍𝙞𝙣𝙜-𝙏𝙖𝙞𝙡𝙚𝙙_𝙇𝙚𝙢𝙪𝙧=𝟯𝟬𝟰𝟵｜𝙈𝙖𝙘𝙖𝙦𝙪𝙚=𝟯𝟬𝟱𝟬｜𝙏𝙖𝙨𝙢𝙖𝙣𝙞𝙖𝙣_𝘿𝙚𝙫𝙞𝙡=𝟯𝟬𝟱𝟭｜𝙈𝙪𝙨𝙠𝙤𝙭=𝟯𝟬𝟱𝟮｜𝘾𝙝𝙞𝙘𝙠𝙚𝙣=𝟯𝟬𝟱𝟯｜𝙋𝙞𝙜=𝟯𝟬𝟱𝟰｜𝙁𝙡𝙮𝙞𝙣𝙜𝙁𝙞𝙨𝙝=𝟯𝟬𝟱𝟱｜𝘽𝙖𝙧𝙧𝙖𝙘𝙪𝙙𝙖=𝟯𝟬𝟱𝟲｜𝙏𝙪𝙣𝙖=𝟯𝟬𝟱𝟳｜𝙎𝙖𝙞𝙡𝙛𝙞𝙨𝙝=𝟯𝟬𝟱𝟴｜𝙎𝙬𝙤𝙧𝙙𝙛𝙞𝙨𝙝=𝟯𝟬𝟱𝟵｜𝙎𝙪𝙣𝙛𝙞𝙨𝙝=𝟯𝟬𝟲𝟬｜𝘾𝙤𝙢𝙢𝙤𝙣_𝙨𝙩𝙞𝙣𝙜𝙧𝙖𝙮=𝟯𝟬𝟲𝟭｜𝙂𝙪𝙞𝙩𝙖𝙧_𝙨𝙩𝙞𝙣𝙜𝙧𝙖𝙮=𝟯𝟬𝟲𝟮｜𝙎𝙝𝙖𝙧𝙠_𝙍𝙖𝙮=𝟯𝟬𝟲𝟯｜𝙀𝙖𝙜𝙡𝙚_𝙍𝙖𝙮=𝟯𝟬𝟲𝟰｜𝙈𝙖𝙣𝙩𝙖_𝙍𝙖𝙮=𝟯𝟬𝟲𝟱｜𝙇𝙤𝙣𝙜_𝙗𝙞𝙡𝙡𝙚𝙙_𝙙𝙤𝙡𝙥𝙝𝙞𝙣=𝟯𝟬𝟲𝟲｜𝙄𝙧𝙖𝙬𝙖𝙙𝙙𝙮_𝙙𝙤𝙡𝙥𝙝𝙞𝙣=𝟯𝟬𝟲𝟳｜𝙃𝙖𝙧𝙗𝙤𝙪𝙧_𝙋𝙤𝙧𝙥𝙤𝙞𝙨𝙚=𝟯𝟬𝟲𝟴｜𝘾𝙝𝙞𝙣𝙚𝙨𝙚_𝙙𝙤𝙡𝙥𝙝𝙞𝙣=𝟯𝟬𝟲𝟵｜𝘽𝙤𝙩𝙩𝙡𝙚𝙣𝙤𝙨𝙚_𝘿𝙤𝙡𝙥𝙝𝙞𝙣=𝟯𝟬𝟳𝟬｜𝘽𝙪𝙡𝙡_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟭｜𝘽𝙡𝙪𝙚_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟮｜𝙃𝙖𝙢𝙢𝙚𝙧𝙝𝙚𝙖𝙙_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟯｜𝙒𝙝𝙞𝙩𝙚_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟰｜𝙏𝙞𝙜𝙚𝙧_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟱｜𝙒𝙝𝙖𝙡𝙚_𝙎𝙝𝙖𝙧𝙠=𝟯𝟬𝟳𝟲｜𝙉𝙖𝙧𝙬𝙝𝙖𝙡=𝟯𝟬𝟳𝟳｜𝘽𝙚𝙡𝙪𝙜𝙖=𝟯𝟬𝟳𝟴｜𝙆𝙞𝙡𝙡𝙚𝙧_𝙒𝙝𝙖𝙡𝙚=𝟯𝟬𝟳𝟵｜𝙃𝙪𝙢𝙥𝙗𝙖𝙘𝙠_𝙒𝙝𝙖𝙡𝙚=𝟯𝟬𝟴𝟬｜𝘾𝙖𝙘𝙝𝙖𝙡𝙤𝙩=𝟯𝟬𝟴𝟭｜𝘽𝙡𝙪𝙚_𝙒𝙝𝙖𝙡𝙚=𝟯𝟬𝟴𝟮｜𝙕𝙤𝙢𝙗𝙞𝙚 ♂️=𝟱𝟬𝟭｜𝙕𝙤𝙢𝙗𝙞𝙚 ♀️=𝟱𝟬𝟮｜𝙕𝙤𝙢𝙗𝙞𝙚𝙝𝙪𝙢𝙖𝙣=𝟱𝟬𝟯'},{''})
 if xh == nil then gg.alert('𝙔𝙤𝙪 𝙘𝙖𝙣𝙘𝙚𝙡𝙚𝙙 𝙩𝙝𝙚 𝙞𝙣𝙥𝙪𝙩.') 
 else
qmnb = {
{['memory'] = 32},
{['name'] = '𝘾𝙧𝙚𝙖𝙩𝙚 𝙁𝙧𝙚𝙚 𝘼𝙣𝙞𝙢𝙖𝙡𝙨'},
{['value'] =1103806615072, ['type'] = 32},
{['lv'] = 1908872445347868,['offset'] =0x38, ['type'] = 32},
{['lv'] = 444444,['offset'] =0x3C, ['type'] = 4},
}
qmxg = {
{['value'] = xh[1],['offset'] =0x58, ['type'] = 4},
}
xqmnb(qmnb)
gg.clearResults()
end
end 
if choice == 36 then
  zt = 37
function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end
function subMenu2()
  local menu = {
    "➤ 🌳🌳 𝘼𝙢𝙖𝙯𝙤𝙣-𝙎𝙖𝙝𝙖𝙧𝙖 🌴🌴",
    "➤ 🌳🌳 𝘼𝙢𝙖𝙯𝙤𝙣-𝙑𝙚𝙣𝙞𝙘𝙚 🌲🌲",
    "➤ 🌳🌳 𝘼𝙢𝙖𝙯𝙤𝙣-𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙 👹🧌",
    "➤ 🌳🌳 𝘼𝙢𝙖𝙯𝙤𝙣-𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚 🧟‍♂️🧟‍♂️ ",
    "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
  }

  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
 "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return mainMenu()
  end

  if choice == 1 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Amazon',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Sahara',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 2 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Amazon',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Venice',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 3 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Amazon',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';MonsterField',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 4 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Amazon',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';ZombieBattle',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 5 then
    return mainMenu()
  end
end
if choice == 36 then
  zt = 37
  subMenu2()
end   
end 
if choice == 37 then
 function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end
function subMenu3()
  local menu = {
    "➤ 🏜️🏜️ 𝙎𝙖𝙝𝙖𝙧𝙖-𝘼𝙢𝙖𝙯𝙤𝙣 🌳🌳",
    "➤ 🏜️🏜️ 𝙎𝙖𝙝𝙖𝙧𝙖-𝙑𝙚𝙣𝙞𝙘𝙚 🌲🌲",
    "➤ 🏜️🏜️ 𝙎𝙖𝙝𝙖𝙧𝙖-𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙 👹🧌",
    "➤ 🏜️🏜️ 𝙎𝙖𝙝𝙖𝙧𝙖-𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚 🧟‍♂️🧟‍♂️ ",
    "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
  }

  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
 "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return mainMenu()
  end

  if choice == 1 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Sahara',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Amazon',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 2 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Sahara',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Venice',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 3 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Sahara',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';MonsterField',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 4 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Sahara',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';ZombieBattle',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 5 then
    return mainMenu()
  end
end
if choice == 37 then
  zt = 38
  subMenu3()
end   
end    
if choice == 38 then
 function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end
function subMenu4()
  local menu = {
    "➤ 🌲🌲 𝙑𝙚𝙣𝙞𝙘𝙚-𝘼𝙢𝙖𝙯𝙤𝙣 🌳🌳",
    "➤ 🌲🌲 𝙑𝙚𝙣𝙞𝙘𝙚-𝙎𝙖𝙝𝙖𝙧𝙖 🏜️🏜️",
    "➤ 🌲🌲 𝙑𝙚𝙣𝙞𝙘𝙚-𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙 👹🧌",
    "➤ 🌲🌲 𝙑𝙚𝙣𝙞𝙘𝙚-𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚 🧟‍♂️🧟‍♂️ ",
    "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
  }

  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
 "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return mainMenu()
  end

  if choice == 1 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Venice',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Amazon',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 2 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Venice',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Sahara',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 3 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Venice',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';MonsterField',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 4 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';Nomal_Venice',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';ZombieBattle',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 5 then
    return mainMenu()
  end
end
if choice == 38 then
zt = 39
subMenu4()
end   
end 
if choice == 39 then
zt = 40
function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end
function subMenu5()
  local menu = {
    "➤ 🧌🧌 𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙-𝘼𝙢𝙖𝙯𝙤𝙣 🌳🌳",
    "➤ 🧌🧌 𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙-𝙑𝙚𝙣𝙞𝙘𝙚 🌲🌲",
    "➤ 🧌🧌 𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙-𝙎𝙖𝙝𝙖𝙧𝙖 🏜️🏜️",
    "➤ 🧌🧌 𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙-𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚 🧟‍♂️🧟‍♂️ ",
    "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
  }

  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
 "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return mainMenu()
  end

  if choice == 1 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';MonsterField',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Amazon',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 2 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';MonsterField',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Venice',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 3 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';MonsterField',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Sahara',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 4 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';MonsterField',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';ZombieBattle',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 5 then
    return mainMenu()
  end
end
if choice == 39 then
zt = 40
subMenu5()
end   
end 
if choice == 40 then
zt = 41
function toBoldItalic(str)
  local map = {
    ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
    ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
    [":"]=":", ["-"]="-", [" "]=" "
  }
  local result = ""
  for i = 1, #str do
    local c = str:sub(i,i)
    result = result .. (map[c] or c)
  end
  return result
end
function subMenu6()
  local menu = {
    "➤ 🧟‍♂️🧟‍♂️ 𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚-𝘼𝙢𝙖𝙯𝙤𝙣 🌳🌳",
    "➤ 🧟‍♂️🧟‍♂️ 𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚-𝙑𝙚𝙣𝙞𝙘𝙚 🌲🌲",
    "➤ 🧟‍♂️🧟‍♂️ 𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚-𝙎𝙖𝙝𝙖𝙧𝙖 🏜️🏜️",
    "➤ 🧟‍♂️🧟‍♂️ 𝙕𝙤𝙢𝙗𝙞𝙚𝘽𝙖𝙩𝙩𝙡𝙚-𝙈𝙤𝙣𝙨𝙩𝙚𝙧𝙁𝙞𝙚𝙡𝙙 🧌🧌‍ ",
    "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
  }

  local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
  local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
 "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
"➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
"➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
"➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
"➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  local choice = gg.choice(menu, nil, title)
  if choice == nil then
    return mainMenu()
  end

  if choice == 1 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';ZombieBattle',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Amazon',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 2 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';ZombieBattle',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Venice',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 3 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';ZombieBattle',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';Nomal_Sahara',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 4 then
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(';ZombieBattle',gg.TYPE_WORD)
    gg.getResults(100)
    gg.editAll(';MonsterField',gg.TYPE_WORD)
    gg.toast('🛫🛫𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣🛫🛫')

  elseif choice == 5 then
    return mainMenu()
  end
end
if choice == 40 then
zt = 41
subMenu6()
end   
end
if choice == 41 then
  zt = 42

  function toBoldItalic(str)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
      [":"]=":", ["-"]="-", [" "]=" "
    }
    local result = ""
    for i = 1, #str do
      local c = str:sub(i,i)
      result = result .. (map[c] or c)
    end
    return result
  end

  function subMenu7()
    local menu = {
      "➤ ☀️☀️ 𝙉𝙚𝙬 𝙂𝙧𝙖𝙥𝙝𝙞𝙘𝙨-𝙊𝙡𝙙 𝙂𝙧𝙖𝙥𝙝𝙞𝙘𝙨 🌅🌅",
      "➤ ☀️☀️ 𝙊𝙡𝙙 𝙂𝙧𝙖𝙥𝙝𝙞𝙘𝙨-𝙉𝙚𝙬 𝙂𝙧𝙖𝙥𝙝𝙞𝙘𝙨 🌄🌄",
      "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
    }

    local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
    local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
    "➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
    "➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
    "➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
    "➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local choice = gg.choice(menu, nil, title)
    if choice == nil then
      return mainMenu()
    elseif choice == 1 then
      gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(';Shadow', gg.TYPE_WORD)
      gg.getResults(100)
      gg.editAll(';Sun', gg.TYPE_WORD)
      gg.toast('🌇🌇 𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣 🌇🌇')
      gg.clearResults()
    elseif choice == 2 then
      gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(';Sun', gg.TYPE_WORD)
      gg.getResults(100)
      gg.editAll(';Shadow', gg.TYPE_WORD)
      gg.toast('🌇🌇 𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣 🌇🌇')
      gg.clearResults()
    elseif choice == 3 then
      return mainMenu()
    end
  end

  subMenu7()
end
if choice == 42 then
zt = 43
gg.setRanges(gg.REGION_ANONYMOUS)
gg.clearResults()
gg.searchNumber(';Attack',gg.TYPE_WORD)
gg.getResults(100)
gg.editAll('1',gg.TYPE_WORD)
gg.toast('🎯⚔️𝙉𝙤𝙬 𝙮𝙤𝙪 𝙖𝙧𝙚 𝙜𝙞𝙫𝙞𝙣𝙜 𝟬 𝙙𝙖𝙢𝙖𝙜𝙚 🎯⚔️')
end
if choice == 43 then
zt = 44
function toBoldItalic(str)
    local map = {
      ["0"]="𝟬", ["1"]="𝟭", ["2"]="𝟮", ["3"]="𝟯", ["4"]="𝟰",
      ["5"]="𝟱", ["6"]="𝟲", ["7"]="𝟳", ["8"]="𝟴", ["9"]="𝟵",
      [":"]=":", ["-"]="-", [" "]=" "
    }
    local result = ""
    for i = 1, #str do
      local c = str:sub(i,i)
      result = result .. (map[c] or c)
    end
    return result
  end

  function subMenu8()
    local menu = {
      "➤ ➖👎 𝙉𝙚𝙜𝙖𝙩𝙞𝙫𝙚 𝙄𝙢𝙢𝙤 ➖👎",
      "➤ 🦷🥩 𝙄𝙢𝙢𝙤 𝘽𝙞𝙩𝙚 🦷🥩",
      "➤ 🏋️💪 𝙄𝙣𝙫𝙞𝙣𝙘𝙞𝙗𝙡𝙚 𝙄𝙢𝙢𝙤 𝙊𝙣 💪🏋️",
      "➤ 📴💪 𝙄𝙣𝙫𝙞𝙣𝙘𝙞𝙗𝙡𝙚 𝙄𝙢𝙢𝙤 𝙊𝙛𝙛 📴💪",
      "➤ 🔄🔄 𝘼𝙣𝙩𝙞-𝙇𝙞𝙠𝙚𝙨 𝘾𝙤𝙙𝙚 👍👍",
      "➤ 🏥❤️‍🩹 𝘼𝙣𝙩𝙞-𝙃𝙚𝙖𝙡 𝘾𝙤𝙙𝙚 🏥❤️‍🩹",  
      "➤ 𝙍𝙚𝙩𝙪𝙧𝙣 𝙩𝙤 𝙝𝙤𝙢𝙚𝙥𝙖𝙜𝙚"
    }

    local fancy_time = toBoldItalic(os.date("%Y-%m-%d %H:%M:%S"))
    local title = "⏰ " .. fancy_time .. "\n🎮✨ 𝙎𝙚𝙡𝙚𝙘𝙩 𝙖 𝙁𝙚𝙖𝙩𝙪𝙧𝙚:\n" ..
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
    "➤ 𝘼𝙪𝙩𝙝𝙤𝙧: 𝘼𝙡𝙞\n" ..
    "➤ 𝙂𝙖𝙢𝙚: 𝙘𝙤𝙢.𝙝𝙖𝙣𝙖𝙂𝙖𝙢𝙚𝙨.𝙒𝙞𝙡𝙙𝘼𝙣𝙞𝙢𝙖𝙡𝙨𝙊𝙣𝙡𝙞𝙣𝙚\n" ..
    "➤ 𝙑𝙚𝙧𝙨𝙞𝙤𝙣: 𝟵.𝟬.𝟬\n" ..
    "➤ 𝘿𝙞𝙨𝙘𝙤𝙧𝙙: 𝘼𝙡𝙞𝙁𝟮𝙋𝙋𝙡𝙖𝙮𝙚𝙧\n" ..
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local choice = gg.choice(menu, nil, title)
    if choice == nil then
      return mainMenu()
    elseif choice == 1 then
      gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber('1,116,059,623', gg.TYPE_DWORD)
      gg.getResults(100)
      gg.editAll('-100', gg.TYPE_DWORD)
      gg.toast('➖❎ 𝙉𝙤𝙬 𝙔𝙤𝙪 𝘼𝙧𝙚 𝙄𝙢𝙢𝙤𝙧𝙩𝙖𝙡 ➖❎')
      gg.clearResults()
    elseif choice == 2 then
      gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber('1,099,254,759', gg.TYPE_DWORD)
      gg.getResults(100)
      gg.editAll('-100', gg.TYPE_DWORD)
      gg.toast('🥩🦷𝙉𝙤𝙬 𝙮𝙤𝙪 𝙝𝙖𝙫𝙚 𝙖𝙣 𝙞𝙢𝙢𝙤 𝘽𝙞𝙩𝙚🦷🥩')
      gg.clearResults()
      elseif choice == 3 then
      gg.setRanges(gg.REGION_ANONYMOUS )
gg.clearResults()
gg.searchNumber(";Die", gg.TYPE_WORD)
gg.getResults(300)
gg.editAll(";FUK", gg.TYPE_WORD)
gg.clearResults()
gg.searchNumber(";Kill", gg.TYPE_WORD)
gg.getResults(500)
gg.editAll(";POOP", gg.TYPE_WORD)
gg.toast('💀😵 𝙄𝙣𝙫𝙞𝙣𝙘𝙞𝙗𝙡𝙚 𝙄𝙢𝙢𝙤 𝙊𝙣 😵💀\n💯 𝙉𝙤𝙬 𝙔𝙤𝙪 𝙖𝙧𝙚 𝙪𝙣𝙙𝙞𝙚𝙖𝙗𝙡𝙚 💯')
gg.clearResults()
elseif choice == 4 then
gg.setRanges(gg.REGION_ANONYMOUS )
gg.clearResults()
gg.searchNumber(";FUK", gg.TYPE_WORD)
gg.getResults(300)
gg.editAll(";Die", gg.TYPE_WORD)
gg.clearResults()
gg.searchNumber(";POOP", gg.TYPE_WORD)
gg.getResults(500)
gg.editAll(";Kill", gg.TYPE_WORD)
gg.toast(' 😵💀 𝙄𝙣𝙫𝙞𝙣𝙘𝙞𝙗𝙡𝙚 𝙄𝙢𝙢𝙤 𝙊𝙛𝙛 💀😵\n0️⃣ 𝙉𝙤𝙬 𝙮𝙤𝙪 𝙖𝙧𝙚 𝙣𝙤𝙧𝙢𝙖𝙡𝙡𝙮 𝙙𝙞𝙚𝙖𝙗𝙡𝙚 0️⃣')
gg.clearResults()
elseif choice == 5 then
gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(';SetLike', gg.TYPE_WORD)
      gg.getResults(100)
      gg.editAll(';0', gg.TYPE_WORD)
      gg.toast('👍➕𝙉𝙤𝙬 𝙮𝙤𝙪 𝙖𝙧𝙚 𝙪𝙣𝙖𝙗𝙡𝙚 𝙩𝙤 𝙜𝙚𝙩 𝙡𝙞𝙠𝙚𝙨➕👍')
      gg.clearResults()
      elseif choice == 6 then
      gg.clearResults()
      gg.setRanges(gg.REGION_ANONYMOUS)
      gg.searchNumber(';Heal', gg.TYPE_WORD)
      gg.getResults(100)
      gg.editAll(';0', gg.TYPE_WORD)
      gg.toast('🏥➕ 𝙉𝙤𝙬 𝙮𝙤𝙪 𝙖𝙧𝙚 𝙪𝙣𝙖𝙗𝙡𝙚 𝙩𝙤 𝙜𝙚𝙩 𝙃𝙚𝙖𝙡𝙚𝙙 🏥➕')
      gg.clearResults()
    elseif choice == 7 then
      return mainMenu()
    end
  end

  subMenu8()
end
  if choice == 44 then
    zt = 45
    gg.setRanges(gg.REGION_ANONYMOUS)
gg.clearResults()
gg.searchNumber("9794", gg.TYPE_WORD)
gg.getResults(300)
gg.editAll("26", gg.TYPE_WORD)
gg.clearResults()
gg.searchNumber(";Sex", gg.TYPE_WORD)
gg.getResults(500)
gg.editAll(";0", gg.TYPE_WORD)
    gg.toast("🎩👒 𝙉𝙤𝙬 𝙍𝙚𝙟𝙤𝙞𝙣 👒🎩")
gg.clearResults()
  end
if choice == 45 then
    zt = 46
    gg.toast("❌ 𝙈𝙚𝙣𝙪 𝘾𝙡𝙤𝙨𝙚𝙙 ❌")
    print("𝙃𝙖𝙫𝙚 𝙖 𝙜𝙤𝙤𝙙 𝙙𝙖𝙮!!\n𝙀𝙭𝙞𝙩.")
    os.exit()
  elseif choice == nil then
    return false
  end
return true
end

gg.setVisible(true)
gg.showUiButton(true)

while true do
  if gg.isClickedUiButton() then
    gg.showUiButton(false)
    local menuHandled = mainMenu()
    if menuHandled == false then
      gg.showUiButton(true)
    else
      gg.showUiButton(true)
    end
  end
  gg.sleep(100)
end
