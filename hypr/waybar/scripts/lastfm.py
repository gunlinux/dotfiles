import requests
import logging
import os
from dotenv import load_dotenv

load_dotenv()
logger = logging.getLogger(__name__)


class Track:
    def __init__(self, data):
        tracks = data.get("recenttracks", {}).get('track')
        if tracks is None:
            return

        self.track = tracks[0]
        self.artist = self.name = ""
        attr = self.track.get('@attr', False)
        self.nowplaying = attr and attr.get("nowplaying", False) == "true"
        if not self.nowplaying:
            return
        self._get_artist_track(self.track)

    def _get_artist_track(self, track):
        self.artist = track.get("artist", {}).get("#text", "")
        self.name = track.get("name", "")

    def pretty(self):
        if self.name and self.artist:
            return f"{self.artist} - {self.name}"
        return ""


def get_data(api_key: str, url: str = "http://ws.audioscrobbler.com/2.0/"):
    params = {
        "api_key": api_key,
        "user": "gunlinux",
        "nowplaying": "true",
        "limit": 1,
        "method": "user.getrecenttracks",
        "format": "json",
    }
    req = requests.post(url, params=params)
    return req.json() 


def main():
    api_key = os.environ['api_key']
    data = get_data(api_key)
    track = Track(data)
    print(track.pretty())


if __name__ == "__main__":
    main()


