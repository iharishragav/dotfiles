config.load_autoconfig(False)
c.editor.command = ["kitty", "nvim", "{}"]
# Allow JavaScript
c.content.javascript.enabled = True

config.bind(',v', 'spawn --detach streamlink --player vlc {url} best')
config.bind(',m', 'spawn --detach mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" {url}')

# Allow all cookies

c.content.cookies.accept = "all"

# Disable the ad/content blocker

#config.set('content.blocking.enabled', True)
#config.set('content.blocking.method', 'adblock')
#config.set('content.blocking.adblock.lists', [
#    'https://easylist.to/easylist/easylist.txt',
#    'https://easylist.to/easylist/easyprivacy.txt',
#])



#Allow autoplay
c.content.autoplay = True

# Allow images
c.content.images = True

# Allow notifications
c.content.notifications.enabled = True

# Allow geolocation requests
c.content.geolocation = True

# Allow media playback
c.content.media.audio_capture = True
c.content.media.video_capture = True

with config.pattern("*://web.whatsapp.com/*"):
    c.content.javascript.enabled = True
    c.content.cookies.accept = "all"
    c.content.headers.user_agent = (
        "Mozilla/5.0 (X11; Linux x86_64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/131.0.0.0 Safari/537.36"
    )

c.qt.args = ["ignore-gpu-blocklist", "enable-gpu-rasterization", "enable-zero-copy", "enable-accelerated-video-decode"]

c.url.searchengines = {
    'DEFAULT': 'https://www.duckduckgo.com/search?q={}',
    'g': 'https://www.google.com/search?q={}',
}

# Load rice colors
try:
    config.source('colors-wal.py')
except Exception:
    pass
