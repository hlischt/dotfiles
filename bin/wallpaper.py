import argparse
import json
import pathlib
import random
import subprocess

EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif',
              '.webp', '.jxl', '.tiff', '.bmp']

def get_wallpaper_paths(directory: pathlib.Path) -> list:
    if not directory.is_dir():
        raise NotADirectoryError(f'{directory} is not a valid directory')
    paths = []
    for file in directory.iterdir():
        if file.suffix.casefold() in EXTENSIONS:
            paths.append(str(file))
    return paths


def read_state(state_path) -> list:
    '''Read the file where the state is stored and parse it.'''
    with open(state_path, 'r', encoding='utf-8-sig') as file:
        state = json.load(file)
    return state


def write_state(state_path, queue: list) -> None:
    'Write the queue of wallpapers to the state file as a JSON list of paths.'
    with open(state_path, 'w', encoding='utf-8') as file:
        file.write(json.dumps(queue))


def set_wallpaper(wallpaper: str) -> None:
    # print(wallpaper)
    arguments = ['feh', '--no-fehbg', '--bg-fill', '--', wallpaper]
    subprocess.run(arguments, check=True)


def parse_args():
    parser = argparse.ArgumentParser(
        description='Shuffles a list of wallpapers and sets one at a time.'
    )
    parser.add_argument(
        '--directory', '-d',
        type=pathlib.Path,
        help='Directory where the wallpaper images are stored'
    )
    parser.add_argument(
        'state_file',
        type=pathlib.Path,
        help='JSON file with the queue of wallpapers yet to use'
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    queue = None
    if args.state_file.exists():
        queue = read_state(args.state_file)
    if queue is None or len(queue) == 0:
        queue = get_wallpaper_paths(args.directory)
        if len(queue) == 0:
            raise FileNotFoundError('No wallpapers in the given directory')
        random.shuffle(queue)
    new_wall = queue.pop()
    set_wallpaper(new_wall)
    write_state(args.state_file, queue)


if __name__ == '__main__':
    main()
