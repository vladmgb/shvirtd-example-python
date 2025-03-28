#!/bin/bash

#Рабочий каталог
TARGET_DIR="/opt/shvirtd-example-python"

#Обновляем или клонируем репозиторий
if [ -d "$TARGET_DIR" ]; then
  echo "Обновляем репозиторий..."
  cd "$TARGET_DIR" || exit
  git pull origin main
else
  echo "Клонируем репозиторий..."
  git clone https://github.com/vladmgb/shvirtd-example-python.git "$TARGET_DIR"
  cd "$TARGET_DIR" || exit
fi

#Запускаем проект
echo "Запускаем проект..."
cd "$TARGET_DIR" && /usr/libexec/docker/cli-plugins/docker-compose up --detach

#Проверяем статус
echo "Статус сервисов:"
/usr/libexec/docker/cli-plugins/docker-compose ps

#Получаем IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Готово! Приложение доступно по адресу:"
echo "http://$PUBLIC_IP:8090"
