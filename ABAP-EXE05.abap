*&---------------------------------------------------------------------*
*& Report  ZZZ_FATEC20EXE10
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZZZ_FATEC20EXE10.

TABLES: EKKO.

"Types - o que ser� impresso:
TYPES: BEGIN OF TYP_EKKO,
        EBELN TYPE EKKO-EBELN, "N� do documento de compras
        BSTYP TYPE EKKO-BSTYP, "Categoria do documento de compras
        BSART TYPE EKKO-BSART, "Tipo de documento de compras
        AEDAT TYPE EKKO-AEDAT, "Data de cria��o do registro
        LIFNR TYPE EKKO-LIFNR, "N� conta do fornecedor
        SPRAS TYPE EKKO-SPRAS, "C�digo de idioma
    END OF TYP_EKKO.

"Tabela interna
DATA LT_EKKO TYPE TABLE OF TYP_EKKO.

"Estrutura
DATA LS_EKKO TYPE TYP_EKKO.


**********************************************************************
*Tela de filtros
**********************************************************************
SELECT-OPTIONS: S_EBELN FOR EKKO-EBELN, "N� do documento de compras
                S_BSTYP FOR EKKO-BSTYP, "Categoria do documento de compras
                S_BSART FOR EKKO-BSART, "Tipo de documento de compras
                S_AEDAT FOR EKKO-AEDAT. "Data de cria��o do registro



**********************************************************************
*Sele��o de tabelas para tela de impress�o
**********************************************************************
SELECT EBELN "N� do documento de compras
       BSTYP "Categoria do documento de compras
       BSART "Tipo de documento de compras
       AEDAT "Data de cria��o do registro
       LIFNR "N� conta do fornecedor
       SPRAS "C�digo de idioma
    FROM EKKO
    INTO TABLE LT_EKKO
WHERE: EBELN IN S_EBELN, "WHERE � onde aplicamos os filtros
       BSTYP IN S_BSTYP,
       BSART IN S_BSART,
       AEDAT IN S_AEDAT.


**********************************************************************
*repeti��o para exibir as linhas
**********************************************************************
LOOP AT LT_EKKO INTO LS_EKKO.
   WRITE: SY-TABIX, 'N� do doc:', LS_EKKO-EBELN, '|',
                    'Catg do doc:', LS_EKKO-BSTYP, '|',
                    'Tipo de doc:', LS_EKKO-BSART, '|',
                    'Data de cria��o:', LS_EKKO-AEDAT, '|',
                    'N� conta do fornecedor:', LS_EKKO-LIFNR, '|',
                    'C�digo de idioma:', LS_EKKO-SPRAS, '|'.
   ULINE. "uline cria uma nova linha.
ENDLOOP.
