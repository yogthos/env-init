
## convert iTunes mp4 to mp3 and strip DRM:

   find . -type f -name "*.m4a" -exec bash -c 'ffmpeg -i "$1" "${1/m4a/mp3}" && rm "$1"' -- {} \;
