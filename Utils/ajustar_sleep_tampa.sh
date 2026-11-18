#!/bin/bash
# Ajuste de gerenciamento de energia para Samsung Book (Tiger Lake / WhateverXe)
# Desativa o repouso do sistema (S3) ao fechar a tampa, mantendo o desligamento de tela (Display Sleep).

echo "==> Aplicando configurações recomendadas de energia..."
sudo pmset -a disablesleep 1
sudo pmset -a sleep 0
sudo pmset -a lidwake 1
sudo pmset -b displaysleep 5
sudo pmset -c displaysleep 10

echo ""
echo "==> Configurações aplicadas com sucesso:"
pmset -g custom

