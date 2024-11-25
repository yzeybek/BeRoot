#!/bin/bash

# İzlemek istediğiniz dizin
WATCH_DIR="$HOME/.local/share/applications"

# İzleme komutu (create, move, modify, moved_to gibi olayları dinler)
inotifywait -m -e moved_to --format '%e %f' "$WATCH_DIR" | while read EVENT FILE
do
    # Yalnızca .desktop dosyaları için işlem yapalım
    if [[ "$FILE" == *.desktop ]]; then
        DESKTOP_FILE="$WATCH_DIR/$FILE"
        
        # Dosya üzerinde işlem yapılıp yapılmadığını kontrol et
        FLAG_FILE="$WATCH_DIR/$FILE.processing"

        # Eğer dosya üzerinde işlem yapılmışsa, bayrak dosyasını kontrol et
        if [ -e "$FLAG_FILE" ]; then
            echo "Dosya zaten işlenmiş: $FILE, atlanıyor."
        else
            # Bayrak dosyasını oluştur (işlem yapıldığını belirtmek için)
            touch "$FLAG_FILE"
            
            # converter.bash scriptini çalıştır
            echo "Dosya işleniyor: $FILE"
            ./converter.bash "$DESKTOP_FILE"
            
            # Bayrak dosyasını kaldır (işlem tamamlandı)
            rm "$FLAG_FILE"
        fi
    fi
done

