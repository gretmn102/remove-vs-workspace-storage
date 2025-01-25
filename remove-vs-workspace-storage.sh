#!/bin/bash

usage() {
  echo "Usage: $0 <pattern>"
  echo
  echo "Where:"
  echo "  <pattern>  Is the pattern of the project in grep that needs to be removed."
  echo
  echo "Options:"
  echo "  -h, --help  Show this help."
  echo "  --find      Just find the project without remove."
  exit 1
}

case "$1" in
  "")
    usage
    ;;
  -h|--help)
    usage
    ;;
  --find)
    if [[ $# -eq 2 ]]; then
      project_pattern=$2
      cd ~/AppData/Roaming/VSCodium/User/workspaceStorage
      find . -name 'workspace.json' -exec grep -H $project_pattern {} +
    else
      echo "Error: Missing pattern after --find"
      usage
    fi
    ;;
  *)
    project_pattern=$1
    cd ~/AppData/Roaming/VSCodium/User/workspaceStorage
    folders=$(find . -name 'workspace.json' -exec grep -H $project_pattern {} + | awk -F'/' '{print $2}')
    for folder in $folders; do
      if [ -d "$folder" ]; then
        full_folder=$(pwd)/$folder
        read -p "Are you sure you want to delete the folder '$full_folder'? (y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
          echo "Deleting the folder '$full_folder'"
          rm -rf "$full_folder"
        else
          echo "Skip deleting the folder '$full_folder'"
        fi
      else
        echo "Folder '$full_folder' not found!"
      fi
    done;
    ;;
esac
