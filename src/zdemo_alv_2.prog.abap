*&---------------------------------------------------------------------*
*& Report zdemo_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemo_alv_2.

**SELECTION SCREEN
"PARAMETERS VARIANT LIKE DISVARIANT-VARIANT.
tables: SPFLI.
start-of-selection.
DATA: lt_spfli TYPE STANDARD TABLE OF SPFLI.
DATA: lo_sql TYPE REF TO cl_sql_statement.
DATA: lr_data TYPE REF TO data.

DATA(lv_sql) = |SELECT * | && |FROM SPFLI |. "SQL Script

TRY.
"1.- Crear objeto
CREATE OBJECT lo_sql.

"2.- Ejecutar query

DATA(lo_result) = lo_sql->execute_query( lv_sql ).

"3.- Referenciar datos a una estructura
GET REFERENCE OF lt_spfli INTO lr_data.

"4.- Cargar los datos en la tabla interna
lo_result->set_param_table( lr_data ).

"5.- Recuperar todos los registros
lo_result->next_package( ).

"6.- Cerrar query
lo_result->close( ).

"Capturar excepción
CATCH cx_root INTO DATA(cx_root).
ENDTRY.

"Mostrar resultado
cl_demo_output=>display( lt_spfli ).
