function cc --description 'Clear user and system caches safely'

    echo
    echo "╭──────────────────────────────────────────────╮"
    echo "│              Cache Cleaner                   │"
    echo "╰──────────────────────────────────────────────╯"
    echo
    
    # ─────────────────────────────────────────────
    # User caches
    # ─────────────────────────────────────────────
    
    echo "[1/10] Clearing disposable user caches"
    
    set -l cache_dirs \
        ~/.cache/thumbnails \
        ~/.cache/fontconfig \
        ~/.cache/mesa_shader_cache \
        ~/.cache/mesa_shader_cache_db \
        ~/.cache/qtshadercache \
        ~/.cache/qt6shadercache
    
    for dir in $cache_dirs
        if test -e "$dir"
            rm -rf -- "$dir"
            echo "      removed: $dir"
        end
    end
    
    # Caelestia may contain root-owned files
    if test -d ~/.cache/caelestia
        sudo rm -rf -- ~/.cache/caelestia
        mkdir -p ~/.cache/caelestia
        echo "      cleaned: ~/.cache/caelestia"
    end
    
    # ─────────────────────────────────────────────
    # Trash
    # ─────────────────────────────────────────────
    
    echo
    echo "[2/10] Emptying Trash completely"
    
    if test -d ~/.local/share/Trash
        rm -rf -- ~/.local/share/Trash/
        echo "      Trash emptied"
    end
    
    # ─────────────────────────────────────────────
    # npm
    # ─────────────────────────────────────────────
    
    echo
    echo "[3/10] Cleaning npm cache"
    
    if type -q npm
        npm cache clean --force
    else
        echo "      npm not installed"
    end
    
    # ─────────────────────────────────────────────
    # pip
    # ─────────────────────────────────────────────
    
    echo
    echo "[4/10] Cleaning pip cache"
    
    if type -q python
        python -m pip cache purge 2>/dev/null
    else
        echo "      Python not installed"
    end
    
    # ─────────────────────────────────────────────
    # Steam
    # ─────────────────────────────────────────────
    
    echo
    echo "[5/10] Cleaning Steam shader + temporary cache"
    
    set -l steam_dirs \
        ~/.steam/steam/steamapps/shadercache \
        ~/.steam/steam/steamapps/temp \
        ~/.local/share/Steam/steamapps/shadercache \
        ~/.local/share/Steam/steamapps/temp
    
    for dir in $steam_dirs
        if test -d "$dir"
            find "$dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
            echo "      cleaned: $dir"
        end
    end
    
    # ─────────────────────────────────────────────
    # Burp Suite
    # ─────────────────────────────────────────────
    
    echo
    echo "[6/10] Cleaning Burp Suite temporary data"
    
    set -l burp_dirs \
        ~/.BurpSuite/caches \
        ~/.BurpSuite/tmp \
        ~/.BurpSuite/logs
    
    for dir in $burp_dirs
        if test -e "$dir"
            rm -rf -- "$dir"
            echo "      removed: $dir"
        end
    end
    
    # ─────────────────────────────────────────────
    # Pacman
    # ─────────────────────────────────────────────
    
    echo
    echo "[7/10] Cleaning pacman cache"
    
    if type -q paccache
        sudo paccache -r
    end
    
    sudo pacman -Sc --noconfirm
    
    # ─────────────────────────────────────────────
    # Systemd journal
    # ─────────────────────────────────────────────
    
    echo
    echo "[8/10] Vacuuming systemd journal"
    
    sudo journalctl --vacuum-size=100M
    
    # ─────────────────────────────────────────────
    # Locale purge
    # ─────────────────────────────────────────────
    
    echo
    echo "[9/10] Purging unused locales"
    
    if type -q localepurge
        sudo localepurge
    else
        echo "      localepurge not installed — skipped"
    end
    
    # ─────────────────────────────────────────────
    # Baloo
    # ─────────────────────────────────────────────
    
    echo
    echo "[10/10] Checking Baloo"
    
    if type -q balooctl6
        echo "      Baloo database left untouched"
    end
    
    # ─────────────────────────────────────────────
    # Complete
    # ─────────────────────────────────────────────
    
    echo
    echo "╭──────────────────────────────────────────────╮"
    echo "│          Cache cleanup complete              │"
    echo "╰──────────────────────────────────────────────╯"
    echo
    
end
