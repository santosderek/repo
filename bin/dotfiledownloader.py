#!/usr/bin/python
from os import makedirs
from os.path import expanduser, join, exists
import json
import requests
import logging

logging.basicConfig(level=logging.INFO)

def download_file(url: str, path: str):
    """Downloads a file from a given url into a given path."""
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(path, 'wb') as f:
            logging.info(f'\tDownloading: {path}')
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)


def list_dir(url: str):
    """Returns a json of folder contents from github api"""
    return requests.get(url).json()


def download_folder_recursive(url: str, path: str):
    contents = list_dir(url)

    for item in contents:
        if item['type'] == 'dir':
            logging.info(f'Looking into folder: {item["path"]}')
            new_path = join(path, item['name'])
            if not exists(new_path):
                makedirs(new_path, 0o775)
            download_folder_recursive(item['url'], new_path)

        elif item['type'] == 'file':
            download_file(item['download_url'], join(path, item['name']))

if __name__ == '__main__':
    homedir_url='https://api.github.com/repos/santosderek/repo/contents/homedir/'
    home_folder_path=expanduser('~')
    download_folder_recursive(homedir_url, home_folder_path)
