#!/usr/bin/python
from os import makedirs
from os.path import expanduser, join, exists
import json
import requests
import logging

logging.basicConfig(level=logging.INFO)

def download_file_iterative(url: str, path: str):
    """Downloads a file from a given url into a given path."""
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(path, 'wb') as f:
            logging.info(f'\tDownloading: {path}')
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)

def download_file(url: str, path: str): 
    with open(path, 'wb') as current_file: 
        gh_file = requests.get(url)
        current_file.write(gh_file.content)


def list_dir(url: str):
    """Returns a json of folder contents from github api"""
    gh_json = requests.get(url).json() 
    if 'message' in gh_json and 'rate limit' in gh_json['message']: 
        raise RateLimitError("Wait an hour... You're rate limited...")
    return gh_json


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

class RateLimitError(Exception): 
    pass 

if __name__ == '__main__':
    homedir_url='https://api.github.com/repos/santosderek/repo/contents/homedir/'
    home_folder_path=expanduser('~')
    logging.info(f'Looking into folder: {home_folder_path}')
    download_folder_recursive(homedir_url, home_folder_path)
