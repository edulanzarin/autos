# Autos - Scripts Automatizados

![GitHub](https://img.shields.io/badge/license-MIT-blue)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?logo=gnu-bash&logoColor=white)

O **Autos** é um gerenciador inteligente de scripts que transforma seus comandos frequentes em ferramentas acessíveis de qualquer lugar no terminal. Organize, execute e mantenha seus scripts shell de forma centralizada, segura e produtiva.

## Funcionalidades Principais

- **Execução unificada** de scripts organizados por categorias e subpastas
- **Atualização automática** com sistema de backup integrado e logs detalhados
- **Auto-completar** comandos (bash/zsh) _(em breve)_
- **Verificação diária** por novas versões, sem interromper seu fluxo
- **Gerenciamento simplificado** de permissões para todos os scripts
- **Listagem automática** de comandos disponíveis
- **Ajuda contextual** e documentação embutida
- **Compatível com Bash e Zsh**

## Instalação Rápida

1. Clone o repositório:

   ```bash
   git clone https://github.com/edulanzarin/autos.git
   cd autos
   ```

2. Execute o setup:

   ```bash
   ./setup.sh
   ```

3. Recarregue seu terminal:
   ```bash
   source ~/.bashrc  # ou source ~/.zshrc se usar Zsh
   ```

## Como Usar

- **Listar comandos disponíveis:**
  ```bash
  autos --list
  ```
- **Executar um comando:**

  ```bash
  autos <comando> [argumentos...]
  ```

  Exemplo:

  ```bash
  autos gpush "Mensagem do commit"
  ```

- **Ver ajuda:**
  ```bash
  autos --help
  ```

## Atualização

O Autos verifica automaticamente por atualizações diárias. Para atualizar manualmente:

```bash
autos system/update
```

Se houver conflitos, siga as instruções exibidas para backup e resolução.

Você pode adicionar seus próprios scripts em subpastas, basta garantir que sejam executáveis.

## Exemplo de Script Customizado

Crie um script executável em qualquer subpasta, por exemplo `utils/hello`:

```bash
#!/bin/bash
echo "Olá, mundo!"
```

Dê permissão de execução:

```bash
chmod +x utils/hello
```

Execute:

```bash
autos hello
```

## Segurança & Permissões

- O setup garante permissões corretas para todos os scripts.
- Backups automáticos são feitos antes de atualizar.

## Integração & Extensibilidade

- Adicione scripts em qualquer subdiretório.
- O Autos detecta e lista automaticamente todos os comandos disponíveis.

## Logs e Diagnóstico

- Logs de atualização ficam em `core/update.log`.
- Mensagens de erro e instruções são exibidas no terminal.

## Licença

MIT © [Edu Lanzarin](https://github.com/edulanzarin)
