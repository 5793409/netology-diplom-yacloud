#!/bin/bash

# Получаем список всех переменных окружения, начинающихся с YC_
for var in $(printenv | grep '^YC_' | cut -d= -f1); do
  unset "$var"
done

for var in $(printenv | grep '^TF_VAR' | cut -d= -f1); do
  unset "$var"
done

echo "🧹 Все переменные YC_ / TF_VAR * успешно очищены."