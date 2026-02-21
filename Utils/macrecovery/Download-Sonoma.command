#!/usr/bin/env bash

# Vai para a pasta onde o .command está localizado
cd "$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"

# Agora executa o macrecovery
python3 macrecovery.py \
    -b Mac-827FAC58A8FDFA22 \
    -m 00000000000000000 \
    download

echo
echo "Arquivos salvos em:"
pwd
read -p "Pressione ENTER para sair..."
