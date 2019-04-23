INTERFACE zif_markdown_generator
  PUBLIC .

  METHODS:
    heading IMPORTING i_text  TYPE string
                      i_level TYPE string,

    heading1 IMPORTING i_text TYPE string,

    sub_heading IMPORTING i_text TYPE string,

    bold IMPORTING i_text TYPE string,

    italic IMPORTING i_text TYPE string,

    bold_nd_italic IMPORTING i_text TYPE string,

    strike_through IMPORTING i_text TYPE string,

    link IMPORTING i_text TYPE string
                   i_url  TYPE string.

ENDINTERFACE.
