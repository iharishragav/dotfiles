#!/usr/bin/env python3
from pathlib import Path
import random

p = Path.home() / ".cache/quickshell-rice/startpage-wallpaperss"
p.mkdir(parents=True, exist_ok=True)

data = {
    "gruvbox": ("282828", "d79921", "98971a"),
    "catppuccin-mocha": ("1e1e2e", "89b4fa", "cba6f7"),
    "rose-pine": ("191724", "c4a7e7", "eb6f92"),
    "nord": ("2e3440", "88c0d0", "81a1c1"),
    "tokyo-night": ("1a1b26", "7aa2f7", "bb9af7"),
    "dracula": ("282a36", "bd93f9", "ff79c6"),
}


def pick_background(a, b):
    backgrounds = [
        (
            f'<circle cx="350" cy="250" r="700" '
            f'fill="url(#g)"/>'
            f'<circle cx="1600" cy="830" r="620" '
            f'fill="#{b}" opacity=".35"/>'
        ),
        (
            f'<circle cx="960" cy="540" r="850" '
            f'fill="url(#g)"/>'
            f'<circle cx="200" cy="900" r="500" '
            f'fill="#{a}" opacity=".30"/>'
        ),
        (
            f'<ellipse cx="300" cy="300" rx="900" ry="500" '
            f'fill="url(#g)"/>'
            f'<ellipse cx="1650" cy="850" rx="700" ry="400" '
            f'fill="#{b}" opacity=".30"/>'
        ),
        (
            f'<circle cx="1500" cy="250" r="650" '
            f'fill="url(#g)"/>'
            f'<circle cx="350" cy="850" r="550" '
            f'fill="#{b}" opacity=".30"/>'
        ),
        (
            f'<ellipse cx="960" cy="150" rx="1100" ry="650" '
            f'fill="url(#g)"/>'
            f'<ellipse cx="960" cy="1050" rx="900" ry="450" '
            f'fill="#{b}" opacity=".28"/>'
        ),
    ]

    return random.choice(backgrounds)


for name, (bg, a, b) in data.items():
    background = pick_background(a, b)

    t = (
        '<svg xmlns="http://www.w3.org/2000/svg" '
        'viewBox="0 0 1920 1080">'
        '<defs>'
        '<radialGradient id="g">'
        '<stop stop-color="#%s" stop-opacity=".65"/>'
        '<stop offset="1" stop-color="#%s"/>'
        '</radialGradient>'
        '</defs>'
        '<rect width="1920" height="1080" fill="#%s"/>'
        '%s'
        '</svg>'
    )

    (p / (name + ".svg")).write_text(
        t % (a, b, bg, background)
    )
