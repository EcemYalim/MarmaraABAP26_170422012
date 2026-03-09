CLASS zcl_170422012_global_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422012_global_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    connection = NEW #( ).
    connection->set_attributes(
    EXPORTING
    i_carrier_id = 'IH'
    i_connection_id = '0400').

    APPEND connection TO connections.

    connection = NEW #( ).
    connection->set_attributes(
    i_carrier_id = 'AA'
    i_connection_id = '0017').

    APPEND connection TO connections.

    connection = NEW #( ).
    connection->carrier_id = 'SQ'.
    connection->connection_id = '0001'.

    APPEND connection TO connections.

    LOOP AT connections INTO connection.
      connection->get_attributes(
      IMPORTING
      e_carrier_id = carrier_id
      e_connection_id = connection_id ).

      out->write( |flight Connection { carrier_id } { connection_id } | ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
