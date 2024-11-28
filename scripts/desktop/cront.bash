#!/bin/bash

# İzlenecek dizin
WATCH_DIR="$HOME/.local/share/applications"

# Son kontrol zamanını tutacak dosya
last_check_file="/tmp/last_check"

# Son kontrol zamanını al
if [ -f "$last_check_file" ]; then
    last_check=$(cat "$last_check_file")
else
    # İlk çalıştırma, başlangıç zamanı
    last_check=0
fi

# 5 saniyelik polling yapmak için döngü
for i in {1..12}; do  # Her 5 saniyede bir kontrol etmek için toplamda 1 dakika (12 * 5 = 60 saniye)
    # Yeni dosyaları kontrol et
    find "$WATCH_DIR" -type f -name "*.desktop" -newermt @$last_check | while read -r desktop_file; do
        echo "Yeni .desktop dosyası bulundu: $desktop_file"
        ./converter.bash "$desktop_file"  # Dosyayı işleme
    done

    # 5 saniye bekle
    sleep 5
done

# Son kontrol zamanını güncelle
echo "$(date +%s)" > "$last_check_file"

