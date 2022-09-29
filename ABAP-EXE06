*&---------------------------------------------------------------------*
*& Report  ZZZ_FATEC20EXE10
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZZZ_FATEC20EXE10.

TABLES: EKKO.

"Types - o que será impresso:
TYPES: BEGIN OF TYP_EKKO,
        EBELN TYPE EKKO-EBELN, "N° do documento de compras
        BSTYP TYPE EKKO-BSTYP, "Categoria do documento de compras
        BSART TYPE EKKO-BSART, "Tipo de documento de compras
        AEDAT TYPE EKKO-AEDAT, "Data de criação do registro
        LIFNR TYPE EKKO-LIFNR, "N° conta do fornecedor
        SPRAS TYPE EKKO-SPRAS, "Código de idioma
    END OF TYP_EKKO.

"Tabela interna
DATA LT_EKKO TYPE TABLE OF TYP_EKKO.

DATA: R_TABLE TYPE REF TO CL_SALV_TABLE, "Objeto para impressão
      R_FUNCTIONS TYPE REF TO CL_SALV_FUNCTIONS. "

**********************************************************************
*Tela de filtros
**********************************************************************
SELECT-OPTIONS: S_EBELN FOR EKKO-EBELN, "N° do documento de compras
                S_BSTYP FOR EKKO-BSTYP, "Categoria do documento de compras
                S_BSART FOR EKKO-BSART, "Tipo de documento de compras
                S_AEDAT FOR EKKO-AEDAT. "Data de criação do registro



**********************************************************************
*Seleção de tabelas para tela de impressão
**********************************************************************
SELECT EBELN "N° do documento de compras
       BSTYP "Categoria do documento de compras
       BSART "Tipo de documento de compras
       AEDAT "Data de criação do registro
       LIFNR "N° conta do fornecedor
       SPRAS "Código de idioma
    FROM EKKO
    INTO TABLE LT_EKKO
WHERE: EBELN IN S_EBELN, "WHERE é onde aplicamos os filtros
       BSTYP IN S_BSTYP,
       BSART IN S_BSART,
       AEDAT IN S_AEDAT.

**********************************************************************
*Impressão
**********************************************************************
CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
    R_SALV_TABLE = R_TABLE
  CHANGING
    T_TABLE      = LT_EKKO.

"Adiciona funções de filtragem
R_FUNCTIONS = R_TABLE->GET_FUNCTIONS( ).
R_FUNCTIONS->SET_ALL( 'X' ).

CALL METHOD R_TABLE->DISPLAY.
