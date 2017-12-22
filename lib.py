import requests
import glob2
import os
from urllib.parse import urlparse

def get_filelist(file):
    with open(file, "r") as f:
        _data = f.read()
    li = _data.split('\n')
    data = [d for d in li if d != '']
    return data

def generate_dest_path(url, parent_dir='.'):
    li = urlparse(url).path.split('/')[-2:]
    dest = parent_dir + '/' + '/'.join(li)
    return dest

def download_file(source, destination, mode='wb'):
    response = requests.get(source, stream=True)
    with open(destination, mode) as f:
        for chunk in response.iter_content(chunk_size=512):
            f.write(chunk)

files = get_filelist("filelist.txt")
for url in files:
    dest = generate_dest_path(url, parent_dir='./Deps')
    print("Downloading " + url + " to " + dest)
    download_file(url, dest)


