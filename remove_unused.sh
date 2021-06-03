#!/bin/bash

# Credits to https://www.stevemar.net/remove-unused-images/

imagepaths=$(fd -e jpg -e jpeg -e png -E .git -E src/assets -E src/img/EditorManual/icons)
counter=0

for imagepath in $imagepaths; do
    filename=$(basename -- "$imagepath")
    if ! rg -q -g "!/img/EditorManual/icons/**/*" "$filename" .; then
        git rm "$imagepath"
        counter=$((counter+1))
    fi
done

if [ "$counter" -eq "0" ]; then
    echo "No images were removed!"
else
    echo "Removed a total $counter images, w00t!"
fi
