#!/bin/bash

DESKTOP_DIR="$HOME/Desktop/scrcpy-sose"
APPLICATIONS_DIR="$HOME/.local/share/applications"

mkdir -p "$DESKTOP_DIR"
mkdir -p "$APPLICATIONS_DIR"

cat << EOF > "$APPLICATIONS_DIR/scrcpy-sose.desktop"
[Desktop Entry]
Name=scrcpy-sose
Exec=bash -c "'$DESKTOP_DIR/run.sh'"
Type=Application
Terminal=false
Categories=Utility;Game;
EOF

cat << 'INNER_EOF' > "$DESKTOP_DIR/run.sh"
#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR" || exit 1

LATEST_TAG=$(curl -s --connect-timeout 3 https://api.github.com/repos/Genymobile/scrcpy/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
    if [ -d "$PROJECT_DIR/scrcpy" ]; then
        cd "$PROJECT_DIR/scrcpy" && ./scrcpy
        exit 0
    else
        exit 1
    fi
fi

VERSION_FILE="$PROJECT_DIR/version.txt"
CURRENT_VERSION=""
[ -f "$VERSION_FILE" ] && CURRENT_VERSION=$(cat "$VERSION_FILE")

if [ "$CURRENT_VERSION" != "$LATEST_TAG" ] || [ ! -d "$PROJECT_DIR/scrcpy" ]; then
    TARBALL_URL="https://github.com/Genymobile/scrcpy/releases/download/${LATEST_TAG}/scrcpy-linux-x86_64-${LATEST_TAG}.tar.gz"

    rm -rf "$PROJECT_DIR/temp"
    mkdir -p "$PROJECT_DIR/temp"

    wget -q --show-progress "$TARBALL_URL" -O "$PROJECT_DIR/scrcpy.tar.gz"
    if [ $? -ne 0 ]; then
        if [ -d "$PROJECT_DIR/scrcpy" ]; then
            cd "$PROJECT_DIR/scrcpy" && ./scrcpy
            exit 0
        fi
        exit 1
    fi

    tar -xzf "$PROJECT_DIR/scrcpy.tar.gz" -C "$PROJECT_DIR/temp"
    rm -f "$PROJECT_DIR/scrcpy.tar.gz"

    EXTRACTED_DIR="$PROJECT_DIR/temp/scrcpy-linux-x86_64-${LATEST_TAG}"

    if [ ! -d "$EXTRACTED_DIR" ]; then
        EXTRACTED_DIR=$(ls -d "$PROJECT_DIR/temp"/scrcpy-linux-x86_64-* 2>/dev/null | head -n 1)
    fi

    if [ -d "$EXTRACTED_DIR" ]; then
        rm -rf "$PROJECT_DIR/scrcpy"
        mv "$EXTRACTED_DIR" "$PROJECT_DIR/scrcpy"
    fi

    rm -rf "$PROJECT_DIR/temp"
    echo "$LATEST_TAG" > "$VERSION_FILE"
fi

cd "$PROJECT_DIR/scrcpy"
./scrcpy
INNER_EOF

cat << 'INNER_EOF' > "$DESKTOP_DIR/uninstall.sh"
#!/bin/bash
rm -f "$HOME/.local/share/applications/scrcpy-sose.desktop"

PROJECT_FOLDER="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rm -rf "$PROJECT_FOLDER"

sleep 2
INNER_EOF

chmod +x "$DESKTOP_DIR/run.sh"
chmod +x "$DESKTOP_DIR/uninstall.sh"
