FROM ipfs/kubo:latest

# Создаем рабочую директорию для сайта
RUN mkdir -p /data/ipfs/website
VOLUME /data/ipfs/website

# Копируем скрипт для автоматического добавления файлов при запуске
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Экспортируем порты IPFS
EXPOSE 4001 5001 8080

ENTRYPOINT ["/entrypoint.sh"]
