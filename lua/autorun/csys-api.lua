csys = csys or {};
csys.api = csys.api or {};

local FrameworkDir = 'csys-api';
local LuaFiles = {

};

local function ScriptLoader( FilePath )

    FilePath = string.lower( FilePath );

    if ( not file.Exists( FilePath, 'LUA' ) ) then
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

for i = 1, table.Count( LuaFiles ) do
    local LuaFilePath = FrameworkDir .. '/' .. LuaFiles[ i ] .. '.lua';
    ScriptLoader( LuaFilePath );
end;

MsgN( '-- Loading is complete!' );
