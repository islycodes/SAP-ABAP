*&---------------------------------------------------------------------*
*& Report  ZADRIELLYISLY20_PVFINAL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZADRIELLYISLY20_PVFINAL.

TABLES: VBAK, VBAP, KNA1.

*Types - o que será impresso:
TYPES: BEGIN OF TYP_VBAK,
        VBELN TYPE VBAK-VBELN, "Documento de vendas
        ERDAT TYPE VBAK-ERDAT, "Data de criacao do registro
        KUNNR TYPE KNA1-KUNNR, "Cliente
        NAME1 TYPE KNA1-NAME1, "Nome do cliente
        STCD1 TYPE KNA1-STCD1, "CNPJ
        STCD2 TYPE KNA1-STCD2, "CPF
        MATNR TYPE VBAP-MATNR, "Nº do material
        NETWR TYPE VBAK-NETWR, "Valor líquido
        KWMENG TYPE VBAP-KWMENG, "Qtd. ordem
       END OF TYP_VBAK.

*Tabela interna
DATA LT_VBAK TYPE TABLE OF TYP_VBAK.

DATA: R_TABLE TYPE REF TO CL_SALV_TABLE, "Objeto para impressão
      R_FUNCTIONS TYPE REF TO CL_SALV_FUNCTIONS. "Adiciona opções de filtro



*Tela de filtros
SELECT-OPTIONS: S_VBELN FOR VBAK-VBELN, "Documento de vendas
                S_KUNNR FOR KNA1-KUNNR, "Cliente
                S_AUART FOR VBAK-AUART, "Tipo de documento de vendas
                S_ERDAT FOR VBAK-ERDAT. "Data de criacao do registro

*Seleção de tabelas para tela de impressão
SELECT VK~VBELN "Documento de vendas
       VK~ERDAT "Data de criacao do registro
       K1~KUNNR "Cliente
       K1~NAME1 "Nome do cliente
       K1~STCD1 "CNPJ
       K1~STCD2 "CPF
       VP~MATNR "Nº do material
       VK~NETWR "Valor líquido
       VP~KWMENG "Qtd. ordem
    FROM VBAK AS VK
    INNER JOIN VBAP AS VP
    ON VK~VBELN = VP~VBELN
    INNER JOIN KNA1 AS K1
    ON VK~KUNNR = K1~KUNNR
    INTO TABLE LT_VBAK
WHERE: VK~VBELN IN S_VBELN, "Documento de vendas
       K1~KUNNR IN S_KUNNR, "Cliente
       VK~AUART IN S_AUART, "Tipo de documento de vendas
       VK~ERDAT IN S_ERDAT. "Data de criacao do registro


**********************************************************************
*Impressão
**********************************************************************
CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
    R_SALV_TABLE = R_TABLE
  CHANGING
    T_TABLE      = LT_VBAK.

"Adiciona funções de filtragem
R_FUNCTIONS = R_TABLE->GET_FUNCTIONS( ).
R_FUNCTIONS->SET_ALL( 'X' ).

CALL METHOD R_TABLE->DISPLAY.
