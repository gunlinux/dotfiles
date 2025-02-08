import requests
import xmltodict
import logging
import os
from dotenv import load_dotenv
from get_youtube import get_song_from_youtube 

load_dotenv()
logger = logging.getLogger(__name__)


class Track:
    def __init__(self, data):
        self.status = False
        lfm = data.get("lfm", None)
        if not lfm:
            return

        self.status = lfm.get("@status", False)
        if not self.status:
            return

        self.tracks = lfm.get("recenttracks", {}).get("track", [])
        self.artist = self.name = ""

        if not self.tracks or not isinstance(self.tracks, list):
            self.nowplaying = False
            return
        self.nowplaying = self.tracks[0].get("@nowplaying", False) == "true"
        if not self.nowplaying:
            return
        self._get_artist_track(self.tracks[0])

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
    }
    req = requests.get(url, params=params)
    if req.status_code != 200:
        return
    try:
        data = xmltodict.parse(req.text)
    except Exception as e:
        logger.critical("cant parse answer %s", e)
        return
    return data


def main():
    api_key = os.environ.get('api_key', '')
    data = get_data(api_key)
    print(data)
    track = Track(data)
    if not track.status or not track.nowplaying:
        youtube = get_song_from_youtube()
        if youtube:
            print(youtube)
        return

    print(track.pretty())


if __name__ == "__main__":
    main()


