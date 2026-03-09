CLASS lcl_connection DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i.
    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_status        TYPE i
        i_flight_date   TYPE d
      RAISING
        cx_abap_invalid_value.

    METHODS get_attributes
      EXPORTING
        e_carrier_id    TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id
        e_status        TYPE i
        e_flight_date   TYPE d.

  PRIVATE SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA status        TYPE i.
    DATA flight_date   TYPE d.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
  METHOD class_constructor.
  ENDMETHOD.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.
    me->status        = i_status.
    me->flight_date   = i_flight_date.
    conn_counter = conn_counter + 1.
  ENDMETHOD.

  METHOD get_attributes.
    e_carrier_id    = me->carrier_id.
    e_connection_id = me->connection_id.
    e_status        = me->status.
    e_flight_date   = me->flight_date.
  ENDMETHOD.
ENDCLASS.
