#!/bin/bash
Red='\e[0;31m'; Gre='\e[0;32m'; Whi='\e[0;37m'; 

echo -e "[${Gre}*${Whi}] Setting up config files"
cd ~/.dotfiles

# --- 1. Cleanup ---
echo -e "➞ [${Red}*${Whi}] Removing existing config directories"
# This clears out existing symlinks in ~/.config to prevent stow conflicts
for dir in $(ls -d .config/*/ 2>/dev/null | sed 's|.config/||' | sed 's|/||'); do
    rm -rf ~/.config/"$dir"
done

# --- 2. Generate Beansprout Structure ---
mkdir -p .config/river
mkdir -p .config/beansprout

# Create the River 0.4.1 entry point
cat <<EOF > .config/river/init
#!/bin/sh
# This hands off control to the Beansprout window manager
exec beansprout
EOF

# Make the init script executable so River can run it
chmod +x .config/river/init

# Create the Beansprout KDL config
cat <<EOF > .config/beansprout/config.kdl
autostart {
    spawn "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river"
    spawn "rivertile -main-ratio 0.5 -view-padding 2 -outer-padding 2"
    spawn "waybar"
    spawn "mako"
    spawn "nm-applet --indicator"
    spawn "wlsunset -T 4500"
    spawn "swaybg -i ~/.dotfiles/.assets/wallpapers/warrior_nord.jpg -m fill"
    spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    spawn "twenty --init"
    spawn "brightnessctl set 20%"
    spawn "~/.config/scripts/updates.sh"
}

bindings {
    // Launchers
    map mod="Logo" key="Return" action="Spawn" arg="foot"
    map mod="Logo" key="C"      action="Spawn" arg="rofi -show drun -show-icons"
    map mod="Logo" key="Y"      action="Spawn" arg="~/.config/river/scripts/yt"
    map mod="Logo" key="W"      action="Spawn" arg="woomer"

    // Discord with specific GPU/Wayland flags
    map mod="Logo+Shift" key="D" action="Spawn" arg="discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy"

    // Window Management
    map mod="Logo" key="Q"      action="Close"
    map mod="Logo+Shift" key="Q" action="Exit"
    map mod="Logo" key="F"      action="ToggleFloat"
    map mod="Logo" key="M"      action="ToggleFullscreen"
    map mod="Logo" key="B"      action="Spawn" arg="killall -SIGUSR1 waybar"
    
    // Focus & Movement
    map mod="Logo" key="J"      action="FocusNext"
    map mod="Logo" key="K"      action="FocusPrevious"
    map mod="Logo+Shift" key="J" action="SwapNext"
    map mod="Logo+Shift" key="K" action="SwapPrevious"

    // Layout (Rivertile)
    map mod="Logo" key="H"      action="SendLayoutCmd" arg="rivertile main-ratio -0.05"
    map mod="Logo" key="L"      action="SendLayoutCmd" arg="rivertile main-ratio +0.05"

    // Control
    map mod="Logo+Shift" key="L" action="Spawn" arg="swaylock -i ~/.dotfiles/.assets/wallpapers/archlinux.png"
    map mod="Logo+Shift" key="R" action="ReloadConfig"
}

tags {
    // Tags 1 through 7
    map mod="Logo" key="1" action="SetFocusedTags" arg="1"
    map mod="Logo" key="2" action="SetFocusedTags" arg="2"
    map mod="Logo" key="3" action="SetFocusedTags" arg="3"
    map mod="Logo" key="4" action="SetFocusedTags" arg="4"
    map mod="Logo" key="5" action="SetFocusedTags" arg="5"
    map mod="Logo" key="6" action="SetFocusedTags" arg="6"
    map mod="Logo" key="7" action="SetFocusedTags" arg="7"

    map mod="Logo+Shift" key="1" action="SetViewTags" arg="1"
    map mod="Logo+Shift" key="2" action="SetViewTags" arg="2"
    map mod="Logo+Shift" key="3" action="SetViewTags" arg="3"
    map mod="Logo+Shift" key="4" action="SetViewTags" arg="4"
    map mod="Logo+Shift" key="5" action="SetViewTags" arg="5"
    map mod="Logo+Shift" key="6" action="SetViewTags" arg="6"
    map mod="Logo+Shift" key="7" action="SetViewTags" arg="7"
}

appearance {
    border-width 2
    border-color-focused "#5e81ac"
    border-color-unfocused "#4c566a"
    focus-follows-cursor true
}
EOF

# --- 3. Final Stow ---
echo -e "➞ [${Gre}*${Whi}] Symlinking directories"
# We stow from the .config folder inside dotfiles to the ~/.config system folder
stow -v -t ~/.config .config
# Optional: Stow home files if they exist
if [ -d ".home" ]; then
    stow -v -t ~ .home
fi

echo -e "[${Gre}*${Whi}] Finished setting up Beansprout on River 0.4.1"

