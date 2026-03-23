CLASS zcl_170422012work_with_intbl1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422012work_with_intbl1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES tt_connections TYPE SORTED TABLE OF st_connection
                              WITH NON-UNIQUE KEY carrier_id
                              connection_id.

    DATA connections TYPE tt_connections.
    DATA connection LIKE LINE OF connections.

    TYPES: BEGIN OF st_carrier,
             carrier_id    TYPE /dmo/carrier_id,
             currency_code TYPE /dmo/currency_code,
           END OF st_carrier.

    DATA carriers TYPE STANDARD TABLE OF st_carrier
                                WITH NON-UNIQUE KEY carrier_id.

    DATA carrier LIKE LINE OF carriers.

    connections = VALUE #(  ( carrier_id = 'JL'
                              connection_id = '0408'
                              airport_from_id = 'FRA'
                              airport_to_id = 'NRT'
                              carrier_name = 'Japan Airlines' )

                             ( carrier_id = 'AA'
                              connection_id = '0017'
                              airport_from_id = 'MIA'
                              airport_to_id = 'HAV'
                              carrier_name = 'Amerikan Airlines' )

                              ( carrier_id = 'SQ'
                              connection_id = '0001'
                              airport_from_id = 'SFO'
                              airport_to_id = 'SIN'
                              carrier_name = 'Singapore Airlines' ) ).

    carriers = VALUE #(  ( carrier_id = 'JL'
                           currency_code = '')

                         ( carrier_id = 'AA'
                           currency_code = '')

                         ( carrier_id = 'SQ'
                           currency_code = '')
                         ).

    connection = connections[ carrier_id = 'SQ'
                                connection_id = '0001' ].

    connection = connections[ airport_from_id = 'SFO'
                                airport_to_id = 'SIN' ].


    LOOP AT connections INTO connection
    WHERE airport_from_id <> 'MIA'.

      out->write( data = connection
                  name = |This isrow number { sy-tabix }: | ).
   ENDLOOP.

      carrier = carriers[ carrier_id = 'JL' ].
      carrier-currency_code = 'jPY'.
      MODIFY TABLE carriers FROM carrier.

      LOOP AT carriers INTO carrier
      WHERE currency_code IS INITIAL.

        carrier-currency_code ='USD'.
        MODIFY carriers FROM carrier.
      ENDLOOP.
    ENDMETHOD.
ENDCLASS.
