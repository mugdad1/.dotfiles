# --- XDG Base Directories ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# --- Desktop Environment ---
export XDG_CURRENT_DESKTOP=river
export XDG_SESSION_DESKTOP=river
export XDG_SESSION_TYPE=wayland

# --- Toolkit Backends (Wayland First) ---
export GDK_BACKEND=wayland,x11
export QT_QPA_PLATFORM="wayland;xcb"
export SDL_VIDEODRIVER=wayland       # Changed from x11 to wayland
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export ANKI_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1

# --- Theming & Scaling ---
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export GDK_DPI_SCALE=1.3
export GDK_SCALE=1.3

# --- Preferences ---
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Fixed the quoting error
export GPG_TTY=$(tty)
export CHROME_EXECUTABLE="/usr/bin/brave"

# --- Path Cleanup ---
# Start with a clean base and add directories only if they exist
path_add() {
    [ -d "$1" ] && PATH="$1:$PATH"
}

path_add "$HOME/.local/bin"
path_add "$HOME/.bin"
path_add "$HOME/.cargo/bin"
path_add "$HOME/go/bin"
path_add "$HOME/.local/share/pnpm"
path_add "$HOME/.spicetify"
# path_add "$HOME/flutter/bin" # Be careful with `pwd` in profile; use absolute path

export PATH

# --- Autostart River on TTY1 ---
if [[ -z $WAYLAND_DISPLAY && $(tty) = "/dev/tty1" ]]; then
    # Generate a simple timestamp for the log
    timestamp=$(date +%F-%T)
    exec dbus-run-session river -log-level debug > "/tmp/river-${timestamp}.log" 2>&1
fi
