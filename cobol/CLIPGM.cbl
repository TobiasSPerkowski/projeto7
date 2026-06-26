
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIPGM.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       COPY CLIMAPA.
       COPY DFHAID.

       01  WS-RESP    PIC S9(8) COMP.

       01  WS-CLIENTE.
           05 WS-CODCLI  PIC 9(6).
           05 WS-NOME     PIC X(30).
           05 WS-TELEFONE PIC X(15).
           05 WS-CIDADE   PIC X(20).
      
       PROCEDURE DIVISION.

       MAIN-PROCESS.
      * Recebe os dados digitados pelo usuário
           EXEC CICS RECEIVE
               MAP('CLI01')
               MAPSET('CLIMAPA')
           END-EXEC
      * Identifica a tecla de função pressionada
           EVALUATE EIBAID
               WHEN DFHPF5    
                   PERFORM CONSULTAR-CLIENTE
               WHEN DFHPF6
                   PERFORM SALVAR-CLIENTE
               WHEN DFHPF3
                   EXEC CICS RETURN
                   END-EXEC
               WHEN OTHER
                   MOVE 'TECLA INVALIDA' TO MSGO
           END-EVALUATE
      * Atualiza a tela
           EXEC CICS SEND
               MAP('CLI01')
               MAPSET('CLIMAPA')
               ERASE
           END-EXEC
           EXEC CICS RETURN
           END-EXEC.

       CONSULTAR-CLIENTE.
           MOVE CODCLII TO WS-CODCLI
           EXEC CICS READ
               FILE('CLIENTES')
               INTO(WS-CLIENTE)
               RIDFLD(WS-CODCLI)
               RESP(WS-RESP)
           END-EXEC
           IF WS-RESP = DFHRESP(NORMAL)
               MOVE WS-CODCLI TO CODCLIO
               MOVE WS-NOME TO NOMEO
               MOVE WS-TELEFONE TO TELEFONO
               MOVE WS-CIDADE TO CIDADEO
               MOVE 'CLIENTE ENCONTRADO' TO MSGO
           ELSE
               MOVE SPACES TO NOMEO
               MOVE SPACES TO TELEFONO
               MOVE SPACES TO CIDADEO
               MOVE 'CLIENTE NAO ENCONTRADO' TO MSGO
           END-IF.

       SALVAR-CLIENTE.
           MOVE CODCLII TO WS-CODCLI
           EXEC CICS READ
               FILE('CLIENTES')
               INTO(WS-CLIENTE)
               RIDFLD(WS-CODCLI)
               UPDATE
               RESP(WS-RESP)
           END-EXEC
           IF WS-RESP = DFHRESP(NORMAL)
               MOVE TELEFONI TO WS-TELEFONE
               MOVE CIDADEI  TO WS-CIDADE
               EXEC CICS REWRITE
                   FILE('CLIENTES')
                   FROM(WS-CLIENTE)
                   RESP(WS-RESP)
               END-EXEC
               MOVE WS-CODCLI TO CODCLIO
               MOVE WS-NOME TO NOMEO
               MOVE WS-TELEFONE TO TELEFONO
               MOVE WS-CIDADE TO CIDADEO
               MOVE 'ALTERACAO REALIZADA' TO MSGO
           ELSE
               MOVE 'CLIENTE NAO ENCONTRADO' TO MSGO
           END-IF.
