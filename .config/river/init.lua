local mod = "Mod4"
local mod1 = "Mod1"

-- Function to handle riverctl commands via Lua
local function river(cmd)
    os.execute("riverctl " .. cmd)
end

-- --- General Mappings ---
local maps = {
    { mod, "Return", "spawn foot" },
    { mod, "Q", "close" },
    { mod .. "+Shift", "Q", "exit" },
    { mod, "B", "spawn 'killall -SIGUSR1 waybar'" },
    { mod, "C", "spawn 'rofi -show drun -show-icons -display-drun Search'" },
    { mod, "Y", "spawn '~/.config/river/scripts/yt'" },
    { mod, "W", "spawn woomer" },
    { mod .. "+Shift", "L", "spawn 'swaylock -i ~/.dotfiles/.assets/wallpapers/archlinux.png'" },
    { mod .. "+Shift", "R", "spawn '~/.config/river/init'" },
    
    -- Discord with all your flags
    { mod .. "+Shift", "D", "spawn 'discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy'" },

    -- Layout & View
    { mod, "J", "focus-view next" },
    { mod, "K", "focus-view previous" },
    { mod .. "+Shift", "J", "swap next" },
    { mod .. "+Shift", "K", "swap previous" },
    { mod, "F", "toggle-float" },
    { mod, "M", "toggle-fullscreen" },
    
    -- Layout control
    { mod, "H", "send-layout-cmd rivertile 'main-ratio -0.05'" },
    { mod, "L", "send-layout-cmd rivertile 'main-ratio +0.05'" },
}

-- Apply Mappings
for _, map in ipairs(maps) do
    river(string.format("map normal %s %s %s", map[1], map[2], map[3]))
end

-- --- Tags Loop (1-7) ---
for i = 1, 7 do
    local tags = 1 << (i - 1)
    river(string.format("map normal %s %d set-focused-tags %d", mod, i, tags))
    river(string.format("map normal %s+Shift %d set-view-tags %d", mod, i, tags))
end

-- --- Pointer Controls ---
river(string.format("map-pointer normal %s BTN_LEFT move-view", mod))
river(string.format("map-pointer normal %s BTN_RIGHT resize-view", mod))

-- --- Rules ---
river("rule-add -app-id float float")
river("border-color-focused 0x5e81ac")
river("border-color-unfocused 0x4c566a")
