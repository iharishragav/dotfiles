#!/usr/bin/env python3
"""Generate a complete Starship config with pywal-derived color tokens."""

import re
import sys
from pathlib import Path

from color_utils import load_colors
from paths import STARSHIP_CONFIG, STARSHIP_WAL_CONFIG, WAL_COLORS


def main():
    colors_json = Path(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1] else WAL_COLORS
    source = STARSHIP_CONFIG.read_text(encoding="utf-8")
    data = load_colors(colors_json)
    colors = data["colors"]
    special = data.get("special", {})

    replacements = {
        "bright-yellow": colors.get("color3", special.get("foreground", "#ffffff")),
        "yellow": colors.get("color3", special.get("foreground", "#ffffff")),
        "purple": colors.get("color5", special.get("foreground", "#ffffff")),
        "bright-purple": colors.get("color5", special.get("foreground", "#ffffff")),
        "dimmed bright-purple": colors.get("color5", special.get("foreground", "#ffffff")),
        "dimmed green": colors.get("color2", special.get("foreground", "#ffffff")),
        "green": colors.get("color2", special.get("foreground", "#ffffff")),
        "bright-blue": colors.get("color4", special.get("foreground", "#ffffff")),
        "blue": colors.get("color4", special.get("foreground", "#ffffff")),
        "red": colors.get("color1", special.get("foreground", "#ffffff")),
        "white": special.get("foreground", "#ffffff"),
    }

    generated = source
    for name, value in sorted(replacements.items(), key=lambda item: len(item[0]), reverse=True):
        generated = re.sub(rf"(?<![A-Za-z0-9_-]){re.escape(name)}(?![A-Za-z0-9_-])", value, generated)

    STARSHIP_WAL_CONFIG.write_text(
        "# Generated from ~/.cache/wal/colors.json; do not hand-edit\n" + generated,
        encoding="utf-8",
    )
    print(f"starship: colors updated in {STARSHIP_WAL_CONFIG}")


if __name__ == "__main__":
    main()
