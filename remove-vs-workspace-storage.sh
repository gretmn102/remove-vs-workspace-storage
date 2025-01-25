#!/bin/bash

project_name=MissingBoar

cd ~/AppData/Roaming/VSCodium/User/workspaceStorage
folders=$(find . -name 'workspace.json' -exec grep -H $project_name {} + | awk -F'/' '{print $2}')
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
