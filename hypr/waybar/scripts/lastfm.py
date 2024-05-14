import requests
import xmltodict
import logging
import os
from dotenv import load_dotenv

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
    track = Track(data)
    if not track.status or not track.nowplaying:
        return

    print(track.pretty())


if __name__ == "__main__":
    main()
"""
without
{'lfm': {'@status': 'ok', 'recenttracks': {'@user': 'gunlinux', '@page': '1', '@perPage': '1', '@totalPages': '164654', '@total': '164654', 'track': {'artist': {'@mbid': '', '#text': 'DIGITAL REY'}, 'name': 'every time', 'streamable': '0', 'mbid': None, 'album': {'@mbid': '', '#text': 'every time'}, 'url': 'https://www.last.fm/music/DIGITAL+REY/_/every+time', 'image': [{'@size': 'small', '#text': 'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'medium', '#text': 'https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'large', '#text': 'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'extralarge', '#text': 'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png'}], 'date': {'@uts': '1715689300', '#text': '14 May 2024, 12:21'}}}}}
"""

""" ACTIVE_OMG_!
{'lfm': {'@status': 'ok', 'recenttracks': {'@user': 'gunlinux', '@page': '1', '@perPage': '1', '@totalPages': '164654', '@total': '164654', 'track': [{'@nowplaying': 'true', 'artist': {'@mbid': 'df1356d3-3c66-48bc-ac79-475c6cf76266', '#text': 'Gunship'}, 'name': 'Tech Noir', 'streamable': '0', 'mbid': '0515ca9f-4395-494c-a7bc-408b7ec364d7', 'album': {'@mbid': '1246a349-e3e2-46be-b51d-9986d216347a', '#text': 'Gunship'}, 'url': 'https://www.last.fm/music/Gunship/_/Tech+Noir', 'image': [{'@size': 'small', '#text': 'https://lastfm.freetls.fastly.net/i/u/34s/99947e68c0f44af76f1559af8734afd0.jpg'}, {'@size': 'medium', '#text': 'https://lastfm.freetls.fastly.net/i/u/64s/99947e68c0f44af76f1559af8734afd0.jpg'}, {'@size': 'large', '#text': 'https://lastfm.freetls.fastly.net/i/u/174s/99947e68c0f44af76f1559af8734afd0.jpg'}, {'@size': 'extralarge', '#text': 'https://lastfm.freetls.fastly.net/i/u/300x300/99947e68c0f44af76f1559af8734afd0.jpg'}]}, {'artist': {'@mbid': '', '#text': 'DIGITAL REY'}, 'name': 'every time', 'streamable': '0', 'mbid': None, 'album': {'@mbid': '', '#text': 'every time'}, 'url': 'https://www.last.fm/music/DIGITAL+REY/_/every+time', 'image': [{'@size': 'small', '#text': 'https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'medium', '#text': 'https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'large', '#text': 'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png'}, {'@size': 'extralarge', '#text': 'https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png'}], 'date': {'@uts': '1715689300', '#text': '14 May 2024, 12:21'}}]}}}
"""
