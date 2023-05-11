--------------------------------
----- Program Configuration ----
--------------------------------

-- The file that will be read
local FILENAME = "test.pitr"

--------------------------------
--------------------------------
--------------------------------

local JSON = require 'json'

-- TODO: expand this list
-- TODO: does uk even allow for situations where this is a different value?
local hash2scene = {
    ['7b3cb6a0a342eb54dafe5552d4820eeb'] = 'uk_construct'
}

-- TODO: Check if there are others
local valuekeys = {
    "BoolValue",
    "FloatValue"
}

local jsondata

function loadFile()
    local file = io.open(FILENAME, "r")
    local text = file:read("*all")
    file:close()

    jsondata = JSON.decode(text)
    print("Loaded and decoded pitr file '"..FILENAME.."'")
end

function findAllMetadataInfo()
    local fulloutput = ""

    local function prnt(msg, indt)
        local indtstr = ""
        if indt and indt > 0 then
            for i=1,indt do
                indtstr = indtstr.." "
            end
        end

        fulloutput = fulloutput..indtstr..msg.."\n"
        print(indtstr..msg)
    end

    prnt("//------ Meta Info ------//")

    prnt(FILENAME.." {")
    local truelevelname = hash2scene[jsondata.MapName] or "UNKNOWN SCENE"
    prnt("MapName "..jsondata.MapName.." // "..truelevelname, 4)
    prnt("MapIdentifier "..(jsondata.MapIdentifier or "null"), 4)
    prnt("GameVersion "..jsondata.GameVersion, 4)
    prnt("SaveVersion "..jsondata.SaveVersion, 4)
    prnt("}")

    local file = io.open("SB_Meta.txt", "w")
    file:write(fulloutput)
    file:flush()
    file:close()
end

function findAllBlockInfo()
    local fulloutput = ""

    local function prnt(msg, indt)
        local indtstr = ""
        if indt and indt > 0 then
            for i=1,indt do
                indtstr = indtstr.." "
            end
        end

        fulloutput = fulloutput..indtstr..msg.."\n"
        print(indtstr..msg)
    end

    prnt("//------ Block Info ------//")

    for _,blockinfo in ipairs(jsondata.Blocks) do
        prnt(blockinfo.ObjectIdentifier.." {")
        prnt("Type "..blockinfo.BlockType, 4)

        if (blockinfo and blockinfo.Data) then
            prnt("")
            prnt("// Properties (Data)", 4)
            for _,datablock in ipairs(blockinfo.Data) do
                prnt(datablock.Key.." {", 4)
                for _,optblock in ipairs(datablock.Options) do
                    local value
                    local key

                    for _,possibleKey in ipairs(valuekeys) do
                        if optblock[possibleKey] ~= ni then
                            value = optblock[possibleKey]
                            key = possibleKey
                            break
                        end
                    end

                    prnt(optblock.Key.." "..tostring(value).." // "..key, 8)
                end
                prnt("}", 4)
            end
        end

        prnt("}")
    end

    local file = io.open("SB_Blocks.txt", "w")
    file:write(fulloutput)
    file:flush()
    file:close()
end

function findAllPropInfo()
    local fulloutput = ""

    local function prnt(msg, indt)
        local indtstr = ""
        if indt and indt > 0 then
            for i=1,indt do
                indtstr = indtstr.." "
            end
        end

        fulloutput = fulloutput..indtstr..msg.."\n"
        print(indtstr..msg)
    end

    prnt("//------ Prop Info ------//")

    for _,blockinfo in ipairs(jsondata.Props) do

        prnt(blockinfo.ObjectIdentifier.." {")

        if (blockinfo and blockinfo.Data) then
            prnt("")
            prnt("// Properties (Data)", 4)
            for _,datablock in ipairs(blockinfo.Data) do
                prnt(datablock.Key.." {", 4)
                for _,optblock in ipairs(datablock.Options) do
                    local value
                    local key

                    for _,possibleKey in ipairs(valuekeys) do
                        if optblock[possibleKey] ~= ni then
                            value = optblock[possibleKey]
                            key = possibleKey
                            break
                        end
                    end

                    prnt(optblock.Key.." "..tostring(value).." // "..key, 8)
                end
                prnt("}", 4)
            end
        end

        prnt("}")
    end

    local file = io.open("SB_Props.txt", "w")
    file:write(fulloutput)
    file:flush()
    file:close()
end

function findAllEnemyInfo()
    local fulloutput = ""

    local function prnt(msg, indt)
        local indtstr = ""
        if indt and indt > 0 then
            for i=1,indt do
                indtstr = indtstr.." "
            end
        end

        fulloutput = fulloutput..indtstr..msg.."\n"
        print(indtstr..msg)
    end

    prnt("//------ Enemy Info ------//")

    for _,blockinfo in ipairs(jsondata.Enemies) do
        prnt(blockinfo.ObjectIdentifier.." {")

        prnt("Radiance {", 4)

        if (blockinfo and blockinfo.Radiance) then
            for radkey,radval in pairs(blockinfo.Radiance) do
                prnt(radkey.." "..tostring(radval), 8)
            end
        end

        prnt("}", 4)

        if (blockinfo and blockinfo.Data) then
            prnt("")
            prnt("// Properties (Data)", 4)
            for _,datablock in ipairs(blockinfo.Data) do
                prnt(datablock.Key.." {", 4)
                for _,optblock in ipairs(datablock.Options) do
                    local value
                    local key

                    for _,possibleKey in ipairs(valuekeys) do
                        if optblock[possibleKey] ~= ni then
                            value = optblock[possibleKey]
                            key = possibleKey
                            break
                        end
                    end

                    prnt(optblock.Key.." "..tostring(value).." // "..key, 8)
                end
                prnt("}", 4)
            end
        end

        prnt("}")
    end

    local file = io.open("SB_Enemies.txt", "w")
    file:write(fulloutput)
    file:flush()
    file:close()
end

loadFile()
findAllMetadataInfo()
findAllBlockInfo()
findAllPropInfo()
findAllEnemyInfo()