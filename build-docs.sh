#!/bin/sh

echo "Setting up mkdocs environment in /run/shm/mkdocs-pimidi"
python3 -m venv /run/shm/mkdocs-pimidi
. /run/shm/mkdocs-pimidi/bin/activate

pip install -r requirements.txt
pip install -e ../pimidipy

mkdocs build

echo "Removing mkdocs environment in /run/shm/mkdocs-pimidi"
deactivate
rm -rf /run/shm/mkdocs-pimidi

echo "Done! Thank you!"
