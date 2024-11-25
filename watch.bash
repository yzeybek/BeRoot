#!/bin/bash

# İzlenecek dizin
WATCH_DIR="$HOME/.local/share/applications"

# Yeni .desktop dosyalarını kontrol et
find "$WATCH_DIR" -type f -name "*.desktop" -mmin -1 | while read -r desktop_file; do
    echo "Yeni .desktop dosyası bulundu: $desktop_file"
    ./converter.bash "$desktop_file"  # Dosyayı işleme
done

