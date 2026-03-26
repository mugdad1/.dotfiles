-- --- Configuration ---
local mod = "logo"     -- Mod4 (Super/Windows key)
local alt = "alt"      -- Mod1

-- --- 1. Autostart (Environment & UI) ---
-- These run once when the manager starts
river.spawn("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river")
river.spawn("rivertile -main-ratio 0.5 -view-padding 2 -outer-padding 2")
river.spawn("waybar")
river.spawn("mako")
river.spawn("nm-applet --indicator")
river.spawn("wlsunset -T 4500")
river.spawn("swaybg -i ~/.dotfiles/.assets/wallpapers/warrior_nord.jpg -m fill")
river.spawn("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
river.spawn("twenty --init")
river.spawn("brightnessctl set 20%")
river.spawn("~/.config/scripts/updates.sh")

-- --- 2. Keyboard Mappings ---
-- Format: { {modifiers}, key, function, arguments... }
local mappings = {
    -- Terminals & Launchers
    { {mod}, "Return", river.spawn, "foot" },
    { {mod}, "C", river.spawn, "rofi -show drun -show-icons -display-drun Search" },
    { {mod}, "Y", river.spawn, "~/.config/river/scripts/yt" },
    { {mod}, "W", river.spawn, "woomer" },
    
    -- Compositor Actions
    { {mod}, "Q", river.close },
    { {mod, "shift"}, "Q", river.exit },
    { {mod}, "F", river.toggle_float },
    { {mod}, "M", river.toggle_fullscreen },
    { {mod}, "B", river.spawn, "killall -SIGUSR1 waybar" },
    
    -- Focus & Movement
    { {mod}, "J", river.focus_view, "next" },
    { {mod}, "K", river.focus_view, "previous" },
    { {mod, "shift"}, "J", river.swap, "next" },
    { {mod, "shift"}, "K", river.swap, "previous" },
    
    -- Layout Modification
    { {mod}, "H", river.send_layout_cmd, "rivertile", "main-ratio -0.05" },
    { {mod}, "L", river.send_layout_cmd, "rivertile", "main-ratio +0.05" },

    -- Discord (with your specific flags)
    { {mod, "shift"}, "D", river.spawn, "discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy" },
    
    -- Locking & Reloading
    { {mod, "shift"}, "L", river.spawn, "swaylock -i ~/.dotfiles/.assets/wallpapers/archlinux.png" },
    { {mod, "shift"}, "R", river.spawn, "~/.config/river/init" },
}

-- Register all keyboard maps
for _, m in ipairs(mappings) do
    river.map("normal", m[1], m[2], m[3], table.unpack(m, 4))
end

-- --- 3. Tags Loop (1-7) ---
for i = 1, 7 do
    local tags = 1 << (i - 1)
    river.map("normal", {mod}, tostring(i), river.set_focused_tags, tags)
    river.map("normal", {mod, "shift"}, tostring(i), river.set_view_tags, tags)
end

-- --- 4. Pointer Controls ---
river.map_pointer("normal", {mod}, "BTN_LEFT", river.move_view)
river.map_pointer("normal", {mod}, "BTN_RIGHT", river.resize_view)

-- --- 5. Rules & Styling ---
river.rule_add({ app_id = "float", action = "float" })

river.set_border_color_focused(0x5e81ac)
river.set_border_color_unfocused(0x4c566a)
river.set_focus_follows_cursor("normal")
river.set_default_layout("rivertile")

-- --- 6. Input Handling (Touchpad) ---
river.on_input_device_added(function(device)
    if device.type == "touchpad" then
        device:set_events("enabled")
        device:set_tap("enabled")
    end
end)
