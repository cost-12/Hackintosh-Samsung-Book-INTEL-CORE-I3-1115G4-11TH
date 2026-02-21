#!/usr/bin/env bash

# Vai para a pasta onde o .command est‡ localizado
cd "$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"

# Agora executa o macrecovery
python3 macrecovery.py \
    -b Mac-CFF7D910A743CAAF \
    -m 00000000000000000 \
    download

echo
echo "Arquivos salvos em:"
pwd
read -p "Pressione ENTER para sair..."
