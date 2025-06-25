#!/bin/bash

# Configurações básicas
INSTALL_DIR=$(dirname "$(realpath "$0")")
RC_FILE="$HOME/.bashrc"
[[ $SHELL == *zsh* ]] && RC_FILE="$HOME/.zshrc"

# 1. Verifica se está num repo git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Erro: Execute este script APÓS clonar o repositório:"
    echo "   git clone https://github.com/edulanzarin/autos.git"
    echo "   cd autos"
    exit 1
fi

# 2. Configura PATH
if ! grep -q "$INSTALL_DIR" "$RC_FILE"; then
    echo "🔧 Adicionando autos ao PATH..."
    echo -e "\n# Autos scripts\nexport PATH=\"\$PATH:$INSTALL_DIR\"" >> "$RC_FILE"
    echo "✅ PATH configurado com sucesso!"
else
    echo "ℹ️  autos já está no PATH."
fi

# 3. Aplica permissões
echo "🔑 Configurando permissões..."
find "$INSTALL_DIR" -type f \( -name "*.sh" -o -name "autos" \) -exec chmod +x {} \;

# 4. Configura verificação automática de atualizações
echo -e "\n🔍 Configurando verificação automática de atualizações..."
if ! grep -q "AUTOS UPDATE CHECK" "$RC_FILE"; then
    cat << 'EOF' >> "$RC_FILE"

# AUTOS UPDATE CHECK - Verifica atualizações uma vez por dia
if [ -x "$(command -v autos)" ]; then
    if [ ! -f "$HOME/.autos_last_check" ] || [ $(date +%Y%m%d) -gt $(date -r "$HOME/.autos_last_check" +%Y%m%d) ]; then
        autos system/update --check-only &>/dev/null &
        touch "$HOME/.autos_last_check"
    fi
fi
EOF
    echo "✅ Verificação automática configurada!"
else
    echo "ℹ️  Verificação automática já está configurada."
fi

echo -e "\n🎉 Configuração concluída! Execute:"
echo "   source $RC_FILE"