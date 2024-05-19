import subprocess
import json


def current_play(clients, class_="firefox") -> str:
    browser_map = {
        "firefox": "Picture-in-Picture",
    }
    nowplaying = False
    browsers = []
    for client in clients:
        if client["class"] == class_:
            if client["title"] == browser_map[class_]:
                nowplaying = True
            else:
                browsers.append(client["title"])
    if not nowplaying or not browsers:
        return ""
    return get_song(browsers)


def get_song(browsers: list[str]) -> str:
    for title in browsers:
        rez = get_song_from_title(title)
        if rez:
            return rez


def get_song_from_title(browser_title: str) -> str:
    browsers_map = ['- YouTube — Mozilla Firefox']
    for br in browsers_map:
        if browser_title.endswith(br):
            title = browser_title.replace(br, '')
            return title
    return ''


def get_clients() -> list[dict]:
    args = ["hyprctl", "clients", "-j"]
    with subprocess.Popen(args, stdout=subprocess.PIPE) as proc:
        output = proc.stdout.read()

    if output:
        return json.loads(output)
    return []


def get_song_from_youtube():
    clients = get_clients()
    return current_play(clients)


if __name__ == '__main__':
    get_song_from_youtube()
