"""Stable user paths shared by the Python theme-application scripts."""

from pathlib import Path


HOME = Path.home()
WAL_COLORS = HOME / ".cache/wal/colors.json"
KITTY_CONFIG = HOME / ".config/kitty/kitty.conf"
QUTEBROWSER_CONFIG = HOME / ".config/qutebrowser"
FASTFETCH_CONFIG = HOME / ".config/fastfetch/config.jsonc"
STARTPAGE_WALLPAPERS = HOME / ".cache/quickshell-rice/startpage-wallpapers"
STARSHIP_CONFIG = HOME / ".config/starship.toml"
STARSHIP_WAL_CONFIG = HOME / ".config/starship-wal.toml"
