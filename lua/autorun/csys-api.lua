-- Global variables
csys = csys or {};
csys.api = csys.api or {};

-- Main app directory
local FrameworkDir = 'csys-api';
-- Project lua files
local LuaFiles = {
    --[[ SERVER ]]--
    -- Stores client data during the game on the server
    'client/data',
    -- Responsible for processing data regarding clothing
    'client/meta/clothing',
    'client/clothing/net/receiver',
    -- Responsible for visualizing clothes on the client
    'client/meta/visualizer',
    'client/visualizer/net/receiver',

    --[[ CLIENT ]]--
    -- Stores client data during the game on the server
    'server/data',
    -- Responsible for processing data regarding clothing
    'server/meta/clothing'
    'server/clothing/net/receiver',
    -- Responsible for visualizing clothes on the server
    'server/meta/visualizer',
    'server/visualizer/net/receiver',
};

--- Load the project script to the game.
-- @param FilePath lua script file path
local function ScriptLoader( FilePath )

    FilePath = string.lower( FilePath );

    if ( not file.Exists( FilePath, 'LUA' ) ) then
        MsgN( 'Not found this lua file - ' .. FilePath );
        return;
    end;

    local FileName = string.GetFileFromFilename( FilePath )
    local ScriptType = string.sub( FileName, 1, 2 );

    if ( SERVER ) then
        if ( ScriptType == 'cl' or ScriptType == 'sh' ) then
            AddCSLuaFile( FilePath );
            MsgN( 'AddCSLuaFile [' .. ScriptType .. '] - ' .. FilePath );
        end;
    end;

    if ( ScriptType == 'sh' ) then
        include( FilePath );
        MsgN( 'include [' .. ScriptType .. '] - ' .. FilePath );
    end;

    if ( SERVER ) then
        if ( ScriptType == 'sv' ) then
            include( FilePath );
            MsgN( 'include [' .. ScriptType .. '] - ' .. FilePath );
        end;
    elseif ( CLIENT ) then
        if ( ScriptType == 'cl' ) then
            include( FilePath );
            MsgN( 'include [' .. ScriptType .. '] - ' .. FilePath );
        end;
    end;

end;

MsgN( '------------------------------' );
MsgN( '---------- CSYS API ----------' );
MsgN( '------------------------------' );
MsgN( '-- Loading...' );

--[[
    The loop iterates over the table files and loads them into the game.
--]]
for i = 1, table.Count( LuaFiles ) do
    local LuaFilePath = FrameworkDir .. '/' .. LuaFiles[ i ] .. '.lua';
    ScriptLoader( LuaFilePath );
end;

MsgN( '-- Loading is complete!' );
