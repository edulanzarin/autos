#!/bin/bash

# ===========================
# Autos - Script de Instalação e Configuração
# ===========================
# Prepara o ambiente para uso do Autos:
# - Garante que está em um repositório git
# - Adiciona o diretório ao PATH do usuário
# - Ajusta permissões dos scripts
# - Configura verificação automática de atualizações
# ===========================

# Diretório onde o Autos está instalado
INSTALL_DIR=$(dirname "$(realpath "$0")")

# Detecta o arquivo de configuração do shell (bash ou zsh)
RC_FILE="$HOME/.bashrc"
[[ $SHELL == *zsh* ]] && RC_FILE="$HOME/.zshrc"

# 1. Verifica se está em um repositório git válido
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Erro: Execute este script APÓS clonar o repositório:"
    echo "git clone https://github.com/edulanzarin/autos.git"
    echo "cd autos"
    exit 1
fi

# 2. Adiciona o diretório do Autos ao PATH do usuário, se ainda não estiver
if ! grep -q "$INSTALL_DIR" "$RC_FILE"; then
    echo "Adicionando autos ao PATH..."
    echo -e "\n# Autos scripts\nexport PATH=\"\$PATH:$INSTALL_DIR\"" >> "$RC_FILE"
    echo "PATH configurado com sucesso!"
else
    echo "autos já está no PATH."
fi

# 3. Garante permissões de execução para todos os scripts relevantes
echo "Configurando permissões..."
find "$INSTALL_DIR" -type f \( -name "*.sh" -o -name "autos" \) -exec chmod +x {} \;

# 4. Configura verificação automática de atualizações diárias no shell do usuário
echo -e "\nConfigurando verificação automática de atualizações..."
if ! grep -q "AUTOS UPDATE CHECK" "$RC_FILE"; then
    cat << 'EOF' >> "$RC_FILE"

# AUTOS UPDATE CHECK - Verifica atualizações uma vez por dia
if [ -x "$(command -v autos)" ]; then
    if [ ! -f "$HOME/.autos_last_check" ] || [ $(date +%Y%m%d) -gt $(date -r "$HOME/.autos_last_check" +%Y%m%d) ]; then
        autos core/update --check-only &>/dev/null &
        touch "$HOME/.autos_last_check"
    fi
fi
EOF
    echo "Verificação automática configurada!"
else
    echo "ℹVerificação automática já está configurada."
fi

echo -e "\nConfiguração concluída! Para finalizar, execute:"
echo "source $RC_FILE"