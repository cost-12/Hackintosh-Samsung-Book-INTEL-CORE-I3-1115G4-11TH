#!/bin/bash
# Restaura as configurações padrão de sleep do macOS

echo "==> Restaurando configurações padrão de energia..."
sudo pmset -a disablesleep 0
sudo pmset -a sleep 1
sudo pmset -a lidwake 1
sudo pmset -b displaysleep 5
sudo pmset -c displaysleep 10

echo ""
echo "==> Configurações atuais:"
pmset -g custom

