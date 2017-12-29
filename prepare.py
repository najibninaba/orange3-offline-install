import os
from urllib.parse import urlparse
import requests
import nltk
import colorama
import click

NLTK_DATA_DIR = "nltk_data"

SUPPORT_DIRS = [
    "Packages/noarch",
    "Packages/win-32",
    "Packages/win-64",
    NLTK_DATA_DIR
]

ORANGE_PACKAGES_TO_DOWNLOAD = "python-packages.txt"
ORANGE_ICON_TO_DOWNLOAD = "https://raw.githubusercontent.com/biolab/orange3/master/scripts/windows/orange.ico"

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

def download_file(source, destination, mode='wb', overwrite=False):
    if os.path.exists(destination):
        return
    
    response = requests.get(source, stream=True)
    with open(destination, mode) as f:
        for chunk in response.iter_content(chunk_size=512):
            f.write(chunk)

def download_all_nltk_data(rootdir, nltk_data_dir=NLTK_DATA_DIR):
    nltk.download("all", download_dir=os.path.join(rootdir, nltk_data_dir))

def download_orange_icon(destdir):
    download_file(ORANGE_ICON_TO_DOWNLOAD, destination=os.path.join(destdir, "orange.ico"))

def mkdir_support_dirs(rootdir, support_dirs=SUPPORT_DIRS):
    for d in support_dirs:
        os.makedirs(os.path.join(rootdir, d), exist_ok=True)

@click.command()
@click.option('--rootdir', default="./", help='directory to hold the supporting files')
def prepare(rootdir="./"):
    colorama.init()
    
    click.echo(colorama.Fore.LIGHTCYAN_EX + "Downloading Orange icon..")
    download_orange_icon(destdir=rootdir)

    click.echo(colorama.Fore.LIGHTCYAN_EX + "Creating the support directories..")
    mkdir_support_dirs(rootdir)
    
    click.echo(colorama.Fore.LIGHTCYAN_EX + "Downloading NLTK DATA..")
    download_all_nltk_data(rootdir)

    click.echo(colorama.Fore.LIGHTCYAN_EX + "Downloading Orange packages and dependencies..")
    files = get_filelist(ORANGE_PACKAGES_TO_DOWNLOAD)
    for url in files:
        dest = generate_dest_path(url, parent_dir='./Packages')
        print(colorama.Fore.LIGHTCYAN_EX + "Downloading " + url + " to " + dest)
        download_file(url, dest)

    click.echo(colorama.Style.RESET_ALL)

if __name__ == '__main__':
    prepare()
