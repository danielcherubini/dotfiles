#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FONT_DIR="/usr/share/fonts/operator-mono"

echo "Installing Operator Mono fonts..."

# Create font directory
sudo mkdir -p "$FONT_DIR"

# Install all OTF files
sudo install -m 644 "$SCRIPT_DIR"/*.otf "$FONT_DIR/"

# Refresh font cache
sudo fc-cache -f "$FONT_DIR"

echo "Operator Mono fonts installed to $FONT_DIR"
