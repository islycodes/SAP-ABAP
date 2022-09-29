*&---------------------------------------------------------------------*
*& Report  ZZZ_FATEC14EX04
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZZZ_FATEC14EX05.

TABLES: MARA.

"Types - o que será impresso:
TYPES: BEGIN OF TYP_MARA,
        MATNR TYPE MARA-MATNR, "Material
        ERSDA TYPE MARA-ERSDA, "Data de criação
        MTART TYPE MARA-MTART, "Tipo do material
        MEINS TYPE MARA-MEINS, "Unidade de medida
        NTGEW TYPE MARA-NTGEW, "Peso líquido
       END OF TYP_MARA.

"Tabela interna
DATA LT_MARA TYPE TABLE OF TYP_MARA.

"Estrutura
DATA LS_MARA TYPE TYP_MARA.

"Tela de filtros
SELECT-OPTIONS: S_MATNR FOR MARA-MATNR, "Material
                S_ERSDA FOR MARA-ERSDA, "Data de criação
                S_MTART FOR MARA-MTART, "Tipo do material
                S_MATKL FOR MARA-MATKL. "Grupo de mercadorias


"Seleção de tabelas para tela de impressão
SELECT MATNR "código material
       ERSDA "data criação
       MTART "tipo material
       MEINS "unidade de medida
       NTGEW "peso líquido
    FROM MARA
    INTO TABLE LT_MARA
WHERE: MATNR IN S_MATNR, "WHERE é onde aplicamos os filtros, tem que ser os mesmos em select options.
        ERSDA IN S_ERSDA,
        MTART IN S_MTART,
        MATKL IN S_MATKL.

"repetição para exibir as linhas
LOOP AT LT_MARA INTO LS_MARA.
   WRITE: SY-TABIX, LS_MARA-MATNR, '-', LS_MARA-ERSDA, '-', LS_MARA-MTART, '-', LS_MARA-MEINS, '-', LS_MARA-NTGEW.
   ULINE. "uline cria uma nova linha.
ENDLOOP.
