
# Script de Backup do Sistema para Recuperação

## Descrição
Este script, criado por **Alisson Ramos**, tem como objetivo criar um backup do sistema operacional Windows, garantindo a recuperação em caso de falhas. Ele utiliza o utilitário nativo `wbadmin` para realizar backups completos e gerenciar processos relacionados ao serviço de backup.

## Funcionalidades
1. **Verificação do Processo de Backup Ativo**: Garante que nenhum processo `wbengine` ou `wbadmin` esteja ativo antes de iniciar o backup.
2. **Exclusão de Backups Anteriores**: Remove backups antigos para liberar espaço no destino e garantir que apenas o backup mais recente esteja disponível.
3. **Execução do Backup**: Inicia o processo de backup utilizando `wbadmin`, incluindo os dados críticos do sistema.
4. **Verificação de Integridade**: Confirma se o backup foi concluído com sucesso, garantindo que os dados foram salvos corretamente.

---

## Pré-requisitos
- **Sistema Operacional**: Windows com suporte ao utilitário `wbadmin`.
- **Permissões**: O script deve ser executado com privilégios administrativos.
- **Espaço de Armazenamento**: Certifique-se de que o destino do backup (`C:\WindowsImageBackup`) possui espaço suficiente para armazenar o backup do sistema.

---

## Uso do Script

1. **Configuração**:
   - O script utiliza por padrão o disco `C:` como destino do backup. Se desejar alterar o destino, edite a variável `$backupTarget` no início do script.

2. **Execução**:
   - Salve o script com a extensão `.ps1` (`BackupSistema.ps1`).
   - Execute o script no `GerarBackupSistema.bat` como Administrador.

3. **Fluxo do Script**:
   - Verifica se há processos de backup em execução e os encerra se necessário.
   - Verifica se existe um backup anterior e, caso encontrado, o remove.
   - Inicia o backup do sistema.
   - Verifica a integridade do backup.

---

## Mensagens do Script
- **Processo de Backup Ativo**:
  - Caso o processo `wbengine` esteja em execução, ele será encerrado para evitar conflitos.
- **Backup Anterior**:
  - Caso exista um backup antigo, será excluído antes de iniciar o novo.
- **Sucesso**:
  - O script indicará se o backup foi concluído com sucesso.
- **Falhas**:
  - Erros durante a execução ou integridade do backup serão reportados.

---

## Possíveis Problemas
1. **Erros de Permissão**:
   - Certifique-se de executar o script com permissões administrativas.
2. **Espaço Insuficiente**:
   - O backup pode falhar caso não haja espaço suficiente no destino configurado.
3. **Dependências do `wbadmin`**:
   - Verifique se o utilitário `wbadmin` está instalado e configurado no sistema.

---

## Notas Adicionais
- Este script foi desenvolvido com foco na simplicidade e automação. Caso precise de personalizações, como alterar o volume incluído no backup ou ajustar o destino, edite as variáveis no início do script.
- Certifique-se de testar o script em um ambiente controlado antes de utilizá-lo em produção.

--- 

## Contato
**Autor**: Alisson Ramos  
**Email**: Alisson.r.santos92@gmail.com
**Data de Criação**: 13/11/2024
