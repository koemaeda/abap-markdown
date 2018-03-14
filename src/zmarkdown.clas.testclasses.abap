*%
*% ABAP Markdown
*% (c) Guilherme Maeda
*% http://abap.ninja
*%
*% For the full license information, view the LICENSE file that was distributed
*% with this source code.
*%

*%
*%  Generated test code for the ZMARKDOWN class
*%
*%  Generated on 2018-03-14 by generate_abapunit_tests.py
*%  Do not change this code manualy!
*%

"!
"! Unit test class for the string template class
"!
class string_tests definition for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short
  private section.
    data: o_string type ref to lcl_string.
    methods:
      copying for testing.
endclass.                    "string_tests DEFINITION
*!
class string_tests implementation.
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
endclass.                    "string_tests IMPLEMENTATION


"!
"! Unit test class for the string array template class
"!
class string_array_tests definition for testing.
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
endclass.                    "string_array_tests DEFINITION
*!
class string_array_tests implementation.
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
endclass.                    "string_array_tests IMPLEMENTATION


"!
"! Unit test class for the hashmap template class
"!
class hashmap_tests definition for testing.
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
endclass.                    "hashmap_tests DEFINITION
*!
class hashmap_tests implementation.
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
endclass.                    "hashmap_tests IMPLEMENTATION


class markdown_tests definition create private for testing.
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
      em_strong for testing,
      email for testing,
      emphasis for testing,
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
endclass.                    "markdown_tests DEFINITION

*#
class markdown_tests implementation.
  method constructor.
    create object me->markdown.
  endmethod.

    method aesthetic_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2 |' %_NEWLINE '| -------- | -------- |' %_NEWLINE 
'| cell 1.1 | cell 1.2 |' %_NEWLINE '| cell 2.1 | cell 2.2 |' into lv_markdown respecting 
blanks .
    concatenate '<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE '<th>header 1</th>' 
%_NEWLINE '<th>header 2</th>' %_NEWLINE '</tr>' %_NEWLINE '</thead>' %_NEWLINE '<tbody>' 
%_NEWLINE '<tr>' %_NEWLINE '<td>cell 1.1</td>' %_NEWLINE '<td>cell 1.2</td>' %_NEWLINE 
'</tr>' %_NEWLINE '<tr>' %_NEWLINE '<td>cell 2.1</td>' %_NEWLINE '<td>cell 2.2</td>' 
%_NEWLINE '</tr>' %_NEWLINE '</tbody>' %_NEWLINE '</table>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method aligned_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2 | header 2 |' %_NEWLINE 
'| :------- | :------: | -------: |' %_NEWLINE '| cell 1.1 | cell 1.2 | cell 1.3 |' 
%_NEWLINE '| cell 2.1 | cell 2.2 | cell 2.3 |' into lv_markdown respecting blanks .
    concatenate '<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE 
'<th style="text-align: left;">header 1</th>' %_NEWLINE 
'<th style="text-align: center;">header 2</th>' %_NEWLINE 
'<th style="text-align: right;">header 2</th>' %_NEWLINE '</tr>' %_NEWLINE '</thead>' 
%_NEWLINE '<tbody>' %_NEWLINE '<tr>' %_NEWLINE 
'<td style="text-align: left;">cell 1.1</td>' %_NEWLINE 
'<td style="text-align: center;">cell 1.2</td>' %_NEWLINE 
'<td style="text-align: right;">cell 1.3</td>' %_NEWLINE '</tr>' %_NEWLINE '<tr>' 
%_NEWLINE '<td style="text-align: left;">cell 2.1</td>' %_NEWLINE 
'<td style="text-align: center;">cell 2.2</td>' %_NEWLINE 
'<td style="text-align: right;">cell 2.3</td>' %_NEWLINE '</tr>' %_NEWLINE '</tbody>' 
%_NEWLINE '</table>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method atx_heading.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '# h1' %_NEWLINE %_NEWLINE '## h2' %_NEWLINE %_NEWLINE '### h3' %_NEWLINE 
%_NEWLINE '#### h4' %_NEWLINE %_NEWLINE '##### h5' %_NEWLINE %_NEWLINE '###### h6' 
%_NEWLINE %_NEWLINE '####### not a heading' %_NEWLINE %_NEWLINE '# closed h1 #' %_NEWLINE 
%_NEWLINE '#' into lv_markdown respecting blanks .
    concatenate '<h1>h1</h1>' %_NEWLINE '<h2>h2</h2>' %_NEWLINE '<h3>h3</h3>' %_NEWLINE 
'<h4>h4</h4>' %_NEWLINE '<h5>h5</h5>' %_NEWLINE '<h6>h6</h6>' %_NEWLINE 
'<p>####### not a heading</p>' %_NEWLINE '<h1>closed h1</h1>' %_NEWLINE '<p>#</p>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

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
  endmethod.

  method block_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>_content_</div>' %_NEWLINE %_NEWLINE 'paragraph' %_NEWLINE %_NEWLINE 
'<div>' %_NEWLINE '  <div class="inner">' %_NEWLINE '    _content_' %_NEWLINE '  </div>' 
%_NEWLINE '</div>' %_NEWLINE %_NEWLINE '<style type="text/css">' %_NEWLINE 
'  p {color: #789;}' %_NEWLINE '</style>' %_NEWLINE %_NEWLINE '<div>' %_NEWLINE 
'  <a href="/">home</a></div>' into lv_markdown respecting blanks .
    concatenate '<div>_content_</div>' %_NEWLINE '<p>paragraph</p>' %_NEWLINE '<div>' 
%_NEWLINE '  <div class="inner">' %_NEWLINE '    _content_' %_NEWLINE '  </div>' %_NEWLINE 
'</div>' %_NEWLINE '<style type="text/css">' %_NEWLINE '  p {color: #789;}' %_NEWLINE 
'</style>' %_NEWLINE '<div>' %_NEWLINE '  <a href="/">home</a></div>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '    <?php' %_NEWLINE %_NEWLINE '    $message = ''Hello World!'';' %_NEWLINE 
'    echo $message;' %_NEWLINE %_NEWLINE '---' %_NEWLINE %_NEWLINE '    > not a quote' 
%_NEWLINE '    - not a list item' %_NEWLINE '    [not a reference]: http://foo.com' into 
lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_NEWLINE %_NEWLINE '$message = ''Hello World!'';' 
%_NEWLINE 'echo $message;</code></pre>' %_NEWLINE '<hr />' %_NEWLINE 
'<pre><code>&gt; not a quote' %_NEWLINE '- not a list item' %_NEWLINE 
'[not a reference]: http://foo.com</code></pre>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method code_span.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'a `code span`' %_NEWLINE %_NEWLINE '`this is also a codespan` trailing text' 
%_NEWLINE %_NEWLINE '`and look at this one!`' %_NEWLINE %_NEWLINE 
'single backtick in a code span: `` ` ``' %_NEWLINE %_NEWLINE 
'backtick-delimited string in a code span: `` `foo` ``' %_NEWLINE %_NEWLINE '`sth `` sth`' 
into lv_markdown respecting blanks .
    concatenate '<p>a <code>code span</code></p>' %_NEWLINE 
'<p><code>this is also a codespan</code> trailing text</p>' %_NEWLINE 
'<p><code>and look at this one!</code></p>' %_NEWLINE 
'<p>single backtick in a code span: <code>`</code></p>' %_NEWLINE 
'<p>backtick-delimited string in a code span: <code>`foo`</code></p>' %_NEWLINE 
'<p><code>sth `` sth</code></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method compound_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> header' %_NEWLINE '> ------' %_NEWLINE '>' %_NEWLINE '> paragraph' 
%_NEWLINE '>' %_NEWLINE '> - li' %_NEWLINE '>' %_NEWLINE '> ---' %_NEWLINE '>' %_NEWLINE 
'> paragraph' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_NEWLINE '<h2>header</h2>' %_NEWLINE '<p>paragraph</p>' 
%_NEWLINE '<ul>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' %_NEWLINE '<hr />' %_NEWLINE 
'<p>paragraph</p>' %_NEWLINE '</blockquote>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method compound_emphasis.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '_`code`_ __`code`__' %_NEWLINE %_NEWLINE '*`code`**`code`**`code`*' %_NEWLINE 
into lv_markdown respecting blanks .
    concatenate '<p><em><code>code</code></em> <strong><code>code</code></strong></p>' 
%_NEWLINE 
'<p><em><code>code</code><strong><code>code</code></strong><code>code</code></em></p>' 
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method compound_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- paragraph' %_NEWLINE %_NEWLINE '  paragraph' %_NEWLINE %_NEWLINE 
'- paragraph' %_NEWLINE %_NEWLINE '  > quote' into lv_markdown respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>' %_NEWLINE '<p>paragraph</p>' %_NEWLINE 
'<p>paragraph</p>' %_NEWLINE '</li>' %_NEWLINE '<li>' %_NEWLINE '<p>paragraph</p>' 
%_NEWLINE '<blockquote>' %_NEWLINE '<p>quote</p>' %_NEWLINE '</blockquote>' %_NEWLINE 
'</li>' %_NEWLINE '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method deeply_nested_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE '    - li' %_NEWLINE '        - li' %_NEWLINE '        - li' 
%_NEWLINE '    - li' %_NEWLINE '- li' into lv_markdown respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>li' %_NEWLINE '<ul>' %_NEWLINE '<li>li' %_NEWLINE '<ul>' 
%_NEWLINE '<li>li</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul></li>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '</ul></li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method em_strong.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '___em strong___' %_NEWLINE %_NEWLINE '___em strong_ strong__' %_NEWLINE 
%_NEWLINE '__strong _em strong___' %_NEWLINE %_NEWLINE '__strong _em strong_ strong__' 
%_NEWLINE %_NEWLINE '***em strong***' %_NEWLINE %_NEWLINE '***em strong* strong**' 
%_NEWLINE %_NEWLINE '**strong *em strong***' %_NEWLINE %_NEWLINE 
'**strong *em strong* strong**' into lv_markdown respecting blanks .
    concatenate '<p><strong><em>em strong</em></strong></p>' %_NEWLINE 
'<p><strong><em>em strong</em> strong</strong></p>' %_NEWLINE 
'<p><strong>strong <em>em strong</em></strong></p>' %_NEWLINE 
'<p><strong>strong <em>em strong</em> strong</strong></p>' %_NEWLINE 
'<p><strong><em>em strong</em></strong></p>' %_NEWLINE 
'<p><strong><em>em strong</em> strong</strong></p>' %_NEWLINE 
'<p><strong>strong <em>em strong</em></strong></p>' %_NEWLINE 
'<p><strong>strong <em>em strong</em> strong</strong></p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

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
  endmethod.

  method emphasis.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '_underscore_, *asterisk*, _one two_, *three four*, _a_, *b*' %_NEWLINE 
%_NEWLINE '**strong** and *em* and **strong** and *em*' %_NEWLINE %_NEWLINE '_line' 
%_NEWLINE 'line' %_NEWLINE 'line_' %_NEWLINE %_NEWLINE 'this_is_not_an_emphasis' %_NEWLINE 
%_NEWLINE 'an empty emphasis __ ** is not an emphasis' %_NEWLINE %_NEWLINE 
'*mixed **double and* single asterisk** spans' into lv_markdown respecting blanks .
    concatenate 
'<p><em>underscore</em>, <em>asterisk</em>, <em>one two</em>, <em>three four</em>, <em>a</e' 
'm>, <em>b</em></p>' %_NEWLINE 
'<p><strong>strong</strong> and <em>em</em> and <strong>strong</strong> and <em>em</em></p>' 
%_NEWLINE '<p><em>line' %_NEWLINE 'line' %_NEWLINE 'line</em></p>' %_NEWLINE 
'<p>this_is_not_an_emphasis</p>' %_NEWLINE 
'<p>an empty emphasis __ ** is not an emphasis</p>' %_NEWLINE 
'<p>*mixed *<em>double and</em> single asterisk** spans</p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method escaping.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'escaped \*emphasis\*.' %_NEWLINE %_NEWLINE 
'`escaped \*emphasis\* in a code span`' %_NEWLINE %_NEWLINE 
'    escaped \*emphasis\* in a code block' %_NEWLINE %_NEWLINE 
'\\ \` \* \_ \{ \} \[ \] \( \) \> \# \+ \- \. \!' %_NEWLINE %_NEWLINE 
'_one\_two_ __one\_two__' %_NEWLINE %_NEWLINE '*one\*two* **one\*two**' into lv_markdown 
respecting blanks .
    concatenate '<p>escaped *emphasis*.</p>' %_NEWLINE 
'<p><code>escaped \*emphasis\* in a code span</code></p>' %_NEWLINE 
'<pre><code>escaped \*emphasis\* in a code block</code></pre>' %_NEWLINE 
'<p>\ ` * _ { } [ ] ( ) > # + - . !</p>' %_NEWLINE 
'<p><em>one_two</em> <strong>one_two</strong></p>' %_NEWLINE 
'<p><em>one*two</em> <strong>one*two</strong></p>' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method fenced_code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '```' %_NEWLINE '<?php' %_NEWLINE %_NEWLINE 
'$message = ''fenced code block'';' %_NEWLINE 'echo $message;' %_NEWLINE '```' %_NEWLINE 
%_NEWLINE '~~~' %_NEWLINE 'tilde' %_NEWLINE '~~~' %_NEWLINE %_NEWLINE '```php' %_NEWLINE 
'echo ''language identifier'';' %_NEWLINE '```' into lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_NEWLINE %_NEWLINE '$message = ''fenced code block'';' 
%_NEWLINE 'echo $message;</code></pre>' %_NEWLINE '<pre><code>tilde</code></pre>' 
%_NEWLINE '<pre><code class="language-php">echo ''language identifier'';</code></pre>' 
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method horizontal_rule.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '---' %_NEWLINE %_NEWLINE '- - -' %_NEWLINE %_NEWLINE '   - - -' %_NEWLINE 
%_NEWLINE '***' %_NEWLINE %_NEWLINE '___' into lv_markdown respecting blanks .
    concatenate '<hr />' %_NEWLINE '<hr />' %_NEWLINE '<hr />' %_NEWLINE '<hr />' %_NEWLINE 
'<hr />' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method html_comment.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<!-- single line -->' %_NEWLINE %_NEWLINE 'paragraph' %_NEWLINE %_NEWLINE 
'<!-- ' %_NEWLINE '  multiline -->' %_NEWLINE %_NEWLINE 'paragraph' into lv_markdown 
respecting blanks .
    concatenate '<!-- single line -->' %_NEWLINE '<p>paragraph</p>' %_NEWLINE '<!-- ' 
%_NEWLINE '  multiline -->' %_NEWLINE '<p>paragraph</p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

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
  endmethod.

  method image_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '![Markdown Logo][image]' %_NEWLINE %_NEWLINE '[image]: /md.png' %_NEWLINE 
%_NEWLINE '![missing reference]' into lv_markdown respecting blanks .
    concatenate '<p><img src="/md.png" alt="Markdown Logo" /></p>' %_NEWLINE 
'<p>![missing reference]</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method image_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '![alt](/md.png "title")' %_NEWLINE %_NEWLINE '![blank title](/md.png "")' 
into lv_markdown respecting blanks .
    concatenate '<p><img src="/md.png" alt="alt" title="title" /></p>' %_NEWLINE 
'<p><img src="/md.png" alt="blank title" title="" /></p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method implicit_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an [implicit] reference link' %_NEWLINE %_NEWLINE 
'[implicit]: http://example.com' %_NEWLINE %_NEWLINE 
'an [implicit][] reference link with an empty link definition' %_NEWLINE %_NEWLINE 
'an [implicit][] reference link followed by [another][]' %_NEWLINE %_NEWLINE 
'[another]: http://cnn.com' %_NEWLINE %_NEWLINE 
'an [explicit][example] reference link with a title' %_NEWLINE %_NEWLINE 
'[example]: http://example.com "Example"' into lv_markdown respecting blanks .
    concatenate '<p>an <a href="http://example.com">implicit</a> reference link</p>' %_NEWLINE 
'<p>an <a href="http://example.com">implicit</a> reference link with an empty link definiti' 
'on</p>' %_NEWLINE 
'<p>an <a href="http://example.com">implicit</a> reference link followed by <a href="http:/' 
'/cnn.com">another</a></p>' %_NEWLINE 
'<p>an <a href="http://example.com" title="Example">explicit</a> reference link with a titl' 
'e</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method inline_link.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[link](http://example.com)' %_NEWLINE %_NEWLINE 
'[link](/url-(parentheses)) with parentheses in URL ' %_NEWLINE %_NEWLINE 
'([link](/index.php)) in parentheses' %_NEWLINE %_NEWLINE '[`link`](http://example.com)' 
%_NEWLINE %_NEWLINE '[![MD Logo](http://parsedown.org/md.png)](http://example.com)' 
%_NEWLINE %_NEWLINE 
'[![MD Logo](http://parsedown.org/md.png) and text](http://example.com)' into lv_markdown 
respecting blanks .
    concatenate '<p><a href="http://example.com">link</a></p>' %_NEWLINE 
'<p><a href="/url-(parentheses)">link</a> with parentheses in URL </p>' %_NEWLINE 
'<p>(<a href="/index.php">link</a>) in parentheses</p>' %_NEWLINE 
'<p><a href="http://example.com"><code>link</code></a></p>' %_NEWLINE 
'<p><a href="http://example.com"><img src="http://parsedown.org/md.png" alt="MD Logo" /></a' 
'></p>' %_NEWLINE 
'<p><a href="http://example.com"><img src="http://parsedown.org/md.png" alt="MD Logo" /> an' 
'd text</a></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method inline_link_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[single quotes](http://example.com ''Title'')' %_NEWLINE %_NEWLINE 
'[double quotes](http://example.com "Title")' %_NEWLINE %_NEWLINE 
'[single quotes blank](http://example.com '''')' %_NEWLINE %_NEWLINE 
'[double quotes blank](http://example.com "")' %_NEWLINE %_NEWLINE 
'[space](http://example.com "2 Words")' %_NEWLINE %_NEWLINE 
'[parentheses](http://example.com/url-(parentheses) "Title")' into lv_markdown respecting 
blanks .
    concatenate '<p><a href="http://example.com" title="Title">single quotes</a></p>' 
%_NEWLINE '<p><a href="http://example.com" title="Title">double quotes</a></p>' %_NEWLINE 
'<p><a href="http://example.com" title="">single quotes blank</a></p>' %_NEWLINE 
'<p><a href="http://example.com" title="">double quotes blank</a></p>' %_NEWLINE 
'<p><a href="http://example.com" title="2 Words">space</a></p>' %_NEWLINE 
'<p><a href="http://example.com/url-(parentheses)" title="Title">parentheses</a></p>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

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
  endmethod.

  method lazy_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> quote' %_NEWLINE 'the rest of it' %_NEWLINE %_NEWLINE '> another paragraph' 
%_NEWLINE 'the rest of it' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_NEWLINE '<p>quote' %_NEWLINE 'the rest of it</p>' %_NEWLINE 
'<p>another paragraph' %_NEWLINE 'the rest of it</p>' %_NEWLINE '</blockquote>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method lazy_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE 'the rest of it' into lv_markdown respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>li' %_NEWLINE 'the rest of it</li>' %_NEWLINE '</ul>' 
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method line_break.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'line  ' %_NEWLINE 'line' into lv_markdown respecting blanks .
    concatenate '<p>line<br />' %_NEWLINE 'line</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method multiline_list_paragraph.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE %_NEWLINE '  line' %_NEWLINE '  line' into lv_markdown 
respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>' %_NEWLINE '<p>li</p>' %_NEWLINE '<p>line' %_NEWLINE 
'line</p>' %_NEWLINE '</li>' %_NEWLINE '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method nested_block_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>' %_NEWLINE '_parent_' %_NEWLINE '<div>' %_NEWLINE '_child_' %_NEWLINE 
'</div>' %_NEWLINE '<pre>' %_NEWLINE '_adopted child_' %_NEWLINE '</pre>' %_NEWLINE 
'</div>' %_NEWLINE %_NEWLINE '_outside_' into lv_markdown respecting blanks .
    concatenate '<div>' %_NEWLINE '_parent_' %_NEWLINE '<div>' %_NEWLINE '_child_' %_NEWLINE 
'</div>' %_NEWLINE '<pre>' %_NEWLINE '_adopted child_' %_NEWLINE '</pre>' %_NEWLINE 
'</div>' %_NEWLINE '<p><em>outside</em></p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method ordered_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '1. one' %_NEWLINE '2. two' %_NEWLINE %_NEWLINE 'repeating numbers:' %_NEWLINE 
%_NEWLINE '1. one' %_NEWLINE '1. two' %_NEWLINE %_NEWLINE 'large numbers:' %_NEWLINE 
%_NEWLINE '123. one' into lv_markdown respecting blanks .
    concatenate '<ol>' %_NEWLINE '<li>one</li>' %_NEWLINE '<li>two</li>' %_NEWLINE '</ol>' 
%_NEWLINE '<p>repeating numbers:</p>' %_NEWLINE '<ol>' %_NEWLINE '<li>one</li>' %_NEWLINE 
'<li>two</li>' %_NEWLINE '</ol>' %_NEWLINE '<p>large numbers:</p>' %_NEWLINE '<ol>' 
%_NEWLINE '<li>one</li>' %_NEWLINE '</ol>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method paragraph_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'paragraph' %_NEWLINE '- li' %_NEWLINE '- li' %_NEWLINE %_NEWLINE 'paragraph' 
%_NEWLINE %_NEWLINE '   * li' %_NEWLINE '   ' %_NEWLINE '   * li' into lv_markdown 
respecting blanks .
    concatenate '<p>paragraph</p>' %_NEWLINE '<ul>' %_NEWLINE '<li>li</li>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '</ul>' %_NEWLINE '<p>paragraph</p>' %_NEWLINE '<ul>' %_NEWLINE 
'<li>' %_NEWLINE '<p>li</p>' %_NEWLINE '</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' 
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method reference_title.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[double quotes] and [single quotes] and [parentheses]' %_NEWLINE %_NEWLINE 
'[double quotes]: http://example.com "example title"' %_NEWLINE 
'[single quotes]: http://example.com ''example title''' %_NEWLINE 
'[parentheses]: http://example.com (example title)' %_NEWLINE 
'[invalid title]: http://example.com example title' into lv_markdown respecting blanks .
    concatenate 
'<p><a href="http://example.com" title="example title">double quotes</a> and <a href="http:' 
'//example.com" title="example title">single quotes</a> and <a href="http://example.com" ti' 
'tle="example title">parentheses</a></p>' %_NEWLINE 
'<p>[invalid title]: <a href="http://example.com">http://example.com</a> example title</p>' 
into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method self_closing_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<hr>' %_NEWLINE 'paragraph' %_NEWLINE '<hr/>' %_NEWLINE 'paragraph' %_NEWLINE 
'<hr />' %_NEWLINE 'paragraph' %_NEWLINE '<hr class="foo" id="bar" />' %_NEWLINE 
'paragraph' %_NEWLINE '<hr class="foo" id="bar"/>' %_NEWLINE 'paragraph' %_NEWLINE 
'<hr class="foo" id="bar" >' %_NEWLINE 'paragraph' into lv_markdown respecting blanks .
    concatenate '<hr>' %_NEWLINE '<p>paragraph</p>' %_NEWLINE '<hr/>' %_NEWLINE 
'<p>paragraph</p>' %_NEWLINE '<hr />' %_NEWLINE '<p>paragraph</p>' %_NEWLINE 
'<hr class="foo" id="bar" />' %_NEWLINE '<p>paragraph</p>' %_NEWLINE 
'<hr class="foo" id="bar"/>' %_NEWLINE '<p>paragraph</p>' %_NEWLINE 
'<hr class="foo" id="bar" >' %_NEWLINE '<p>paragraph</p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method separated_nested_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE %_NEWLINE '    - li' %_NEWLINE '    - li' into lv_markdown 
respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>' %_NEWLINE '<p>li</p>' %_NEWLINE '<ul>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' %_NEWLINE '</li>' %_NEWLINE 
'</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method setext_header.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'h1' %_NEWLINE '==' %_NEWLINE %_NEWLINE 'h2' %_NEWLINE '--' %_NEWLINE 
%_NEWLINE 'single character' %_NEWLINE '-' %_NEWLINE %_NEWLINE 'not a header' %_NEWLINE 
%_NEWLINE '------------' into lv_markdown respecting blanks .
    concatenate '<h1>h1</h1>' %_NEWLINE '<h2>h2</h2>' %_NEWLINE '<h2>single character</h2>' 
%_NEWLINE '<p>not a header</p>' %_NEWLINE '<hr />' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method simple_blockquote.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '> quote' %_NEWLINE %_NEWLINE 'indented:' %_NEWLINE '   > quote' %_NEWLINE 
%_NEWLINE 'no space after `>`:' %_NEWLINE '>quote' into lv_markdown respecting blanks .
    concatenate '<blockquote>' %_NEWLINE '<p>quote</p>' %_NEWLINE '</blockquote>' %_NEWLINE 
'<p>indented:</p>' %_NEWLINE '<blockquote>' %_NEWLINE '<p>quote</p>' %_NEWLINE 
'</blockquote>' %_NEWLINE '<p>no space after <code>&gt;</code>:</p>' %_NEWLINE 
'<blockquote>' %_NEWLINE '<p>quote</p>' %_NEWLINE '</blockquote>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method simple_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'header 1 | header 2' %_NEWLINE '-------- | --------' %_NEWLINE 
'cell 1.1 | cell 1.2' %_NEWLINE 'cell 2.1 | cell 2.2' %_NEWLINE %_NEWLINE '---' %_NEWLINE 
%_NEWLINE 'header 1 | header 2' %_NEWLINE ':------- | --------' %_NEWLINE 
'cell 1.1 | cell 1.2' %_NEWLINE 'cell 2.1 | cell 2.2' into lv_markdown respecting blanks .
    concatenate '<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE '<th>header 1</th>' 
%_NEWLINE '<th>header 2</th>' %_NEWLINE '</tr>' %_NEWLINE '</thead>' %_NEWLINE '<tbody>' 
%_NEWLINE '<tr>' %_NEWLINE '<td>cell 1.1</td>' %_NEWLINE '<td>cell 1.2</td>' %_NEWLINE 
'</tr>' %_NEWLINE '<tr>' %_NEWLINE '<td>cell 2.1</td>' %_NEWLINE '<td>cell 2.2</td>' 
%_NEWLINE '</tr>' %_NEWLINE '</tbody>' %_NEWLINE '</table>' %_NEWLINE '<hr />' %_NEWLINE 
'<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE 
'<th style="text-align: left;">header 1</th>' %_NEWLINE '<th>header 2</th>' %_NEWLINE 
'</tr>' %_NEWLINE '</thead>' %_NEWLINE '<tbody>' %_NEWLINE '<tr>' %_NEWLINE 
'<td style="text-align: left;">cell 1.1</td>' %_NEWLINE '<td>cell 1.2</td>' %_NEWLINE 
'</tr>' %_NEWLINE '<tr>' %_NEWLINE '<td style="text-align: left;">cell 2.1</td>' %_NEWLINE 
'<td>cell 2.2</td>' %_NEWLINE '</tr>' %_NEWLINE '</tbody>' %_NEWLINE '</table>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method span_level_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an <b>important</b> <a href=''''>link</a>' %_NEWLINE %_NEWLINE 'broken<br/>' 
%_NEWLINE 'line' %_NEWLINE %_NEWLINE '<b>inline tag</b> at the beginning' %_NEWLINE 
%_NEWLINE '<span>http://example.com</span>' into lv_markdown respecting blanks .
    concatenate '<p>an <b>important</b> <a href=''''>link</a></p>' %_NEWLINE '<p>broken<br/>' 
%_NEWLINE 'line</p>' %_NEWLINE '<p><b>inline tag</b> at the beginning</p>' %_NEWLINE 
'<p><span><a href="http://example.com">http://example.com</a></span></p>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method sparse_dense_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE %_NEWLINE '- li' %_NEWLINE '- li' into lv_markdown respecting 
blanks .
    concatenate '<ul>' %_NEWLINE '<li>' %_NEWLINE '<p>li</p>' %_NEWLINE '</li>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method sparse_html.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '<div>' %_NEWLINE 'line 1' %_NEWLINE %_NEWLINE 'line 2' %_NEWLINE 'line 3' 
%_NEWLINE %_NEWLINE 'line 4' %_NEWLINE '</div>' into lv_markdown respecting blanks .
    concatenate '<div>' %_NEWLINE 'line 1' %_NEWLINE %_NEWLINE 'line 2' %_NEWLINE 'line 3' 
%_NEWLINE %_NEWLINE 'line 4' %_NEWLINE '</div>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method sparse_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE %_NEWLINE '- li' %_NEWLINE %_NEWLINE '---' %_NEWLINE 
%_NEWLINE '- li' %_NEWLINE %_NEWLINE '    - indented li' into lv_markdown respecting 
blanks .
    concatenate '<ul>' %_NEWLINE '<li>' %_NEWLINE '<p>li</p>' %_NEWLINE '</li>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '</ul>' %_NEWLINE '<hr />' %_NEWLINE '<ul>' %_NEWLINE '<li>' 
%_NEWLINE '<p>li</p>' %_NEWLINE '<ul>' %_NEWLINE '<li>indented li</li>' %_NEWLINE '</ul>' 
%_NEWLINE '</li>' %_NEWLINE '</ul>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method special_characters.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'AT&T has an ampersand in their name' %_NEWLINE %_NEWLINE 'this & that' 
%_NEWLINE %_NEWLINE '4 < 5 and 6 > 5' %_NEWLINE %_NEWLINE 
'<http://example.com/autolink?a=1&b=2>' %_NEWLINE %_NEWLINE 
'[inline link](/script?a=1&b=2)' %_NEWLINE %_NEWLINE '[reference link][1]' %_NEWLINE 
%_NEWLINE '[1]: http://example.com/?a=1&b=2' into lv_markdown respecting blanks .
    concatenate '<p>AT&amp;T has an ampersand in their name</p>' %_NEWLINE 
'<p>this &amp; that</p>' %_NEWLINE '<p>4 &lt; 5 and 6 &gt; 5</p>' %_NEWLINE 
'<p><a href="http://example.com/autolink?a=1&amp;b=2">http://example.com/autolink?a=1&amp;b' 
'=2</a></p>' %_NEWLINE '<p><a href="/script?a=1&amp;b=2">inline link</a></p>' %_NEWLINE 
'<p><a href="http://example.com/?a=1&amp;b=2">reference link</a></p>' into 
lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method strikethrough.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '~~strikethrough~~' %_NEWLINE %_NEWLINE 
'here''s ~~one~~ followed by ~~another one~~' %_NEWLINE %_NEWLINE 
'~~ this ~~ is not one neither is ~this~' into lv_markdown respecting blanks .
    concatenate '<p><del>strikethrough</del></p>' %_NEWLINE 
'<p>here''s <del>one</del> followed by <del>another one</del></p>' %_NEWLINE 
'<p>~~ this ~~ is not one neither is ~this~</p>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method strong_em.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '*em **strong em***' %_NEWLINE %_NEWLINE '***strong em** em*' %_NEWLINE 
%_NEWLINE '*em **strong em** em*' %_NEWLINE %_NEWLINE '_em __strong em___' %_NEWLINE 
%_NEWLINE '___strong em__ em_' %_NEWLINE %_NEWLINE '_em __strong em__ em_' into 
lv_markdown respecting blanks .
    concatenate '<p><em>em <strong>strong em</strong></em></p>' %_NEWLINE 
'<p><em><strong>strong em</strong> em</em></p>' %_NEWLINE 
'<p><em>em <strong>strong em</strong> em</em></p>' %_NEWLINE 
'<p><em>em <strong>strong em</strong></em></p>' %_NEWLINE 
'<p><em><strong>strong em</strong> em</em></p>' %_NEWLINE 
'<p><em>em <strong>strong em</strong> em</em></p>' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method tab_indented_code_block.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '' %_HORIZONTAL_TAB '<?php' %_NEWLINE '' %_HORIZONTAL_TAB '' %_NEWLINE 
'' %_HORIZONTAL_TAB '$message = ''Hello World!'';' %_NEWLINE 
'' %_HORIZONTAL_TAB 'echo $message;' %_NEWLINE %_NEWLINE 
'' %_HORIZONTAL_TAB 'echo "following a blank line";' into lv_markdown respecting blanks .
    concatenate '<pre><code>&lt;?php' %_NEWLINE %_NEWLINE '$message = ''Hello World!'';' 
%_NEWLINE 'echo $message;' %_NEWLINE %_NEWLINE 
'echo "following a blank line";</code></pre>' into lv_expected_markup respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method table_inline_markdown.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| _header_ 1   | header 2     |' %_NEWLINE '| ------------ | ------------ |' 
%_NEWLINE '| _cell_ 1.1   | ~~cell~~ 1.2 |' %_NEWLINE '| `|` 2.1      | \| 2.2       |' 
%_NEWLINE '| `\|` 2.1     | [link](/)    |' into lv_markdown respecting blanks .
    concatenate '<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE 
'<th><em>header</em> 1</th>' %_NEWLINE '<th>header 2</th>' %_NEWLINE '</tr>' %_NEWLINE 
'</thead>' %_NEWLINE '<tbody>' %_NEWLINE '<tr>' %_NEWLINE '<td><em>cell</em> 1.1</td>' 
%_NEWLINE '<td><del>cell</del> 1.2</td>' %_NEWLINE '</tr>' %_NEWLINE '<tr>' %_NEWLINE 
'<td><code>|</code> 2.1</td>' %_NEWLINE '<td>| 2.2</td>' %_NEWLINE '</tr>' %_NEWLINE 
'<tr>' %_NEWLINE '<td><code>\|</code> 2.1</td>' %_NEWLINE '<td><a href="/">link</a></td>' 
%_NEWLINE '</tr>' %_NEWLINE '</tbody>' %_NEWLINE '</table>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method text_reference.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '[reference link][1]' %_NEWLINE %_NEWLINE '[1]: http://example.com' %_NEWLINE 
%_NEWLINE '[one][website] with a semantic name' %_NEWLINE %_NEWLINE 
'[website]: http://example.com' %_NEWLINE %_NEWLINE '[one][404] with no definition' 
%_NEWLINE %_NEWLINE '[multiline' %_NEWLINE 'one][website] defined on 2 lines' %_NEWLINE 
%_NEWLINE '[one][Label] with a mixed case label and an upper case definition' %_NEWLINE 
%_NEWLINE '[LABEL]: http://example.com' %_NEWLINE %_NEWLINE '[one]' %_NEWLINE 
'[1] with the a label on the next line' %_NEWLINE %_NEWLINE '[`link`][website]' into 
lv_markdown respecting blanks .
    concatenate '<p><a href="http://example.com">reference link</a></p>' %_NEWLINE 
'<p><a href="http://example.com">one</a> with a semantic name</p>' %_NEWLINE 
'<p>[one][404] with no definition</p>' %_NEWLINE 
'<p><a href="http://example.com">multiline' %_NEWLINE 'one</a> defined on 2 lines</p>' 
%_NEWLINE 
'<p><a href="http://example.com">one</a> with a mixed case label and an upper case definiti' 
'on</p>' %_NEWLINE 
'<p><a href="http://example.com">one</a> with the a label on the next line</p>' %_NEWLINE 
'<p><a href="http://example.com"><code>link</code></a></p>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method unordered_list.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '- li' %_NEWLINE '- li' %_NEWLINE %_NEWLINE 'mixed markers:' %_NEWLINE 
%_NEWLINE '* li' %_NEWLINE '+ li' %_NEWLINE '- li' into lv_markdown respecting blanks .
    concatenate '<ul>' %_NEWLINE '<li>li</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' 
%_NEWLINE '<p>mixed markers:</p>' %_NEWLINE '<ul>' %_NEWLINE '<li>li</li>' %_NEWLINE 
'<li>li</li>' %_NEWLINE '<li>li</li>' %_NEWLINE '</ul>' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method untidy_table.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '| header 1 | header 2          |' %_NEWLINE '| ------------- | ----------- |' 
%_NEWLINE '| cell 1.1   | cell 1.2 |' %_NEWLINE '|    cell 2.1 | cell 2.2     |' into 
lv_markdown respecting blanks .
    concatenate '<table>' %_NEWLINE '<thead>' %_NEWLINE '<tr>' %_NEWLINE '<th>header 1</th>' 
%_NEWLINE '<th>header 2</th>' %_NEWLINE '</tr>' %_NEWLINE '</thead>' %_NEWLINE '<tbody>' 
%_NEWLINE '<tr>' %_NEWLINE '<td>cell 1.1</td>' %_NEWLINE '<td>cell 1.2</td>' %_NEWLINE 
'</tr>' %_NEWLINE '<tr>' %_NEWLINE '<td>cell 2.1</td>' %_NEWLINE '<td>cell 2.2</td>' 
%_NEWLINE '</tr>' %_NEWLINE '</tbody>' %_NEWLINE '</table>' into lv_expected_markup 
respecting blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method url_autolinking.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate 'an autolink http://example.com' %_NEWLINE %_NEWLINE 
'inside of brackets [http://example.com], inside of braces {http://example.com},  inside of' 
' parentheses (http://example.com)' %_NEWLINE %_NEWLINE 
'trailing slash http://example.com/ and http://example.com/path/' into lv_markdown 
respecting blanks .
    concatenate '<p>an autolink <a href="http://example.com">http://example.com</a></p>' 
%_NEWLINE 
'<p>inside of brackets [<a href="http://example.com">http://example.com</a>], inside of bra' 
'ces {<a href="http://example.com">http://example.com</a>},  inside of parentheses (<a href' 
'="http://example.com">http://example.com</a>)</p>' %_NEWLINE 
'<p>trailing slash <a href="http://example.com/">http://example.com/</a> and <a href="http:' 
'//example.com/path/">http://example.com/path/</a></p>' into lv_expected_markup respecting 
blanks .
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.

  method whitespace.
    data: lv_markdown type string,
          lv_expected_markup type string,
          lv_actual_markup type string.
    concatenate '    ' %_NEWLINE %_NEWLINE '    code' %_NEWLINE %_NEWLINE '    ' into 
lv_markdown respecting blanks .
    lv_expected_markup = '<pre><code>code</code></pre>'.
    lv_actual_markup = me->markdown->text( lv_markdown ).
    cl_aunit_assert=>assert_equals(
      act = lv_actual_markup
      exp = lv_expected_markup
    ).
  endmethod.
endclass.                    "markdown_tests IMPLEMENTATION
