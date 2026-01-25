--[[
Name: LibSharedMedia-3.0
Revision: $Revision: 122 $
Author: Elkano (me@elkano.net)
Website: http://www.wowace.com/projects/libsharedmedia-3-0/
Description: Shared handling of media data (fonts, sounds, textures, ...) between addons.
Dependencies: LibStub, CallbackHandler-1.0
License: LGPL v2.1
]]

local MAJOR, MINOR = "LibSharedMedia-3.0", 7000001
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local _G = getfenv(0)

local pairs = _G.pairs
local type = _G.type

local band = _G.bit.band

local table_insert = _G.table.insert
local table_sort = _G.table.sort
local string_lower = _G.string.lower

local locale = GetLocale()

-- create mediatype constants
lib.MediaType = lib.MediaType or {
	BACKGROUND	= "background",			-- background textures
	BORDER		= "border",				-- border textures
	FONT		= "font",				-- fonts
	STATUSBAR	= "statusbar",			-- statusbar textures
	SOUND		= "sound",				-- sound files
}

-- populate lib with default Blizzard data
-- BACKGROUND
if not lib.DefaultMedia then lib.DefaultMedia = {} end
if not lib.DefaultMedia[lib.MediaType.BACKGROUND] then lib.DefaultMedia[lib.MediaType.BACKGROUND] = {} end

-- BORDER
if not lib.DefaultMedia[lib.MediaType.BORDER] then lib.DefaultMedia[lib.MediaType.BORDER] = {} end

-- FONT
if not lib.DefaultMedia[lib.MediaType.FONT] then lib.DefaultMedia[lib.MediaType.FONT] = {} end
if locale == "koKR" then
	lib.DefaultMedia[lib.MediaType.FONT]["굵은 글꼴"] = [[Fonts\2002B.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["기본 글꼴"] = [[Fonts\2002.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["데미지 글꼴"] = [[Fonts\K_Damage.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["퀘스트 글꼴"] = [[Fonts\K_Pagetext.TTF]]
elseif locale == "zhCN" then
	lib.DefaultMedia[lib.MediaType.FONT]["伤害数字"] = [[Fonts\ZYKai_C.ttf]]
	lib.DefaultMedia[lib.MediaType.FONT]["默认"] = [[Fonts\ZYKai_T.ttf]]
	lib.DefaultMedia[lib.MediaType.FONT]["聊天"] = [[Fonts\ZYHei.ttf]]
elseif locale == "zhTW" then
	lib.DefaultMedia[lib.MediaType.FONT]["提示訊息"] = [[Fonts\bKAI00M.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["聊天"] = [[Fonts\bHEI00M.ttf]]
	lib.DefaultMedia[lib.MediaType.FONT]["傷害數字"] = [[Fonts\bHEI01B.ttf]]
elseif locale == "ruRU" then
	lib.DefaultMedia[lib.MediaType.FONT]["Friz Quadrata TT"] = [[Fonts\FRIZQT___CYR.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["Skurri"] = [[Fonts\SKURRI_CYR.ttf]]
	lib.DefaultMedia[lib.MediaType.FONT]["Morpheus"] = [[Fonts\MORPHEUS_CYR.TTF]]
else
	lib.DefaultMedia[lib.MediaType.FONT]["Friz Quadrata TT"] = [[Fonts\FRIZQT__.TTF]]
	lib.DefaultMedia[lib.MediaType.FONT]["Skurri"] = [[Fonts\skurri.ttf]]
	lib.DefaultMedia[lib.MediaType.FONT]["Morpheus"] = [[Fonts\MORPHEUS.TTF]]
end

-- STATUSBAR
if not lib.DefaultMedia[lib.MediaType.STATUSBAR] then lib.DefaultMedia[lib.MediaType.STATUSBAR] = {} end
lib.DefaultMedia[lib.MediaType.STATUSBAR]["Blizzard"] = [[Interface\TargetingFrame\UI-StatusBar]]

-- SOUND
if not lib.DefaultMedia[lib.MediaType.SOUND] then lib.DefaultMedia[lib.MediaType.SOUND] = {} end

-- setup database
lib.MediaList = lib.MediaList or {}
lib.MediaTable = lib.MediaTable or {}
lib.CallbackRegistry = lib.CallbackRegistry or LibStub:GetLibrary("CallbackHandler-1.0"):New(lib)

-- upgrade existing media
for mediatype, list in pairs(lib.MediaList) do
	for i, medianame in pairs(list) do
		list[i] = nil
	end
end

-- upgade the defaultmedia
for mediatype, list in pairs(lib.DefaultMedia) do
	for medianame, mediapath in pairs(list) do
		lib:Register(mediatype, medianame, mediapath, true)
	end
end

-- local function to handle new registrations
local function rebuildMediaList(mediatype)
	local mtable = lib.MediaTable[mediatype]
	local mlist = {}
	for k in pairs(mtable) do
		table_insert(mlist, k)
	end
	table_sort(mlist)
	lib.MediaList[mediatype] = mlist
end

-- Register a new media file. This is the function addons will call to register new fonts, backgrounds, etc.
--
-- mediatype		- type of the media, one of lib.MediaType.BACKGROUND, lib.MediaType.FONT, etc.
-- key				- unique name of the media
-- data				- either a string path to the file or a table with the path as .path and additional data
-- langmask			- language mask (see http://www.wowace.com/projects/libsharedmedia-3-0/pages/language-masks/)
function lib:Register(mediatype, key, data, langmask)
	if type(mediatype) ~= "string" then
		error(MAJOR..":Register(mediatype, key, data, langmask) - mediatype must be string, got "..type(mediatype))
	end
	if type(key) ~= "string" then
		error(MAJOR..":Register(mediatype, key, data, langmask) - key must be string, got "..type(key))
	end
	mediatype = string_lower(mediatype)
	if not self.MediaTable[mediatype] then
		self.MediaTable[mediatype] = {}
	end
	local mtable = self.MediaTable[mediatype]
	local oldvalue = mtable[key]
	mtable[key] = data
	if not oldvalue then
		rebuildMediaList(mediatype)
		self.CallbackRegistry:Fire("LibSharedMedia_Registered", mediatype, key)
	end
end

-- Return the file path for the given mediatype and key.
--
-- mediatype		- type of the media
-- key				- unique name of the media
function lib:Fetch(mediatype, key, noDefault)
	if type(mediatype) ~= "string" then
		error(MAJOR..":Fetch(mediatype, key) - mediatype must be string, got "..type(mediatype))
	end
	if type(key) ~= "string" then
		error(MAJOR..":Fetch(mediatype, key) - key must be string, got "..type(key))
	end
	mediatype = string_lower(mediatype)
	local mtable = self.MediaTable[mediatype]
	if mtable then
		local value = mtable[key]
		if value then
			return value
		end
	end
	if not noDefault then
		return self.DefaultMedia[mediatype] and self.DefaultMedia[mediatype][key]
	end
end

-- Return a list of all registered media of the given type.
-- The list is a copy and can be modified freely.
--
-- mediatype		- type of the media
function lib:List(mediatype)
	if type(mediatype) ~= "string" then
		error(MAJOR..":List(mediatype) - mediatype must be string, got "..type(mediatype))
	end
	mediatype = string_lower(mediatype)
	local list = self.MediaList[mediatype]
	local retlist = {}
	if list then
		for i, key in pairs(list) do
			retlist[i] = key
		end
	end
	return retlist
end

-- Return an iterator over all registered media of the given type.
-- This is the most efficient way to iterate.
--
-- mediatype		- type of the media
function lib:HashTable(mediatype)
	if type(mediatype) ~= "string" then
		error(MAJOR..":HashTable(mediatype) - mediatype must be string, got "..type(mediatype))
	end
	mediatype = string_lower(mediatype)
	return self.MediaTable[mediatype]
end

-- Return true if the given media is registered.
--
-- mediatype		- type of the media
-- key				- unique name of the media
function lib:IsValid(mediatype, key)
	if type(mediatype) ~= "string" then
		error(MAJOR..":IsValid(mediatype, key) - mediatype must be string, got "..type(mediatype))
	end
	if type(key) ~= "string" then
		error(MAJOR..":IsValid(mediatype, key) - key must be string, got "..type(key))
	end
	mediatype = string_lower(mediatype)
	local mtable = self.MediaTable[mediatype]
	if mtable then
		return mtable[key] ~= nil
	end
	return false
end
