"!
"! ABAP Markdown
"! (c) Guilherme Maeda
"! http://abap.ninja
"!
"! For the full license information, view the LICENSE file that was distributed
"! with this source code.
"!

"!
"! Unit test class for the string template class
*!
class abap_unit_string_tests definition for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short
  private section.
    data: o_string type ref to lcl_string.
    methods:
      copying for testing.
endclass.                    "abap_unit_string_tests DEFINITION
*!
class abap_unit_string_tests implementation.
  method copying.
    create object o_string.
    o_string->data = 'SpongeBob'.

    data: lo_new type ref to lcl_string.
    create object lo_new.
    lo_new->copy( o_string ).
    cl_aunit_assert=>assert_equals(
      exp = 'SpongeBob'
      act = lo_new->data
    ).
  endmethod.                    "copying
endclass.                    "abap_unit_string_tests IMPLEMENTATION


"!
"! Unit test class for the string array template class
*!
class abap_unit_string_array_tests definition for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short
  private section.
    data: o_sa type ref to lcl_string_array.
    methods:
      copying for testing,
      append for testing,
      append_array for testing,
      delete for testing,
      find for testing.
endclass.                    "abap_unit_string_array_tests DEFINITION
*!
class abap_unit_string_array_tests implementation.
  method copying.
    create object o_sa.
    o_sa->append( 'One' ).
    o_sa->append( 'Two' ).
    o_sa->append( 'Three' ).

    data: lo_new type ref to lcl_string_array,
          lv_conc type string.
    create object lo_new.
    lo_new->copy( o_sa ).

    concatenate lines of lo_new->data into lv_conc.
    cl_aunit_assert=>assert_equals(
      exp = 'OneTwoThree'
      act = lv_conc
    ).
  endmethod.                    "copying

  method append.
    create object o_sa.
    o_sa->append( 'One' ).
    o_sa->append( 'Two' ).
    o_sa->append( 'Three' ).

    data: lv_conc type string.
    concatenate lines of o_sa->data into lv_conc.
    cl_aunit_assert=>assert_equals(
      exp = 'OneTwoThree'
      act = lv_conc
    ).
  endmethod.                    "append

  method append_array.
    create object o_sa.
    o_sa->append( 'One' ).
    o_sa->append( 'Two' ).
    o_sa->append( 'Three' ).

    data: lo_new type ref to lcl_string_array,
          lv_conc type string.
    create object lo_new.
    lo_new->append_array( o_sa ).

    concatenate lines of lo_new->data into lv_conc.
    cl_aunit_assert=>assert_equals(
      exp = 'OneTwoThree'
      act = lv_conc
    ).
  endmethod.                    "append_array

  method delete.
    create object o_sa.
    o_sa->append( 'One' ).
    o_sa->append( 'Two' ).
    o_sa->append( 'Three' ).

    o_sa->delete( 'Two' ).

    data: lv_conc type string.
    concatenate lines of o_sa->data into lv_conc.
    cl_aunit_assert=>assert_equals(
      exp = 'OneThree'
      act = lv_conc
    ).
  endmethod.                    "delete

  method find.
    create object o_sa.
    o_sa->append( 'One' ).
    o_sa->append( 'Two' ).
    o_sa->append( 'Three' ).

    data: lv_index type i.
    lv_index = o_sa->find( 'Two' ).
    cl_aunit_assert=>assert_equals(
      exp = 2
      act = lv_index
    ).
  endmethod.                    "find
endclass.                    "abap_unit_string_array_tests IMPLEMENTATION


"!
"! Unit test class for the hashmap template class
*!
class abap_unit_hashmap_tests definition for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short
  private section.
    data: o_hm type ref to lcl_hashmap.
    methods:
      copying for testing,
      create_string_hashmap for testing,
      create_array_hashmap for testing,
      create_hashmap_hashmap for testing,
      create_4_dimension_hashmap for testing,
      new for testing,
      get for testing,
      set for testing,
      exists for testing,
      delete for testing.
endclass.                    "abap_unit_hashmap_tests DEFINITION
*!
class abap_unit_hashmap_tests implementation.
  method copying.
    create object o_hm
      exporting
        value_type = 'lcl_string'.
    data: lo_value type ref to lcl_string.
    lo_value ?= o_hm->new( 'IdxOne' ).
    lo_value->data = 'ValueOne'.

    data: lo_new type ref to lcl_hashmap.
    create object lo_new
      exporting
        value_type = 'lcl_string'.
    lo_new->copy( o_hm ).
    lo_value ?= lo_new->get( 'IdxOne' ).
    cl_aunit_assert=>assert_equals(
      exp = 'ValueOne'
      act = lo_value->data
    ).
  endmethod.                    "copying

  method create_string_hashmap.
    data: lo_string type ref to lcl_string.
    create object o_hm. "// default
    lo_string ?= o_hm->new( 'IdxOne' ).

    create object o_hm
      exporting
        value_type = 'lcl_string'.
    lo_string ?= o_hm->new( 'IdxOne' ).
  endmethod.                    "create_string_hashmap

  method create_array_hashmap.
    data: lo_array type ref to lcl_string_array.
    create object o_hm
      exporting
        value_type = 'lcl_string_array'.
    lo_array ?= o_hm->new( 'IdxOne' ).
  endmethod.                    "create_array_hashmap

  method create_hashmap_hashmap.
    data: lo_hashmap type ref to lcl_hashmap.
    create object o_hm
      exporting
        value_type = 'lcl_hashmap'.
    lo_hashmap ?= o_hm->new( 'IdxOne' ).
  endmethod.                    "create_hashmap_hashmap

  method create_4_dimension_hashmap.
    data: lo_hashmap1 type ref to lcl_hashmap,
          lo_hashmap2 type ref to lcl_hashmap,
          lo_hashmap3 type ref to lcl_hashmap.
    create object o_hm
      exporting
        value_type = 'lcl_hashmap:lcl_hashmap:lcl_hashmap'.
    lo_hashmap1 ?= o_hm->new( 'IdxOne' ).
    lo_hashmap2 ?= lo_hashmap1->new( 'IdxTwo' ).
    lo_hashmap3 ?= lo_hashmap2->new( 'IdxThree' ).
  endmethod.                    "create_4_dimension_hashmap

  method new.
    data: lo_string type ref to lcl_string.
    create object o_hm.
    lo_string ?= o_hm->new( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lo_string ).
    lo_string->data = 'ValueOne'.

    lo_string ?= o_hm->new( 'IdxOne' ).
    cl_aunit_assert=>assert_initial( lo_string ).
  endmethod.                    "new

  method get.
    data: lo_string type ref to lcl_string.
    create object o_hm.
    lo_string ?= o_hm->get( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lo_string ).
    lo_string->data = 'ValueOne'.

    lo_string ?= o_hm->get( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lo_string ).
    cl_aunit_assert=>assert_equals(
      exp = 'ValueOne'
      act = lo_string->data
    ).
  endmethod.                    "get

  method set.
    data: lo_str1 type ref to lcl_string,
          lo_str2 type ref to lcl_string.
    create object lo_str1.
    lo_str1->data = 'ValueOne'.

    create object o_hm.

    lo_str2 ?= o_hm->get( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lo_str2 ).
    cl_aunit_assert=>assert_initial( lo_str2->data ).

    o_hm->set(
      key = 'IdxOne'
      value = lo_str1
    ).

    lo_str2 ?= o_hm->get( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lo_str2 ).
    cl_aunit_assert=>assert_equals(
      exp = 'ValueOne'
      act = lo_str2->data
    ).
  endmethod.                    "set

  method exists.
    create object o_hm.
    data: lv_exists type flag.

    o_hm->new( 'IdxOne' ).

    lv_exists = o_hm->exists( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lv_exists ).

    lv_exists = o_hm->exists( 'IdxTwo' ).
    cl_aunit_assert=>assert_initial( lv_exists ).
  endmethod.                    "exists

  method delete.
    create object o_hm.
    o_hm->new( 'IdxOne' ).
    o_hm->new( 'IdxTwo' ).
    o_hm->new( 'IdxThree' ).

    data: lv_exists type flag.
    lv_exists = o_hm->exists( 'IdxTwo' ).
    cl_aunit_assert=>assert_not_initial( lv_exists ).

    o_hm->delete( 'IdxTwo' ).
    lv_exists = o_hm->exists( 'IdxOne' ).
    cl_aunit_assert=>assert_not_initial( lv_exists ).
    lv_exists = o_hm->exists( 'IdxTwo' ).
    cl_aunit_assert=>assert_initial( lv_exists ).
    lv_exists = o_hm->exists( 'IdxThree' ).
    cl_aunit_assert=>assert_not_initial( lv_exists ).
  endmethod.                    "delete
endclass.                    "abap_unit_hashmap_tests IMPLEMENTATION