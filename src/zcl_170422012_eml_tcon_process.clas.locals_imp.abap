" use this source file for the definition and implementation of
" local helper classes, interface definitions and type
" declarations

CLASS lcl_connection_eml DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:
      insert_data,
      read_data,
      update_data,
      delete_data.

ENDCLASS.


CLASS lcl_connection_eml IMPLEMENTATION.

  METHOD insert_data.

    DATA: lt_create TYPE TABLE FOR CREATE zr_tcon_170422012.

    lt_create = VALUE #(
      ( %cid        = 'C1'
        Carrid      = 'LH'
        Connid      = '0400'
        AirportFrom = 'FRA'
        CityFrom    = 'Frankfurt'
        CountryFrom = 'DE'
        AirportTo   = 'JFK'
        CityTo      = 'New York'
        CountryTo   = 'US' )

      ( %cid        = 'C2'
        Carrid      = 'TK'
        Connid      = '1501'
        AirportFrom = 'IST'
        CityFrom    = 'Istanbul'
        CountryFrom = 'TR'
        AirportTo   = 'CDG'
        CityTo      = 'Paris'
        CountryTo   = 'FR' )

      ( %cid        = 'C3'
        Carrid      = 'BA'
        Connid      = '0287'
        AirportFrom = 'LHR'
        CityFrom    = 'London'
        CountryFrom = 'GB'
        AirportTo   = 'DXB'
        CityTo      = 'Dubai'
        CountryTo   = 'AE' )
    ).

    MODIFY ENTITIES OF zr_tcon_170422012
      ENTITY ZrTcon170422012
      CREATE FIELDS (
        Carrid
        Connid
        AirportFrom
        CityFrom
        CountryFrom
        AirportTo
        CityTo
        CountryTo
      )
      WITH lt_create
      FAILED DATA(ls_failed).

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.

  METHOD read_data.

    DATA read_keys TYPE TABLE FOR READ IMPORT zr_tcon_170422012.
    DATA connections TYPE TABLE FOR READ RESULT zr_tcon_170422012.

    read_keys = VALUE #(  (  uuid = '763C8701C43C1FE18B86488AF55B2DE0' ) ).

    READ ENTITIES OF zr_tcon_170422012
        ENTITY ZrTcon170422012
        ALL FIELDS
        WITH CORRESPONDING #(  read_keys )
        RESULT connections.

  ENDMETHOD.

  METHOD update_data.

    DATA lt_update TYPE TABLE FOR UPDATE zr_tcon_170422012.

    SELECT uuid
      FROM ztcon_170422012
      WHERE uuid = '763C8701C43C1FE18B86488AF55B2DE0'
      INTO TABLE @DATA(lt_keys)
      UP TO 1 ROWS.

    LOOP AT lt_keys INTO DATA(ls_key).

      lt_update = VALUE #(
        (
          uuid = ls_key-uuid
          CityTo = 'Paris'
          %control-CityTo = if_abap_behv=>mk-on
        )
      ).

    ENDLOOP.

    MODIFY ENTITIES OF zr_tcon_170422012
      ENTITY ZrTcon170422012
      UPDATE FROM lt_update
      FAILED   DATA(ls_failed).

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.



*--------------------------------------------------
* DELETE
*--------------------------------------------------
  METHOD delete_data.

    DATA lt_delete TYPE TABLE FOR DELETE zr_tcon_170422012.

    lt_delete = VALUE #( ( uuid = '763C8701C43C1FE18B86488AF55B4DE0' ) ).

    MODIFY ENTITIES OF zr_tcon_170422012
      ENTITY ZrTcon170422012
      DELETE FROM lt_delete
      FAILED   DATA(ls_failed).

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
