CLASS zcl_170422012_global_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422012_global_03 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA status        TYPE i.
    DATA flight_date   TYPE d.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    TRY.
        connection = NEW #( i_carrier_id = 'IH'
                            i_connection_id = '0400'
                            i_status = '0089'
                            i_flight_date = cl_abap_context_info=>get_system_date( ) ).


        APPEND connection TO connections.
      CATCH cx_ABAP_INVALID_VALUE.
        out->write( `method call failed` ).
    ENDTRY.

    TRY.
        connection = NEW #( i_carrier_id = 'AA'
                            i_connection_id = '0017'
                            i_status = '0189'
                            i_flight_date = cl_abap_context_info=>get_system_date( ) ).


        APPEND connection TO connections.
      CATCH cx_ABAP_INVALID_VALUE.
        out->write( `method call failed` ).
    ENDTRY.


    LOOP AT connections INTO connection.
      connection->get_attributes(
      IMPORTING
      e_carrier_id = carrier_id
      e_connection_id = connection_id
      e_status        = status
      e_flight_date   = flight_date ).

      out->write( |flight Connection { carrier_id } { connection_id } { status } { flight_date } | ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
