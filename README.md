# Docker контейнер для сайта на IPFS

# IPFS Website Hosting Docker Container

[![Docker](https://img.shields.io/badge/Docker-✓-blue?logo=docker)]  
[![IPFS](https://img.shields.io/badge/IPFS-✓-blue?logo=ipfs)]

Контейнер для автоматического хостинга статических сайтов на IPFS

## Особенности

- [x] Автоматическая публикация в IPFS
- [x] Постоянные IPNS-ссылки
- [x] Простое добавление файлов через volume
- [x] Доступ через локальные и публичные гейтвеи
- [x] Логирование CID после деплоя

## Быстрый старт

### 1. Сборка образа
```bash
docker build -t ipfs-website .
```
### 2. Запуск контейнера
```bash
docker run -d \
  --name ipfs-website \
  -v /путь/к/сайту:/data/ipfs/website \
  -v ipfs-data:/data/ipfs \
  -p 4001:4001 \
  -p 5001:5001 \
  -p 8080:8080 \
  ipfs-website
```
### 3. Доступ к сайту
```bash
docker logs ipfs-website
```
Пример вывода:
```
==============================================
Website CID: QmXyZABC123...
Локальный гейтвей: http://localhost:8080/ipfs/QmXyZABC123...
Публичный гейтвей: https://ipfs.io/ipfs/QmXyZABC123...
==============================================
IPNS ссылка:
http://localhost:8080/ipns/k51qaz...
https://ipfs.io/ipns/k51qaz...
```
### 4. Как обновить контент
1. Добавьте файлы в /путь/к/сайту
2. Перезапустите контейнер:
```
docker restart ipfs-website
```
### 5. Получение CID
Из файла
```
docker exec ipfs-website cat /data/ipfs/last_cid.txt
```
Из логов
```
docker logs ipfs-website | grep "Website CID"
```
### 6. Настройка домена на примере CloudFlare
1. Создайте TXT-запись в DNS:
```
_dnslink.ваш-домен → dnslink=/ipfs/ВАШ_CID
```
2. Добавьте CNAME-запись
```
ваш-домен → ipfs.cloudflare.com 	☁ Proxied
```
   





