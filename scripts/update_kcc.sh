#!/bin/bash

echo "updating kindle comic converter..."

DEST_DIR="$HOME/.local/bin/"
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/ciromattia/kcc/releases/latest \
	| jq -r '.assets[] | select(.name == "kindleComicConverter-latest-x86_64.AppImage") | .browser_download_url')

if [ -z "$DOWNLOAD_URL" ]; then
	echo "error: could not retrieve the download url"
	exit 1
fi

# create directory if it doesn't exist
mkdir -p "$DEST_DIR"
# remove the old binary
rm -f "$DEST_DIR/kcc"
# download the new binary
if ! curl -L -o "$DEST_DIR/kcc" "$DOWNLOAD_URL"; then
    echo "Error: Failed to download the file."
    exit 1
fi

chmod +x "$DEST_DIR/kcc"

echo "successfully updated kindle comic converter binary"
