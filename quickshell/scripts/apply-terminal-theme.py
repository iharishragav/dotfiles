#!/usr/bin/env python3

import json
from pathlib import Path

wal = Path.home() / ".cache/wal/colors.json"
data = json.loads(wal.read_text())
c = data["colors"]

def rgb(name):
    return c[name].lstrip("#")

# Pywal palette
color0  = rgb("color0")
color1  = rgb("color1")
color2  = rgb("color2")
color3  = rgb("color3")
color4  = rgb("color4")
color5  = rgb("color5")
color6  = rgb("color6")
color7  = rgb("color7")
color8  = rgb("color8")
color9  = rgb("color9")
color10 = rgb("color10")
color11 = rgb("color11")
color12 = rgb("color12")
color13 = rgb("color13")
color14 = rgb("color14")
color15 = rgb("color15")

# ---------------- Kitty ----------------

kitty = Path.home() / ".config/kitty/colors-wal.conf"

kitty.write_text(f"""# Generated from ~/.cache/wal/colors.json
# Do not hand-edit

foreground #{color7}
background #{color0}

color0  #{color0}
color1  #{color1}
color2  #{color2}
color3  #{color3}
color4  #{color4}
color5  #{color5}
color6  #{color6}
color7  #{color7}

color8  #{color8}
color9  #{color9}
color10 #{color10}
color11 #{color11}
color12 #{color12}
color13 #{color13}
color14 #{color14}
color15 #{color15}
""")

# ---------------- Starship ----------------

starship = Path.home() / ".config/starship-wal.toml"

starship.write_text(f"""# Generated from ~/.cache/wal/colors.json
# Do not hand-edit

[character]
success_symbol = "[◎ ](bold italic #{color4})"
error_symbol = "[○ ](italic #{color1})"
vimcmd_symbol = "[■ ](italic #{color2})"

[sudo]
style = "bold italic #{color5}"

[username]
style_user = "bold italic #{color3}"
style_root = "bold italic #{color5}"

[directory]
style = "italic #{color4}"
repo_root_style = "bold #{color4}"
repo_root_format = '[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) [△](bold #{color4})'

[cmd_duration]
format = "[◄ $duration ](italic #{color7})"

[time]
style = "italic #{color7}"

[git_branch]
style = "italic #{color4}"
symbol = "[△](bold italic #{color4})"

[battery]
format = "[ $percentage $symbol]($style)"

[[battery.display]]
threshold = 20
style = "italic bold #{color1}"

[[battery.display]]
threshold = 60
style = "italic dimmed #{color5}"

[[battery.display]]
threshold = 70
style = "italic dimmed #{color3}"
""")

# ---------------- Fastfetch ----------------

fastfetch = Path.home() / ".config/fastfetch/colors-wal.jsonc"

fastfetch.write_text(f"""// Generated from ~/.cache/wal/colors.json
{{
    "display": {{
        "color": "#{color7}",
        "constants": [
            "\\u001b[38;2;{int(color1[0:2],16)};{int(color1[2:4],16)};{int(color1[4:6],16)}m",
            "\\u001b[38;2;{int(color4[0:2],16)};{int(color4[2:4],16)};{int(color4[4:6],16)}m",
            "\\u001b[38;2;{int(color6[0:2],16)};{int(color6[2:4],16)};{int(color6[4:6],16)}m",
            "\\u001b[38;2;{int(color5[0:2],16)};{int(color5[2:4],16)};{int(color5[4:6],16)}m"
        ]
    }}
}}
""")
