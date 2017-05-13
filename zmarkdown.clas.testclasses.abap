class abap_unit_string_tests definition deferred.
class abap_unit_string_array_tests definition deferred.
class abap_unit_hashmap_tests definition deferred.
class abap_unit_zmarkdown_tests definition deferred.

class zmarkdown definition local friends
  abap_unit_string_tests
  abap_unit_string_array_tests
  abap_unit_hashmap_tests
  abap_unit_zmarkdown_tests.


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


*%
*%  Generated test code for the ZMARKDOWN class
*%
*%  Generated on 2015-09-14 by generate_abapunit_tests.py
*%  Do not change this code manualy!
*%
class abap_unit_zmarkdown_tests definition create private for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short

  private section.
    data: markdown type ref to zmarkdown.
    methods:
      constructor,
      aesthetic_table for testing,
      aligned_table for testing,
      atx_heading for testing,
      automatic_link for testing,
      block_level_html for testing,
      code_block for testing,
      code_span for testing,
      compound_blockquote for testing,
      compound_emphasis for testing,
      compound_list for testing,
      deeply_nested_list for testing,
      email for testing,
      emphasis for testing,
      em_strong for testing,
      escaping for testing,
      fenced_code_block for testing,
      horizontal_rule for testing,
      html_comment for testing,
      html_entity for testing,
      image_reference for testing,
      image_title for testing,
      implicit_reference for testing,
      inline_link for testing,
      inline_link_title for testing,
      inline_title for testing,
      lazy_blockquote for testing,
      lazy_list for testing,
      line_break for testing,
      multiline_list_paragraph for testing,
      nested_block_level_html for testing,
      ordered_list for testing,
      paragraph_list for testing,
      reference_title for testing,
      self_closing_html for testing,
      separated_nested_list for testing,
      setext_header for testing,
      simple_blockquote for testing,
      simple_table for testing,
      span_level_html for testing,
      sparse_dense_list for testing,
      sparse_html for testing,
      sparse_list for testing,
      special_characters for testing,
      strikethrough for testing,
      strong_em for testing,
      tab_indented_code_block for testing,
      table_inline_markdown for testing,
      text_reference for testing,
      unordered_list for testing,
      untidy_table for testing,
      url_autolinking for testing,
      whitespace for testing.
endclass.                    "abap_unit_zmarkdown_tests DEFINITION

*#
class abap_unit_zmarkdown_tests implementation.
  method constructor.
    create object me->markdown.
  endmethod.                    "constructor

  method aesthetic_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2 |' %_newline '| -------- | -------- |' %_newline
'| cell 1.1 | cell 1.2 |' %_newline '| cell 2.1 | cell 2.2 |' into lv_markdown respecting
blanks .
    concatenate '<table>' %_newline '<thead>' %_newline '<tr>' %_newline '<th>header 1</th>'
%_newline '<th>header 2</th>' %_newline '</tr>' %_newline '</thead>' %_newline '<tbody>'
%_newline '<tr>' %_newline '<td>cell 1.1</td>' %_newline '<td>cell 1.2</td>' %_newline
'</tr>' %_newline '<tr>' %_newline '<td>cell 2.1</td>' %_newline '<td>cell 2.2</td>'
%_newline '</tr>' %_newline '</tbody>' %_newline '</table>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "aesthetic_table

  method aligned_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2 | header 2 |' %_newline
'| :------- | :------: | -------: |' %_newline '| cell 1.1 | cell 1.2 | cell 1.3 |'
%_newline '| cell 2.1 | cell 2.2 | cell 2.3 |' into lv_markdown respecting blanks .
    concatenate '<table>' %_newline '<thead>' %_newline '<tr>' %_newline
'<th style="text-align: left;">header 1</th>' %_newline
'<th style="text-align: center;">header 2</th>' %_newline
'<th style="text-align: right;">header 2</th>' %_newline '</tr>' %_newline '</thead>'
%_newline '<tbody>' %_newline '<tr>' %_newline
'<td style="text-align: left;">cell 1.1</td>' %_newline
'<td style="text-align: center;">cell 1.2</td>' %_newline
'<td style="text-align: right;">cell 1.3</td>' %_newline '</tr>' %_newline '<tr>'
%_newline '<td style="text-align: left;">cell 2.1</td>' %_newline
'<td style="text-align: center;">cell 2.2</td>' %_newline
'<td style="text-align: right;">cell 2.3</td>' %_newline '</tr>' %_newline '</tbody>'
%_newline '</table>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "aligned_table

  method atx_heading.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '# h1' %_newline %_newline '## h2' %_newline %_newline '### h3' %_newline
%_newline '#### h4' %_newline %_newline '##### h5' %_newline %_newline '###### h6'
%_newline %_newline '####### not a heading' %_newline %_newline '# closed h1 #' %_newline
%_newline '#' into lv_markdown respecting blanks .
    concatenate '<h1>h1</h1>' %_newline '<h2>h2</h2>' %_newline '<h3>h3</h3>' %_newline
'<h4>h4</h4>' %_newline '<h5>h5</h5>' %_newline '<h6>h6</h6>' %_newline
'<p>####### not a heading</p>' %_newline '<h1>closed h1</h1>' %_newline '<p>#</p>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "atx_heading

  method automatic_link.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    lv_markdown = '<http://example.com>'.
    lv_expected_markup = '<p><a href="http://example.com">http://example.com</a></p>'.
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "automatic_link

  method block_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>_content_</div>' %_newline %_newline 'paragraph' %_newline %_newline
'<div>' %_newline '  <div class="inner">' %_newline '    _content_' %_newline '  </div>'
%_newline '</div>' %_newline %_newline '<style type="text/css">' %_newline
'  p {color: #789;}' %_newline '</style>' %_newline %_newline '<div>' %_newline
'  <a href="/">home</a></div>' into lv_markdown respecting blanks .
    concatenate '<div>_content_</div>' %_newline '<p>paragraph</p>' %_newline '<div>'
%_newline '  <div class="inner">' %_newline '    _content_' %_newline '  </div>' %_newline
'</div>' %_newline '<style type="text/css">' %_newline '  p {color: #789;}' %_newline
'</style>' %_newline '<div>' %_newline '  <a href="/">home</a></div>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "block_level_html

  method code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '    <?php' %_newline %_newline '    $message = ''Hello World!'';' %_newline
'    echo $message;' %_newline %_newline '---' %_newline %_newline '    > not a quote'
%_newline '    - not a list item' %_newline '    [not a reference]: http://foo.com' into
lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_newline %_newline '$message = ''Hello World!'';'
%_newline 'echo $message;</code></pre>' %_newline '<hr />' %_newline
'<pre><code>&gt; not a quote' %_newline '- not a list item' %_newline
'[not a reference]: http://foo.com</code></pre>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "code_block

  method code_span.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'a `code span`' %_newline %_newline '`this is also a codespan` trailing text'
%_newline %_newline '`and look at this one!`' %_newline %_newline
'single backtick in a code span: `` ` ``' %_newline %_newline
'backtick-delimited string in a code span: `` `foo` ``' %_newline %_newline '`sth `` sth`'
into lv_markdown respecting blanks .
    concatenate '<p>a <code>code span</code></p>' %_newline
'<p><code>this is also a codespan</code> trailing text</p>' %_newline
'<p><code>and look at this one!</code></p>' %_newline
'<p>single backtick in a code span: <code>`</code></p>' %_newline
'<p>backtick-delimited string in a code span: <code>`foo`</code></p>' %_newline
'<p><code>sth `` sth</code></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "code_span

  method compound_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> header' %_newline '> ------' %_newline '>' %_newline '> paragraph'
%_newline '>' %_newline '> - li' %_newline '>' %_newline '> ---' %_newline '>' %_newline
'> paragraph' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_newline '<h2>header</h2>' %_newline '<p>paragraph</p>'
%_newline '<ul>' %_newline '<li>li</li>' %_newline '</ul>' %_newline '<hr />' %_newline
'<p>paragraph</p>' %_newline '</blockquote>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "compound_blockquote

  method compound_emphasis.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '_`code`_ __`code`__' %_newline %_newline '*`code`**`code`**`code`*' %_newline
into lv_markdown respecting blanks .
    concatenate '<p><em><code>code</code></em> <strong><code>code</code></strong></p>'
%_newline
'<p><em><code>code</code><strong><code>code</code></strong><code>code</code></em></p>'
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "compound_emphasis

  method compound_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- paragraph' %_newline %_newline '  paragraph' %_newline %_newline
'- paragraph' %_newline %_newline '  > quote' into lv_markdown respecting blanks .
    concatenate '<ul>' %_newline '<li>' %_newline '<p>paragraph</p>' %_newline
'<p>paragraph</p>' %_newline '</li>' %_newline '<li>' %_newline '<p>paragraph</p>'
%_newline '<blockquote>' %_newline '<p>quote</p>' %_newline '</blockquote>' %_newline
'</li>' %_newline '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "compound_list

  method deeply_nested_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline '    - li' %_newline '        - li' %_newline '        - li'
%_newline '    - li' %_newline '- li' into lv_markdown respecting blanks .
    concatenate '<ul>' %_newline '<li>li' %_newline '<ul>' %_newline '<li>li' %_newline '<ul>'
%_newline '<li>li</li>' %_newline '<li>li</li>' %_newline '</ul></li>' %_newline
'<li>li</li>' %_newline '</ul></li>' %_newline '<li>li</li>' %_newline '</ul>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "deeply_nested_list

  method email.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    lv_markdown = 'my email is <me@example.com>'.
    lv_expected_markup = '<p>my email is <a href="mailto:me@example.com">me@example.com</a></p>'.
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "email

  method emphasis.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '_underscore_, *asterisk*, _one two_, *three four*, _a_, *b*' %_newline
%_newline '**strong** and *em* and **strong** and *em*' %_newline %_newline '_line'
%_newline 'line' %_newline 'line_' %_newline %_newline 'this_is_not_an_emphasis' %_newline
%_newline 'an empty emphasis __ ** is not an emphasis' %_newline %_newline
'*mixed **double and* single asterisk** spans' into lv_markdown respecting blanks .
    concatenate
'<p><em>underscore</em>, <em>asterisk</em>, <em>one two</em>, <em>three four</em>, <em>a</e'
'm>, <em>b</em></p>' %_newline
'<p><strong>strong</strong> and <em>em</em> and <strong>strong</strong> and <em>em</em></p>'
%_newline '<p><em>line' %_newline 'line' %_newline 'line</em></p>' %_newline
'<p>this_is_not_an_emphasis</p>' %_newline
'<p>an empty emphasis __ ** is not an emphasis</p>' %_newline
'<p>*mixed *<em>double and</em> single asterisk** spans</p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "emphasis

  method em_strong.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '___em strong___' %_newline %_newline '___em strong_ strong__' %_newline
%_newline '__strong _em strong___' %_newline %_newline '__strong _em strong_ strong__'
%_newline %_newline '***em strong***' %_newline %_newline '***em strong* strong**'
%_newline %_newline '**strong *em strong***' %_newline %_newline
'**strong *em strong* strong**' into lv_markdown respecting blanks .
    concatenate '<p><strong><em>em strong</em></strong></p>' %_newline
'<p><strong><em>em strong</em> strong</strong></p>' %_newline
'<p><strong>strong <em>em strong</em></strong></p>' %_newline
'<p><strong>strong <em>em strong</em> strong</strong></p>' %_newline
'<p><strong><em>em strong</em></strong></p>' %_newline
'<p><strong><em>em strong</em> strong</strong></p>' %_newline
'<p><strong>strong <em>em strong</em></strong></p>' %_newline
'<p><strong>strong <em>em strong</em> strong</strong></p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "em_strong

  method escaping.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'escaped \*emphasis\*.' %_newline %_newline
'`escaped \*emphasis\* in a code span`' %_newline %_newline
'    escaped \*emphasis\* in a code block' %_newline %_newline
'\\ \` \* \_ \{ \} \[ \] \( \) \> \# \+ \- \. \!' %_newline %_newline
'_one\_two_ __one\_two__' %_newline %_newline '*one\*two* **one\*two**' into lv_markdown
respecting blanks .
    concatenate '<p>escaped *emphasis*.</p>' %_newline
'<p><code>escaped \*emphasis\* in a code span</code></p>' %_newline
'<pre><code>escaped \*emphasis\* in a code block</code></pre>' %_newline
'<p>\ ` * _ { } [ ] ( ) > # + - . !</p>' %_newline
'<p><em>one_two</em> <strong>one_two</strong></p>' %_newline
'<p><em>one*two</em> <strong>one*two</strong></p>' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "escaping

  method fenced_code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '```' %_newline '<?php' %_newline %_newline
'$message = ''fenced code block'';' %_newline 'echo $message;' %_newline '```' %_newline
%_newline '~~~' %_newline 'tilde' %_newline '~~~' %_newline %_newline '```php' %_newline
'echo ''language identifier'';' %_newline '```' into lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_newline %_newline '$message = ''fenced code block'';'
%_newline 'echo $message;</code></pre>' %_newline '<pre><code>tilde</code></pre>'
%_newline '<pre><code class="language-php">echo ''language identifier'';</code></pre>'
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "fenced_code_block

  method horizontal_rule.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '---' %_newline %_newline '- - -' %_newline %_newline '   - - -' %_newline
%_newline '***' %_newline %_newline '___' into lv_markdown respecting blanks .
    concatenate '<hr />' %_newline '<hr />' %_newline '<hr />' %_newline '<hr />' %_newline
'<hr />' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "horizontal_rule

  method html_comment.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<!-- single line -->' %_newline %_newline 'paragraph' %_newline %_newline
'<!-- ' %_newline '  multiline -->' %_newline %_newline 'paragraph' into lv_markdown
respecting blanks .
    concatenate '<!-- single line -->' %_newline '<p>paragraph</p>' %_newline '<!-- '
%_newline '  multiline -->' %_newline '<p>paragraph</p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "html_comment

  method html_entity.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    lv_markdown = '&amp; &copy; &#123;'.
    lv_expected_markup = '<p>&amp; &copy; &#123;</p>'.
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "html_entity

  method image_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '![Markdown Logo][image]' %_newline %_newline '[image]: /md.png' %_newline
%_newline '![missing reference]' into lv_markdown respecting blanks .
    concatenate '<p><img src="/md.png" alt="Markdown Logo" /></p>' %_newline
'<p>![missing reference]</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "image_reference

  method image_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '![alt](/md.png "title")' %_newline %_newline '![blank title](/md.png "")'
into lv_markdown respecting blanks .
    concatenate '<p><img src="/md.png" alt="alt" title="title" /></p>' %_newline
'<p><img src="/md.png" alt="blank title" title="" /></p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "image_title

  method implicit_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an [implicit] reference link' %_newline %_newline
'[implicit]: http://example.com' %_newline %_newline
'an [implicit][] reference link with an empty link definition' %_newline %_newline
'an [implicit][] reference link followed by [another][]' %_newline %_newline
'[another]: http://cnn.com' %_newline %_newline
'an [explicit][example] reference link with a title' %_newline %_newline
'[example]: http://example.com "Example"' into lv_markdown respecting blanks .
    concatenate '<p>an <a href="http://example.com">implicit</a> reference link</p>' %_newline
'<p>an <a href="http://example.com">implicit</a> reference link with an empty link definiti'
'on</p>' %_newline
'<p>an <a href="http://example.com">implicit</a> reference link followed by <a href="http:/'
'/cnn.com">another</a></p>' %_newline
'<p>an <a href="http://example.com" title="Example">explicit</a> reference link with a titl'
'e</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "implicit_reference

  method inline_link.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[link](http://example.com)' %_newline %_newline
'[link](/url-(parentheses)) with parentheses in URL ' %_newline %_newline
'([link](/index.php)) in parentheses' %_newline %_newline '[`link`](http://example.com)'
%_newline %_newline '[![MD Logo](http://parsedown.org/md.png)](http://example.com)'
%_newline %_newline
'[![MD Logo](http://parsedown.org/md.png) and text](http://example.com)' into lv_markdown
respecting blanks .
    concatenate '<p><a href="http://example.com">link</a></p>' %_newline
'<p><a href="/url-(parentheses)">link</a> with parentheses in URL </p>' %_newline
'<p>(<a href="/index.php">link</a>) in parentheses</p>' %_newline
'<p><a href="http://example.com"><code>link</code></a></p>' %_newline
'<p><a href="http://example.com"><img src="http://parsedown.org/md.png" alt="MD Logo" /></a'
'></p>' %_newline
'<p><a href="http://example.com"><img src="http://parsedown.org/md.png" alt="MD Logo" /> an'
'd text</a></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "inline_link

  method inline_link_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[single quotes](http://example.com ''Title'')' %_newline %_newline
'[double quotes](http://example.com "Title")' %_newline %_newline
'[single quotes blank](http://example.com '''')' %_newline %_newline
'[double quotes blank](http://example.com "")' %_newline %_newline
'[space](http://example.com "2 Words")' %_newline %_newline
'[parentheses](http://example.com/url-(parentheses) "Title")' into lv_markdown respecting
blanks .
    concatenate '<p><a href="http://example.com" title="Title">single quotes</a></p>'
%_newline '<p><a href="http://example.com" title="Title">double quotes</a></p>' %_newline
'<p><a href="http://example.com" title="">single quotes blank</a></p>' %_newline
'<p><a href="http://example.com" title="">double quotes blank</a></p>' %_newline
'<p><a href="http://example.com" title="2 Words">space</a></p>' %_newline
'<p><a href="http://example.com/url-(parentheses)" title="Title">parentheses</a></p>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "inline_link_title

  method inline_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate
'[single quotes](http://example.com ''Example'') and [double quotes](http://example.com "Exam'
'ple")' into lv_markdown respecting blanks .
    concatenate
'<p><a href="http://example.com" title="Example">single quotes</a> and <a href="http://exam'
'ple.com" title="Example">double quotes</a></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "inline_title

  method lazy_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> quote' %_newline 'the rest of it' %_newline %_newline '> another paragraph'
%_newline 'the rest of it' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_newline '<p>quote' %_newline 'the rest of it</p>' %_newline
'<p>another paragraph' %_newline 'the rest of it</p>' %_newline '</blockquote>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "lazy_blockquote

  method lazy_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline 'the rest of it' into lv_markdown respecting blanks .
    concatenate '<ul>' %_newline '<li>li' %_newline 'the rest of it</li>' %_newline '</ul>'
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "lazy_list

  method line_break.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'line  ' %_newline 'line' into lv_markdown respecting blanks .
    concatenate '<p>line<br />' %_newline 'line</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "line_break

  method multiline_list_paragraph.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline %_newline '  line' %_newline '  line' into lv_markdown
respecting blanks .
    concatenate '<ul>' %_newline '<li>' %_newline '<p>li</p>' %_newline '<p>line' %_newline
'line</p>' %_newline '</li>' %_newline '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "multiline_list_paragraph

  method nested_block_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>' %_newline '_parent_' %_newline '<div>' %_newline '_child_' %_newline
'</div>' %_newline '<pre>' %_newline '_adopted child_' %_newline '</pre>' %_newline
'</div>' %_newline %_newline '_outside_' into lv_markdown respecting blanks .
    concatenate '<div>' %_newline '_parent_' %_newline '<div>' %_newline '_child_' %_newline
'</div>' %_newline '<pre>' %_newline '_adopted child_' %_newline '</pre>' %_newline
'</div>' %_newline '<p><em>outside</em></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "nested_block_level_html

  method ordered_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '1. one' %_newline '2. two' %_newline %_newline 'repeating numbers:' %_newline
%_newline '1. one' %_newline '1. two' %_newline %_newline 'large numbers:' %_newline
%_newline '123. one' into lv_markdown respecting blanks .
    concatenate '<ol>' %_newline '<li>one</li>' %_newline '<li>two</li>' %_newline '</ol>'
%_newline '<p>repeating numbers:</p>' %_newline '<ol>' %_newline '<li>one</li>' %_newline
'<li>two</li>' %_newline '</ol>' %_newline '<p>large numbers:</p>' %_newline '<ol>'
%_newline '<li>one</li>' %_newline '</ol>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "ordered_list

  method paragraph_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'paragraph' %_newline '- li' %_newline '- li' %_newline %_newline 'paragraph'
%_newline %_newline '   * li' %_newline '   ' %_newline '   * li' into lv_markdown
respecting blanks .
    concatenate '<p>paragraph</p>' %_newline '<ul>' %_newline '<li>li</li>' %_newline
'<li>li</li>' %_newline '</ul>' %_newline '<p>paragraph</p>' %_newline '<ul>' %_newline
'<li>' %_newline '<p>li</p>' %_newline '</li>' %_newline '<li>li</li>' %_newline '</ul>'
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "paragraph_list

  method reference_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[double quotes] and [single quotes] and [parentheses]' %_newline %_newline
'[double quotes]: http://example.com "example title"' %_newline
'[single quotes]: http://example.com ''example title''' %_newline
'[parentheses]: http://example.com (example title)' %_newline
'[invalid title]: http://example.com example title' into lv_markdown respecting blanks .
    concatenate
'<p><a href="http://example.com" title="example title">double quotes</a> and <a href="http:'
'//example.com" title="example title">single quotes</a> and <a href="http://example.com" ti'
'tle="example title">parentheses</a></p>' %_newline
'<p>[invalid title]: <a href="http://example.com">http://example.com</a> example title</p>'
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "reference_title

  method self_closing_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<hr>' %_newline 'paragraph' %_newline '<hr/>' %_newline 'paragraph' %_newline
'<hr />' %_newline 'paragraph' %_newline '<hr class="foo" id="bar" />' %_newline
'paragraph' %_newline '<hr class="foo" id="bar"/>' %_newline 'paragraph' %_newline
'<hr class="foo" id="bar" >' %_newline 'paragraph' into lv_markdown respecting blanks .
    concatenate '<hr>' %_newline '<p>paragraph</p>' %_newline '<hr/>' %_newline
'<p>paragraph</p>' %_newline '<hr />' %_newline '<p>paragraph</p>' %_newline
'<hr class="foo" id="bar" />' %_newline '<p>paragraph</p>' %_newline
'<hr class="foo" id="bar"/>' %_newline '<p>paragraph</p>' %_newline
'<hr class="foo" id="bar" >' %_newline '<p>paragraph</p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "self_closing_html

  method separated_nested_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline %_newline '    - li' %_newline '    - li' into lv_markdown
respecting blanks .
    concatenate '<ul>' %_newline '<li>' %_newline '<p>li</p>' %_newline '<ul>' %_newline
'<li>li</li>' %_newline '<li>li</li>' %_newline '</ul>' %_newline '</li>' %_newline
'</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "separated_nested_list

  method setext_header.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'h1' %_newline '==' %_newline %_newline 'h2' %_newline '--' %_newline
%_newline 'single character' %_newline '-' %_newline %_newline 'not a header' %_newline
%_newline '------------' into lv_markdown respecting blanks .
    concatenate '<h1>h1</h1>' %_newline '<h2>h2</h2>' %_newline '<h2>single character</h2>'
%_newline '<p>not a header</p>' %_newline '<hr />' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "setext_header

  method simple_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> quote' %_newline %_newline 'indented:' %_newline '   > quote' %_newline
%_newline 'no space after `>`:' %_newline '>quote' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_newline '<p>quote</p>' %_newline '</blockquote>' %_newline
'<p>indented:</p>' %_newline '<blockquote>' %_newline '<p>quote</p>' %_newline
'</blockquote>' %_newline '<p>no space after <code>&gt;</code>:</p>' %_newline
'<blockquote>' %_newline '<p>quote</p>' %_newline '</blockquote>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "simple_blockquote

  method simple_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'header 1 | header 2' %_newline '-------- | --------' %_newline
'cell 1.1 | cell 1.2' %_newline 'cell 2.1 | cell 2.2' %_newline %_newline '---' %_newline
%_newline 'header 1 | header 2' %_newline ':------- | --------' %_newline
'cell 1.1 | cell 1.2' %_newline 'cell 2.1 | cell 2.2' into lv_markdown respecting blanks .
    concatenate '<table>' %_newline '<thead>' %_newline '<tr>' %_newline '<th>header 1</th>'
%_newline '<th>header 2</th>' %_newline '</tr>' %_newline '</thead>' %_newline '<tbody>'
%_newline '<tr>' %_newline '<td>cell 1.1</td>' %_newline '<td>cell 1.2</td>' %_newline
'</tr>' %_newline '<tr>' %_newline '<td>cell 2.1</td>' %_newline '<td>cell 2.2</td>'
%_newline '</tr>' %_newline '</tbody>' %_newline '</table>' %_newline '<hr />' %_newline
'<table>' %_newline '<thead>' %_newline '<tr>' %_newline
'<th style="text-align: left;">header 1</th>' %_newline '<th>header 2</th>' %_newline
'</tr>' %_newline '</thead>' %_newline '<tbody>' %_newline '<tr>' %_newline
'<td style="text-align: left;">cell 1.1</td>' %_newline '<td>cell 1.2</td>' %_newline
'</tr>' %_newline '<tr>' %_newline '<td style="text-align: left;">cell 2.1</td>' %_newline
'<td>cell 2.2</td>' %_newline '</tr>' %_newline '</tbody>' %_newline '</table>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "simple_table

  method span_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an <b>important</b> <a href=''''>link</a>' %_newline %_newline 'broken<br/>'
%_newline 'line' %_newline %_newline '<b>inline tag</b> at the beginning' %_newline
%_newline '<span>http://example.com</span>' into lv_markdown respecting blanks .
    concatenate '<p>an <b>important</b> <a href=''''>link</a></p>' %_newline '<p>broken<br/>'
%_newline 'line</p>' %_newline '<p><b>inline tag</b> at the beginning</p>' %_newline
'<p><span><a href="http://example.com">http://example.com</a></span></p>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "span_level_html

  method sparse_dense_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline %_newline '- li' %_newline '- li' into lv_markdown respecting
blanks .
    concatenate '<ul>' %_newline '<li>' %_newline '<p>li</p>' %_newline '</li>' %_newline
'<li>li</li>' %_newline '<li>li</li>' %_newline '</ul>' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "sparse_dense_list

  method sparse_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>' %_newline 'line 1' %_newline %_newline 'line 2' %_newline 'line 3'
%_newline %_newline 'line 4' %_newline '</div>' into lv_markdown respecting blanks .
    concatenate '<div>' %_newline 'line 1' %_newline %_newline 'line 2' %_newline 'line 3'
%_newline %_newline 'line 4' %_newline '</div>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "sparse_html

  method sparse_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline %_newline '- li' %_newline %_newline '---' %_newline
%_newline '- li' %_newline %_newline '    - indented li' into lv_markdown respecting
blanks .
    concatenate '<ul>' %_newline '<li>' %_newline '<p>li</p>' %_newline '</li>' %_newline
'<li>li</li>' %_newline '</ul>' %_newline '<hr />' %_newline '<ul>' %_newline '<li>'
%_newline '<p>li</p>' %_newline '<ul>' %_newline '<li>indented li</li>' %_newline '</ul>'
%_newline '</li>' %_newline '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "sparse_list

  method special_characters.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'AT&T has an ampersand in their name' %_newline %_newline 'this & that'
%_newline %_newline '4 < 5 and 6 > 5' %_newline %_newline
'<http://example.com/autolink?a=1&b=2>' %_newline %_newline
'[inline link](/script?a=1&b=2)' %_newline %_newline '[reference link][1]' %_newline
%_newline '[1]: http://example.com/?a=1&b=2' into lv_markdown respecting blanks .
    concatenate '<p>AT&amp;T has an ampersand in their name</p>' %_newline
'<p>this &amp; that</p>' %_newline '<p>4 &lt; 5 and 6 &gt; 5</p>' %_newline
'<p><a href="http://example.com/autolink?a=1&amp;b=2">http://example.com/autolink?a=1&amp;b'
'=2</a></p>' %_newline '<p><a href="/script?a=1&amp;b=2">inline link</a></p>' %_newline
'<p><a href="http://example.com/?a=1&amp;b=2">reference link</a></p>' into
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "special_characters

  method strikethrough.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '~~strikethrough~~' %_newline %_newline
'here''s ~~one~~ followed by ~~another one~~' %_newline %_newline
'~~ this ~~ is not one neither is ~this~' into lv_markdown respecting blanks .
    concatenate '<p><del>strikethrough</del></p>' %_newline
'<p>here''s <del>one</del> followed by <del>another one</del></p>' %_newline
'<p>~~ this ~~ is not one neither is ~this~</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "strikethrough

  method strong_em.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '*em **strong em***' %_newline %_newline '***strong em** em*' %_newline
%_newline '*em **strong em** em*' %_newline %_newline '_em __strong em___' %_newline
%_newline '___strong em__ em_' %_newline %_newline '_em __strong em__ em_' into
lv_markdown respecting blanks .
    concatenate '<p><em>em <strong>strong em</strong></em></p>' %_newline
'<p><em><strong>strong em</strong> em</em></p>' %_newline
'<p><em>em <strong>strong em</strong> em</em></p>' %_newline
'<p><em>em <strong>strong em</strong></em></p>' %_newline
'<p><em><strong>strong em</strong> em</em></p>' %_newline
'<p><em>em <strong>strong em</strong> em</em></p>' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "strong_em

  method tab_indented_code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '' %_horizontal_tab '<?php' %_newline '' %_horizontal_tab '' %_newline
'' %_horizontal_tab '$message = ''Hello World!'';' %_newline
'' %_horizontal_tab 'echo $message;' %_newline %_newline
'' %_horizontal_tab 'echo "following a blank line";' into lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_newline %_newline '$message = ''Hello World!'';'
%_newline 'echo $message;' %_newline %_newline
'echo "following a blank line";</code></pre>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "tab_indented_code_block

  method table_inline_markdown.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| _header_ 1   | header 2     |' %_newline '| ------------ | ------------ |'
%_newline '| _cell_ 1.1   | ~~cell~~ 1.2 |' %_newline '| `|` 2.1      | \| 2.2       |'
%_newline '| `\|` 2.1     | [link](/)    |' into lv_markdown respecting blanks .
    concatenate '<table>' %_newline '<thead>' %_newline '<tr>' %_newline
'<th><em>header</em> 1</th>' %_newline '<th>header 2</th>' %_newline '</tr>' %_newline
'</thead>' %_newline '<tbody>' %_newline '<tr>' %_newline '<td><em>cell</em> 1.1</td>'
%_newline '<td><del>cell</del> 1.2</td>' %_newline '</tr>' %_newline '<tr>' %_newline
'<td><code>|</code> 2.1</td>' %_newline '<td>| 2.2</td>' %_newline '</tr>' %_newline
'<tr>' %_newline '<td><code>\|</code> 2.1</td>' %_newline '<td><a href="/">link</a></td>'
%_newline '</tr>' %_newline '</tbody>' %_newline '</table>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "table_inline_markdown

  method text_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[reference link][1]' %_newline %_newline '[1]: http://example.com' %_newline
%_newline '[one][website] with a semantic name' %_newline %_newline
'[website]: http://example.com' %_newline %_newline '[one][404] with no definition'
%_newline %_newline '[multiline' %_newline 'one][website] defined on 2 lines' %_newline
%_newline '[one][Label] with a mixed case label and an upper case definition' %_newline
%_newline '[LABEL]: http://example.com' %_newline %_newline '[one]' %_newline
'[1] with the a label on the next line' %_newline %_newline '[`link`][website]' into
lv_markdown respecting blanks .
    concatenate '<p><a href="http://example.com">reference link</a></p>' %_newline
'<p><a href="http://example.com">one</a> with a semantic name</p>' %_newline
'<p>[one][404] with no definition</p>' %_newline
'<p><a href="http://example.com">multiline' %_newline 'one</a> defined on 2 lines</p>'
%_newline
'<p><a href="http://example.com">one</a> with a mixed case label and an upper case definiti'
'on</p>' %_newline
'<p><a href="http://example.com">one</a> with the a label on the next line</p>' %_newline
'<p><a href="http://example.com"><code>link</code></a></p>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "text_reference

  method unordered_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_newline '- li' %_newline %_newline 'mixed markers:' %_newline
%_newline '* li' %_newline '+ li' %_newline '- li' into lv_markdown respecting blanks .
    concatenate '<ul>' %_newline '<li>li</li>' %_newline '<li>li</li>' %_newline '</ul>'
%_newline '<p>mixed markers:</p>' %_newline '<ul>' %_newline '<li>li</li>' %_newline
'<li>li</li>' %_newline '<li>li</li>' %_newline '</ul>' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "unordered_list

  method untidy_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2          |' %_newline '| ------------- | ----------- |'
%_newline '| cell 1.1   | cell 1.2 |' %_newline '|    cell 2.1 | cell 2.2     |' into
lv_markdown respecting blanks .
    concatenate '<table>' %_newline '<thead>' %_newline '<tr>' %_newline '<th>header 1</th>'
%_newline '<th>header 2</th>' %_newline '</tr>' %_newline '</thead>' %_newline '<tbody>'
%_newline '<tr>' %_newline '<td>cell 1.1</td>' %_newline '<td>cell 1.2</td>' %_newline
'</tr>' %_newline '<tr>' %_newline '<td>cell 2.1</td>' %_newline '<td>cell 2.2</td>'
%_newline '</tr>' %_newline '</tbody>' %_newline '</table>' into lv_expected_markup
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "untidy_table

  method url_autolinking.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an autolink http://example.com' %_newline %_newline
'inside of brackets [http://example.com], inside of braces {http://example.com},  inside of'
' parentheses (http://example.com)' %_newline %_newline
'trailing slash http://example.com/ and http://example.com/path/' into lv_markdown
respecting blanks .
    concatenate '<p>an autolink <a href="http://example.com">http://example.com</a></p>'
%_newline
'<p>inside of brackets [<a href="http://example.com">http://example.com</a>], inside of bra'
'ces {<a href="http://example.com">http://example.com</a>},  inside of parentheses (<a href'
'="http://example.com">http://example.com</a>)</p>' %_newline
'<p>trailing slash <a href="http://example.com/">http://example.com/</a> and <a href="http:'
'//example.com/path/">http://example.com/path/</a></p>' into lv_expected_markup respecting
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "url_autolinking

  method whitespace.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '    ' %_newline %_newline '    code' %_newline %_newline '    ' into
lv_markdown respecting blanks .
    lv_expected_markup = '<pre><code>code</code></pre>'.
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.                    "whitespace
endclass.                    "abap_unit_zmarkdown_tests IMPLEMENTATION
