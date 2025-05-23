#!/bin/sh

# Инициализируем IPFS репозиторий, если его нет
if [ ! -d /data/ipfs/version ]; then
    echo "Initializing IPFS repo..."
    ipfs init --profile=server
fi

# Запускаем IPFS демон в фоне
ipfs daemon &

# Ждём инициализации IPFS
sleep 15

# Если в /data/ipfs/website есть файлы - добавляем их в IPFS
if [ "$(ls -A /data/ipfs/website)" ]; then
    echo "Adding website files to IPFS..."
    CID=$(ipfs add -r /data/ipfs/website --quiet | tail -n 1)

    # Сохраняем CID в файл (для последующего использования)
    echo "$CID" > /data/ipfs/last_cid.txt

    # Выводим информацию о доступности
    echo "=============================================="
    echo "Website CID: $CID"
    echo "Local gateway: http://localhost:8080/ipfs/$CID"
    echo "Public gateway: https://ipfs.io/ipfs/$CID"
    echo "=============================================="

    # Публикуем через IPNS (опционально)
    echo "Publishing to IPNS..."
    IPNS_ID=$(ipfs key list -l | grep self | cut -d' ' -f1)
    ipfs name publish --key=self /ipfs/$CID
    echo "IPNS link (persistent):"
    echo "http://localhost:8080/ipns/$IPNS_ID"
    echo "https://ipfs.io/ipns/$IPNS_ID"
else
    echo "No files found in /data/ipfs/website"
    echo "Add your website files to this directory and restart the container"
fi

# Бесконечный цикл чтобы контейнер не завершался
while true; do sleep 1000; done
