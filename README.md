# Projeto 7 - Sistema de Consulta e Atualização de Clientes

Aplicação online em CICS para consulta e atualização de clientes armazenados em um arquivo VSAM.

## Funcionalidades

- Consulta de cliente por código (PF5)
- Atualização de telefone e cidade (PF6)
- Encerramento da transação (PF3)

## Estrutura

- bms/CLIMAPA.bms: definição da tela BMS
- copybooks/CLIMAPA.cpy: copybook simulado gerado pelo BMS
- cobol/CLIPGM.cbl: programa COBOL CICS
- fluxogramas/: fluxos das operações PF5 e PF6

## Observação

Como não foi disponibilizado ambiente CICS para execução, o projeto foi desenvolvido de forma teórica, simulando a estrutura de uma aplicação online CICS utilizando BMS, VSAM e comandos EXEC CICS.