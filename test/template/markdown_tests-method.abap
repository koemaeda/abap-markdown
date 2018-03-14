  method [METHOD_NAME].
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    [MARKDOWN_LINES]
    [EXPECTED_MARKUP_LINES]
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.