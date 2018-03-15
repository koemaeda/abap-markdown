class ZMARKDOWN definition
  public
  create public .

public section.

  constants VERSION type STRING value '1.1.0' ##NO_TEXT.

  methods TEXT
    importing
      value(TEXT) type CLIKE
    returning
      value(MARKUP) type STRING .
  methods SET_BREAKS_ENABLED
    importing
      value(BREAKS_ENABLED) type CLIKE
    returning
      value(THIS) type ref to ZMARKDOWN .
  methods SET_MARKUP_ESCAPED
    importing
      value(MARKUP_ESCAPED) type CLIKE
    returning
      value(THIS) type ref to ZMARKDOWN .
  methods SET_URLS_LINKED
    importing
      value(URLS_LINKED) type CLIKE
    returning
      value(THIS) type ref to ZMARKDOWN .
  methods SET_SAFE_MODE
    importing
      !SAFE_MODE type CLIKE
    returning
      value(THIS) type ref to ZMARKDOWN .
  methods CONSTRUCTOR .
protected section.
private section.

  types:
    begin of ty_element_attribute,
      name type string,
      value type string,
    end of ty_element_attribute .
  types:
    ty_t_element_attribute type standard table of ty_element_attribute with key name .
  types:
    begin of ty_element0,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type string,
      lines type standard table of string with default key,
    end of ty_element0 .
  types:
    ty_t_element0 type standard table of ty_element0 with default key .
  types:
    begin of ty_element1,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type string,
      texts type ty_t_element0,
      lines type standard table of string with default key,
    end of ty_element1 .
  types:
    ty_t_element1 type standard table of ty_element1 with default key .
  types:
    begin of ty_element2,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type string,
      texts type ty_t_element1,
      lines type standard table of string with default key,
    end of ty_element2 .
  types:
    ty_t_element2 type standard table of ty_element2 with default key .
  types:
    begin of ty_element3,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type string,
      texts type ty_t_element2,
      lines type standard table of string with default key,
    end of ty_element3 .
  types:
    ty_t_element3 type standard table of ty_element3 with default key .
  types:
    begin of ty_element4,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type string,
      texts type ty_t_element3,
      lines type standard table of string with default key,
    end of ty_element4 .
  types:
    ty_t_element4 type standard table of ty_element4 with default key .
  types:
    begin of ty_element5,
      name type string,
      handler type string,
      attributes type ty_t_element_attribute,
      text type ty_element4,
      texts type ty_t_element4,
      lines type standard table of string with default key,
    end of ty_element5 .
  types:
    ty_t_element5 type standard table of ty_element5 with default key .
  types TY_ELEMENT type TY_ELEMENT5 .
  types:
    ty_t_element type standard table of ty_element with default key .
  types:
    begin of ty_block,
      "// general block fields
      continuable type abap_bool,
      identified type abap_bool,
      interrupted type abap_bool,
      hidden type abap_bool,
      closed type abap_bool,
      type type string,
      markup type string,
      element type ty_element,
      "// specific block fields
      char type c length 1,
      complete type abap_bool,
      indent type i,
      pattern type string,
      li type ty_element4,
      loose type abap_bool,
      name type string,
      depth type i,
      void type abap_bool,
      alignments type standard table of string with default key,
    end of ty_block .
  types:
    begin of ty_line,
      body type string,
      indent type i,
      text type string,
    end of ty_line .
  types:
    begin of ty_excerpt,
      text type string,
      context type string,
    end of ty_excerpt .
  types:
    begin of ty_inline,
      position type i,
      markup type string,
      extent type string,
      element type ty_element,
    end of ty_inline .

  data BREAKS_ENABLED type ABAP_BOOL .
  data MARKUP_ESCAPED type ABAP_BOOL .
  data URLS_LINKED type ABAP_BOOL value ABAP_TRUE ##NO_TEXT.
  data SAFE_MODE type ABAP_BOOL .
  data BLOCK_TYPES type ref to LCL_HASHMAP .
  data UNMARKED_BLOCK_TYPES type ref to LCL_STRING_ARRAY .
  data INLINE_TYPES type ref to LCL_HASHMAP .
  data INLINE_MARKER_LIST type STRING value '!"*_&[:<>`~\\' ##NO_TEXT.
  data DEFINITION_DATA type ref to LCL_HASHMAP .
  data SPECIAL_CHARACTERS type ref to LCL_STRING_ARRAY .
  data STRONG_REGEX type ref to LCL_HASHMAP .
  data EM_REGEX type ref to LCL_HASHMAP .
  data REGEX_HTML_ATTRIBUTE type STRING value '[a-zA-Z_:][\w:.-]*(?:\s*=\s*(?:[^"''=<>`\s]+|"[^"]*"|''[^'']*''))?' ##NO_TEXT.
  data VOID_ELEMENTS type ref to LCL_STRING_ARRAY .
  data TEXT_LEVEL_ELEMENTS type ref to LCL_STRING_ARRAY .
  data SAFE_LINKS_WHITELIST type ref to LCL_STRING_ARRAY .
  data:
    methods type standard table of string .

  class-methods HTMLSPECIALCHARS
    importing
      !INPUT type STRING
      !ENT_HTML401 type ABAP_BOOL default ABAP_TRUE
      !ENT_NOQUOTES type ABAP_BOOL optional
      !ENT_QUOTES type ABAP_BOOL optional
    returning
      value(OUTPUT) type STRING .
  class-methods TRIM
    importing
      !STR type STRING
      value(MASK) type STRING default ' \t\n\r'
    returning
      value(R_STR) type STRING .
  class-methods CHOP
    importing
      !STR type STRING
      value(MASK) type STRING default ' \t\n\r'
    returning
      value(R_STR) type STRING .
  class-methods MAGIC_MOVE
    importing
      !FROM type ANY
      !NAME type CLIKE optional
    changing
      !TO type ANY .
  class-methods MATCH_MARKED_STRING
    importing
      value(MARKER) type STRING
      !SUBJECT type STRING
    exporting
      value(M0) type STRING
      value(M1) type STRING
    exceptions
      NOT_FOUND .
  class-methods _ESCAPE
    importing
      !TEXT type STRING
      !ALLOW_QUOTES type ABAP_BOOL optional
    returning
      value(OUTPUT) type STRING .
  class-methods STRI_AT_START
    importing
      !HAYSTACK type STRING
      !NEEDLE type STRING
    returning
      value(RESULT) type ABAP_BOOL .
  methods _LINES
    importing
      !LINES type STANDARD TABLE
    returning
      value(MARKUP) type STRING .
  methods BLOCK_CODE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_CODE_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_CODE_COMPLETE
    importing
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_COMMENT
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_COMMENT_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_FENCEDCODE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_FENCEDCODE_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_FENCEDCODE_COMPLETE
    importing
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_HEADER
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_LIST
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_LIST_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_LIST_COMPLETE
    importing
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_QUOTE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_QUOTE_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_RULE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_SETEXTHEADER
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_MARKUP
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_MARKUP_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_REFERENCE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_TABLE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK optional
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods BLOCK_TABLE_CONTINUE
    importing
      !LINE type TY_LINE
      !BLOCK type TY_BLOCK
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods PARAGRAPH
    importing
      !LINE type TY_LINE
    returning
      value(R_BLOCK) type TY_BLOCK .
  methods LINE
    importing
      !ELEMENT type TY_ELEMENT4
    returning
      value(MARKUP) type STRING .
  methods INLINE_CODE
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_EMAILTAG
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_EMPHASIS
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_ESCAPESEQUENCE
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_IMAGE
    importing
      value(EXCERPT) type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_LINK
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_MARKUP
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_SPECIALCHARACTER
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_STRIKETHROUGH
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_URL
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods INLINE_URLTAG
    importing
      !EXCERPT type TY_EXCERPT
    returning
      value(R_INLINE) type TY_INLINE .
  methods UNMARKED_TEXT
    importing
      !TEXT type STRING
    returning
      value(R_TEXT) type STRING .
  methods ELEMENT
    importing
      !ELEMENT type ANY
    returning
      value(MARKUP) type STRING .
  methods ELEMENTS
    importing
      !ELEMENTS type STANDARD TABLE
    returning
      value(MARKUP) type STRING .
  methods LI
    importing
      !LINES type STANDARD TABLE
    returning
      value(MARKUP) type STRING .
  methods FILTER_UNSAFE_URL_IN_ATTRIBUTE
    importing
      !ELEMENT type TY_ELEMENT
      !ATTRIBUTE type STRING
    returning
      value(R_ELEMENT) type TY_ELEMENT .
  methods SANITISE_ELEMENT
    importing
      !ELEMENT type TY_ELEMENT
    returning
      value(R_ELEMENT) type TY_ELEMENT .
ENDCLASS.



CLASS ZMARKDOWN IMPLEMENTATION.


method block_code.
    if block is not initial and
       block-type is initial and
       block-interrupted is initial.
      return.
    endif.

    if line-indent >= 4.
      r_block-element-name = 'pre'.
      r_block-element-handler = 'element'.
      r_block-element-text-name = 'code'.
      r_block-element-text-text = line-body+4.
    endif.
  endmethod.                    "block_code


method block_code_complete.
    r_block = block.
    r_block-element-text-text = r_block-element-text-text.
  endmethod.                    "block_code_complete


method block_code_continue.
    data: lv_text type string.

    if line-indent >= 4.
      r_block = block.

      if block-interrupted is not initial.
        concatenate r_block-element-text-text %_newline
          into r_block-element-text-text respecting blanks.
        clear r_block-interrupted.
      endif.

      lv_text = line-body+4.
      concatenate r_block-element-text-text %_newline lv_text
        into r_block-element-text-text respecting blanks.
    endif.
  endmethod.                    "block_code_continue


method block_comment.
    check me->markup_escaped is initial.

    if strlen( line-text ) >= 3 and
       line-text+3(1) = '-' and
       line-text+2(1) = '-' and
       line-text+1(1) = '!'.
      r_block-markup = line-body.

      find regex '-->$' in line-text.
      if sy-subrc = 0.
        r_block-closed = abap_true.
      endif.
    endif.
  endmethod.                    "block_Comment


method block_comment_continue.
    check block-closed is initial.
    r_block = block.

    concatenate r_block-markup %_newline line-body into r_block-markup.

    find regex '-->$' in line-text.
    if sy-subrc = 0.
      r_block-closed = abap_true.
    endif.
  endmethod.                    "block_Comment_Continue


method block_fencedcode.
    data(lv_regex) = '^[' && line-text(1) && ']{3,}[ ]*([^`]+)?[ ]*$'.
    find regex lv_regex in line-text submatches data(lv_m1).
    if sy-subrc = 0.
      if lv_m1 is not initial.
        append initial line to r_block-element-text-attributes assigning field-symbol(<attribute>).
        <attribute>-name = 'class'.
        concatenate 'language-' lv_m1 into <attribute>-value.
      endif.

      r_block-char = line-text(1).
      r_block-element-name = 'pre'.
      r_block-element-handler = 'element'.
      r_block-element-text-name = 'code'.
    endif.
  endmethod.                    "block_Fenced_Code


method block_fencedcode_complete.
    r_block = block.
    r_block-element-text-text = r_block-element-text-text.
  endmethod.                    "block_Fenced_Code_Complete


method block_fencedcode_continue.
    data: lv_regex type string.

    check block-complete is initial.
    r_block = block.

    if r_block-interrupted is not initial.
      concatenate r_block-element-text-text %_newline into r_block-element-text-text.
      clear r_block-interrupted.
    endif.

    concatenate '^' block-char '{3,}[ ]*$' into lv_regex.
    find regex lv_regex in line-text.
    if sy-subrc = 0.
      r_block-element-text-text = r_block-element-text-text+1.
      r_block-complete = abap_true.
      return.
    endif.

    concatenate
      r_block-element-text-text %_newline line-body
      into r_block-element-text-text.
  endmethod.                    "block_Fenced_Code_Continue


method block_header.
    check strlen( line-text ) > 1 and line-text+1(1) is not initial.

    data: lv_level type i value 1,
          lv_h_level type n.

    while ( lv_level < strlen( line-text ) and
            line-text+lv_level(1) = '#' ).
      add 1 to lv_level.
    endwhile.

    check not lv_level > 6.
    lv_h_level = lv_level.
    concatenate 'h' lv_h_level into r_block-element-name.
    r_block-element-text-text = line-text.
    r_block-element-text-text = trim( str = r_block-element-text-text mask = ' #' ).
    condense r_block-element-text-text.
    r_block-element-handler = 'line'.
  endmethod.                    "block_Header


method block_list.
  data: lv_name    type string,
        lv_pattern type string.

  if line-text(1) <= '-'.
    lv_name = 'ul'.
    lv_pattern = '[*+-]'.
  else.
    lv_name = 'ol'.
    lv_pattern = '[0-9]+[.]'.
  endif.

  data(lv_regex) = '^(' && lv_pattern && '[ ]+)(.*)'.
  find regex lv_regex in line-text submatches data(lv_m1) data(lv_m2).
  if sy-subrc = 0.
    r_block-indent = line-indent.
    r_block-pattern = lv_pattern.
    r_block-element-name = lv_name.
    r_block-element-handler = 'elements'.

    if r_block-element-name = 'ol'.
      data(lv_list_start) = substring_before( val = line-text sub = '.' case = abap_false ).
      if lv_list_start <> '1'.
        append initial line to r_block-element-attributes assigning field-symbol(<attribute>).
        <attribute>-name = 'start'.
        <attribute>-value = lv_list_start.
      endif.
    endif.

    r_block-li-name = 'li'.
    r_block-li-handler = 'li'.
    append lv_m2 to r_block-li-lines.
  endif.
endmethod.                    "block_List


method block_list_complete.
    r_block = block.

    append r_block-li to r_block-element-texts.

    if r_block-loose is not initial.
      loop at r_block-element-texts assigning field-symbol(<li>).
        assign <li>-lines[ lines( r_block-li-lines ) ] to field-symbol(<last_line>).
        if sy-subrc = 0 and <last_line> is not initial.
          append initial line to <li>-lines.
        endif.
      endloop.
    endif.
  endmethod.                    "block_List_complete


method block_list_continue.
    r_block = block.

    data(lv_regex) = '^' && block-pattern && '(?:[ ]+(.*)|$)'.
    if block-indent = line-indent.
      find regex lv_regex in line-text submatches data(lv_m1).
      if sy-subrc = 0.
        if r_block-interrupted is not initial.
          append initial line to r_block-li-lines.
          r_block-loose = abap_true.
          clear r_block-interrupted.
        endif.
        append r_block-li to r_block-element-texts.

        clear r_block-li.
        r_block-li-name = 'li'.
        r_block-li-handler = 'li'.
        append lv_m1 to r_block-li-lines.
        return.
      endif.
    endif.

    if line-text(1) = '['.
      data(ls_block) = block_reference( line ).
      if ls_block is not initial.
        return.
      endif.
    endif.

    if r_block-interrupted is initial.
      data(lv_text) = line-body.
      replace all occurrences of regex '^[ ]{0,4}' in lv_text with ''.
      append lv_text to r_block-li-lines.
      return.
    endif.

    if line-indent > 0.
      append initial line to r_block-li-lines.
      lv_text = line-body.
      replace all occurrences of regex '^[ ]{0,4}' in lv_text with ''.
      append lv_text to r_block-li-lines.
      clear r_block-interrupted.
      return.
    endif.

    clear r_block.
  endmethod.                    "block_List_Continue


method block_markup.
    check: me->markup_escaped is initial,
           me->safe_mode is initial.

    data(lv_regex) = '^<(\w*)(?:[ ]*' && me->regex_html_attribute && ')*[ ]*(/)?>'.
    find first occurrence of regex lv_regex in line-text submatches data(lv_m1) data(lv_m2)
      match length data(lv_length).
    if sy-subrc = 0.

      data(lv_index) = me->text_level_elements->find( lv_m1 ).
      check lv_index = 0.

      r_block-name = lv_m1.
      r_block-depth = 0.
      r_block-markup = line-text.

      data(lv_remainder) = line-text+lv_length.
      data(lv_remainder_trimmed) = trim( lv_remainder ).

      lv_index = me->void_elements->find( lv_m1 ).

      if lv_remainder_trimmed is initial.
        if lv_m2 is not initial or lv_index <> 0.
          r_block-closed = abap_true.
          r_block-void = abap_true.
        endif.
      else.
        if lv_m2 is not initial or lv_index <> 0.
          clear r_block.
          return.
        endif.

        concatenate '</' lv_m1 '>[ ]*$' into lv_regex.
        find first occurrence of regex lv_regex in lv_remainder ignoring case.
        if sy-subrc = 0.
          r_block-closed = abap_true.
        endif.
      endif.

    endif. "regex sy-subrc = 0
  endmethod.                    "block_Markup


method block_markup_continue.
    data: lv_regex type string.

    check block-closed is initial.
    r_block = block.

    concatenate '^<' r_block-name '(?:[ ]*' me->regex_html_attribute ')*[ ]*>' into lv_regex.
    find regex lv_regex in line-text ignoring case. "open
    if sy-subrc = 0.
      add 1 to r_block-depth.
    endif.

    concatenate '</' r_block-name '>[ ]*$' into lv_regex.
    find regex lv_regex in line-text ignoring case. "close
    if sy-subrc = 0.
      if r_block-depth > 0.
        subtract 1 from r_block-depth.
      else.
        r_block-closed = abap_true.
      endif.
    endif.

    if r_block-interrupted is not initial.
      concatenate r_block-markup %_newline into r_block-markup.
      clear r_block-interrupted.
    endif.

    concatenate r_block-markup %_newline line-body into r_block-markup.
  endmethod.                    "block_Markup_Continue


method block_quote.
    find regex '^>[ ]?(.*)' in line-text submatches data(lv_m1).
    if sy-subrc = 0.
      shift lv_m1 left deleting leading space.
      r_block-element-name = 'blockquote'.
      r_block-element-handler = '_lines'.
      append lv_m1 to r_block-element-lines.
    endif.
  endmethod.                    "block_Quote


method block_quote_continue.
    data: lv_m1 type string.

    if line-text(1) = '>'.
      r_block = block.
      find regex '^>[ ]?(.*)' in line-text submatches lv_m1.
      if sy-subrc = 0.
        shift lv_m1 left deleting leading space.
        if r_block-interrupted is not initial.
          append initial line to r_block-element-lines.
          clear r_block-interrupted.
        endif.

        append lv_m1 to r_block-element-lines.
        return.
      endif.
    endif.

    if block-interrupted is initial.
      r_block = block.
      append line-text to r_block-element-lines.
    endif.
  endmethod.                    "block_Quote_Continue


method block_reference.
    data: lv_m1 type string,
          lv_m2 type string,
          lv_m3 type string,
          lv_m4 type string,
          lv_id type string,
          lo_ref_map type ref to lcl_hashmap,
          lo_ref_item type ref to lcl_hashmap,
          lo_ref_val type ref to lcl_string.

    find regex '^\[(.+)\]:[ ]*<?(\S+)>?([ ]+["''(](.+)["'')])?[ ]*$'
      in line-text submatches lv_m1 lv_m2 lv_m3 lv_m4.
    if sy-subrc = 0.
      lv_id = lv_m1. translate lv_id to lower case.

      lo_ref_map ?= me->definition_data->get( 'Reference' ).
      lo_ref_item ?= lo_ref_map->get( lv_id ).

      lo_ref_val ?= lo_ref_item->get( 'url' ). lo_ref_val->data = lv_m2.
      if lv_m3 is not initial.
        lo_ref_val ?= lo_ref_item->get( 'title' ). lo_ref_val->data = lv_m4.
      endif.

      r_block-hidden = abap_true.
    endif.
  endmethod.                    "block_Reference


method block_rule.
    data: lv_regex type string.

    concatenate '^([' line-text(1) '])([ ]*\1){2,}[ ]*$' into lv_regex.
    find regex lv_regex in line-text.
    if sy-subrc = 0.
      r_block-element-name = 'hr'.
    endif.
  endmethod.                    "block_Rule


method block_setextheader.
    check block is not initial and block-type is initial and
          block-interrupted is initial.

    if line-text co line-text(1).
      r_block = block.
      if line-text(1) = '='.
        r_block-element-name = 'h1'.
      else.
        r_block-element-name = 'h2'.
      endif.
    endif.
  endmethod.                    "block_SetextHeader


method block_table.
    data: lv_divider type string,
          lt_divider_cells type table of string,
          lv_len type i.
    field-symbols: <divider_cell> like line of lt_divider_cells,
                   <alignment> like line of r_block-alignments.

    check not ( block is initial or
                block-type is not initial or
                block-interrupted is not initial ).

    find '|' in block-element-text-text.
    if sy-subrc = 0 and line-text co ' -:|'.
      r_block = block.

      lv_divider = trim( line-text ).
      lv_divider = trim( str = lv_divider  mask = '|' ).

      split lv_divider at '|' into table lt_divider_cells.
      loop at lt_divider_cells assigning <divider_cell>.
        <divider_cell> = trim( <divider_cell> ).
        check <divider_cell> is not initial.
        append initial line to r_block-alignments assigning <alignment>.

        if <divider_cell>(1) = ':'.
          <alignment> = 'left'.
        endif.

        lv_len = strlen( <divider_cell> ) - 1.
        if <divider_cell>+lv_len(1) = ':'.
          if <alignment> = 'left'.
            <alignment> = 'center'.
          else.
            <alignment> = 'right'.
          endif.
        endif.
      endloop. "lt_divider_cells

      "# ~

      data: lv_header type string,
            lt_header_cells type table of string,
            lv_index type i,
            lt_header_elements type ty_t_element2.
      field-symbols: <header_cell> like line of lt_header_cells,
                     <header_element> like line of lt_header_elements,
                     <attribute> like line of <header_element>-attributes.

      lv_header = trim( r_block-element-text-text ).
      lv_header = trim( str = lv_header  mask = '|' ).

      split lv_header at '|' into table lt_header_cells.
      loop at lt_header_cells assigning <header_cell>.
        lv_index = sy-tabix.
        <header_cell> = trim( <header_cell> ).

        append initial line to lt_header_elements assigning <header_element>.
        <header_element>-name = 'th'.
        <header_element>-text = <header_cell>.
        <header_element>-handler = 'line'.

        read table r_block-alignments assigning <alignment> index lv_index.
        if sy-subrc = 0 and <alignment> is not initial.
          append initial line to <header_element>-attributes assigning <attribute>.
          <attribute>-name = 'style'.
          concatenate 'text-align: ' <alignment> ';'
            into <attribute>-value respecting blanks.
        endif.
      endloop.

      "# ~

      field-symbols: <element_text1> like line of r_block-element-texts,
                     <element_text2> like line of <element_text1>-texts.

      r_block-identified = abap_true.
      r_block-element-name = 'table'.
      r_block-element-handler = 'elements'.

      append initial line to r_block-element-texts assigning <element_text1>.
      <element_text1>-name = 'thead'.
      <element_text1>-handler = 'elements'.
      append initial line to <element_text1>-texts assigning <element_text2>.
      <element_text2>-name = 'tr'.
      <element_text2>-handler = 'elements'.
      <element_text2>-texts = lt_header_elements.

      append initial line to r_block-element-texts assigning <element_text1>.
      <element_text1>-name = 'tbody'.
      <element_text1>-handler = 'elements'.
    endif. "sy-subrc = 0 and line-text na ' -:|'.
  endmethod.                    "block_Table


method block_table_continue.
    data: lv_row type string,
          lt_matches type match_result_tab,
          lv_index type i,
          lv_cell type string.
    field-symbols: <match> like line of lt_matches,
                   <text1> like line of r_block-element-texts,
                   <text2> like line of <text1>-texts,
                   <text3> like line of <text2>-texts,
                   <alignment> like line of r_block-alignments,
                   <attribute> like line of <text3>-attributes.

    check block-interrupted is initial.

    if line-text cs '|'.
      r_block = block.

      lv_row = trim( line-text ).
      lv_row = trim( str = lv_row mask = '|' ).

      read table r_block-element-texts assigning <text1> index 2.
      check sy-subrc = 0.

      append initial line to <text1>-texts assigning <text2>.
      <text2>-name = 'tr'.
      <text2>-handler = 'elements'.

      find all occurrences of regex '(?:(\\[|])|[^|`]|`[^`]+`|`)+'
        in lv_row results lt_matches.
      loop at lt_matches assigning <match>.
        lv_index = sy-tabix.
        lv_cell = lv_row+<match>-offset(<match>-length).
        lv_cell = trim( lv_cell ).

        append initial line to <text2>-texts assigning <text3>.
        <text3>-name = 'td'.
        <text3>-handler = 'line'.
        <text3>-text = lv_cell.

        read table r_block-alignments assigning <alignment> index lv_index.
        if sy-subrc = 0 and <alignment> is not initial.
          append initial line to <text3>-attributes assigning <attribute>.
          <attribute>-name = 'style'.
          concatenate 'text-align: ' <alignment> ';'
            into <attribute>-value respecting blanks.
        endif.
      endloop. "lt_matches
    endif. "line-text cs '|'
  endmethod.                    "block_Table_Continue


method chop.
    data: lv_regex type string.

    r_str = str.
    replace all occurrences of regex '([\.\?\*\+\|])' in mask with '\\$1'.
    concatenate '[' mask ']*\Z' into lv_regex.
    replace all occurrences of regex lv_regex in r_str with ''.
  endmethod.                    "trim


method constructor.
    "! Constuctor method
    "! Initializes the instance constants

    "#
    "# Lines
    "#
    create object block_types
      exporting
        value_type = 'lcl_string_array'.
    data: lo_sa type ref to lcl_string_array.
    lo_sa ?= block_types->new( '#' ). lo_sa->append( 'Header' ).
    lo_sa ?= block_types->new( '*' ). lo_sa->append( 'Rule' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '+' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '-' ). lo_sa->append( 'SetextHeader' ).
    lo_sa->append( 'Table' ). lo_sa->append( 'Rule' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '0' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '1' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '2' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '3' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '4' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '5' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '6' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '7' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '8' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( '9' ). lo_sa->append( 'List' ).
    lo_sa ?= block_types->new( ':' ). lo_sa->append( 'Table' ).
    lo_sa ?= block_types->new( '<' ). lo_sa->append( 'Comment' ). lo_sa->append( 'Markup' ).
    lo_sa ?= block_types->new( '=' ). lo_sa->append( 'SetextHeader' ).
    lo_sa ?= block_types->new( '>' ). lo_sa->append( 'Quote' ).
    lo_sa ?= block_types->new( '[' ). lo_sa->append( 'Reference' ).
    lo_sa ?= block_types->new( '_' ). lo_sa->append( 'Rule' ).
    lo_sa ?= block_types->new( '`' ). lo_sa->append( 'FencedCode' ).
    lo_sa ?= block_types->new( '|' ). lo_sa->append( 'Table' ).
    lo_sa ?= block_types->new( '~' ). lo_sa->append( 'FencedCode' ).

    create object unmarked_block_types.
    unmarked_block_types->append( 'Code' ).

    "#
    "# Inline Elements
    "#
    create object inline_types
      exporting
        value_type = 'lcl_string_array'.
    lo_sa ?= inline_types->new( '"' ). lo_sa->append( 'SpecialCharacter' ).
    lo_sa ?= inline_types->new( '!' ). lo_sa->append( 'Image' ).
    lo_sa ?= inline_types->new( '&' ). lo_sa->append( 'SpecialCharacter' ).
    lo_sa ?= inline_types->new( '*' ). lo_sa->append( 'Emphasis' ).
    lo_sa ?= inline_types->new( ':' ). lo_sa->append( 'Url' ).
    lo_sa ?= inline_types->new( '<' ). lo_sa->append( 'UrlTag' ). lo_sa->append( 'EmailTag' ).
    lo_sa->append( 'Markup' ). lo_sa->append( 'SpecialCharacter' ).
    lo_sa ?= inline_types->new( '>' ). lo_sa->append( 'SpecialCharacter' ).
    lo_sa ?= inline_types->new( '[' ). lo_sa->append( 'Link' ).
    lo_sa ?= inline_types->new( '_' ). lo_sa->append( 'Emphasis' ).
    lo_sa ?= inline_types->new( '`' ). lo_sa->append( 'Code' ).
    lo_sa ?= inline_types->new( '~' ). lo_sa->append( 'Strikethrough' ).
    lo_sa ?= inline_types->new( '\' ). lo_sa->append( 'EscapeSequence' ).

    "#
    "# Read-Only
    "#
    create object special_characters. lo_sa = special_characters.
    lo_sa->append( '\' ). lo_sa->append( '`' ). lo_sa->append( '*' ).
    lo_sa->append( '_' ). lo_sa->append( '{' ). lo_sa->append( '}' ).
    lo_sa->append( '[' ). lo_sa->append( ']' ). lo_sa->append( '(' ).
    lo_sa->append( ')' ). lo_sa->append( '>' ). lo_sa->append( '#' ).
    lo_sa->append( '+' ). lo_sa->append( '-' ). lo_sa->append( '.' ).
    lo_sa->append( '!' ). lo_sa->append( '|' ).

    data: lo_string type ref to lcl_string.
    create object strong_regex.
    lo_string ?= strong_regex->new( '*' ).
    lo_string->data = '(^[*][*]((?:\\[*]|[^*]|[*][^*]*[*])+)[*][*](?![*]))'.
    lo_string ?= strong_regex->new( '_' ).
    lo_string->data = '(^__((?:\\_|[^_]|_[^_]*_)+)__(?!_))'.

    create object em_regex.
    lo_string ?= em_regex->new( '*' ).
    lo_string->data = '(^[*]((?:\\[*]|[^*]|[*][*][^*]+[*][*])+)[*](?![*]))'.
    lo_string ?= em_regex->new( '_' ).
    lo_string->data = '(^_((?:\\_|[^_]|__[^_]*__)+)_(?!_)\b)'.

    regex_html_attribute = '[a-zA-Z_:][\w:.-]*(?:\s*=\s*(?:[^"''=<>`\s]+|"[^"]*"|''[^'']*''))?'.

    create object void_elements. lo_sa = void_elements.
    lo_sa->append( 'area' ). lo_sa->append( 'base' ). lo_sa->append( 'br' ).
    lo_sa->append( 'col' ). lo_sa->append( 'command' ). lo_sa->append( 'embed' ).
    lo_sa->append( 'hr' ). lo_sa->append( 'img' ). lo_sa->append( 'input' ).
    lo_sa->append( 'link' ). lo_sa->append( 'meta' ). lo_sa->append( 'param' ).
    lo_sa->append( 'source' ).

    create object text_level_elements. lo_sa = text_level_elements.
    lo_sa->append( 'a' ).  lo_sa->append( 'b' ).  lo_sa->append( 'i' ).  lo_sa->append( 'q' ).
    lo_sa->append( 's' ).  lo_sa->append( 'u' ).
    lo_sa->append( 'br' ).  lo_sa->append( 'em' ).  lo_sa->append( 'rp' ).  lo_sa->append( 'rt' ).
    lo_sa->append( 'tt' ).  lo_sa->append( 'xm' ).
    lo_sa->append( 'bdo' ).  lo_sa->append( 'big' ).  lo_sa->append( 'del' ).  lo_sa->append( 'ins' ).
    lo_sa->append( 'sub' ).  lo_sa->append( 'sup' ).  lo_sa->append( 'var' ).  lo_sa->append( 'wbr' ).
    lo_sa->append( 'abbr' ).  lo_sa->append( 'cite' ).  lo_sa->append( 'code' ).
    lo_sa->append( 'font' ).  lo_sa->append( 'mark' ).  lo_sa->append( 'nobr' ).
    lo_sa->append( 'ruby' ).  lo_sa->append( 'span' ).  lo_sa->append( 'time' ).
    lo_sa->append( 'blink' ).  lo_sa->append( 'small' ).
    lo_sa->append( 'nextid' ).  lo_sa->append( 'spacer' ).  lo_sa->append( 'strike' ).
    lo_sa->append( 'strong' ).
    lo_sa->append( 'acronym' ).  lo_sa->append( 'listing' ).  lo_sa->append( 'marquee' ).
    lo_sa->append( 'basefont' ).

    create object safe_links_whitelist. lo_sa = safe_links_whitelist.
    lo_sa->append( 'http://' ).
    lo_sa->append( 'https://' ).
    lo_sa->append( 'ftp://' ).
    lo_sa->append( 'ftps://' ).
    lo_sa->append( 'mailto:' ).
    lo_sa->append( 'data:image/png;base64,' ).
    lo_sa->append( 'data:image/gif;base64,' ).
    lo_sa->append( 'data:image/jpeg;base64,' ).
    lo_sa->append( 'irc:' ).
    lo_sa->append( 'ircs:' ).
    lo_sa->append( 'git:' ).
    lo_sa->append( 'ssh:' ).
    lo_sa->append( 'news:' ).
    lo_sa->append( 'steam:' ).

    "// Method names
    data: lo_objdescr type ref to cl_abap_objectdescr.
    field-symbols: <method> like line of lo_objdescr->methods.
    lo_objdescr ?= cl_abap_objectdescr=>describe_by_object_ref( me ).
    loop at lo_objdescr->methods assigning <method>.
      append <method>-name to me->methods.
    endloop.
  endmethod.                    "constructor


method element.
  data: ls_element     type ty_element,
        lv_method_name type string,
        lv_content     type string.

  magic_move( exporting from = element changing to = ls_element ).

  if safe_mode is not initial.
    ls_element = sanitise_element( ls_element ).
  endif.

  assign component 'TEXT' of structure ls_element to field-symbol(<text>).

  markup = |<{ ls_element-name }|.

  if ls_element-attributes is not initial.
    loop at ls_element-attributes assigning field-symbol(<attribute>).
      markup = |{ markup } { <attribute>-name }="{ _escape( <attribute>-value ) }"|.
    endloop.
  endif.

  if <text> is not initial or ls_element-texts is not initial or ls_element-lines is not initial.
    markup = |{ markup }>|.

    if ls_element-handler is not initial.
      lv_method_name = ls_element-handler.
      translate lv_method_name to upper case.

      if ls_element-texts is not initial. "// for array of elements
        call method (lv_method_name)
          exporting
            elements = ls_element-texts
          receiving
            markup   = lv_content.
      elseif ls_element-lines is not initial. "// for array of lines
        call method (lv_method_name)
          exporting
            lines  = ls_element-lines
          receiving
            markup = lv_content.
      else. "// for simple text
        call method (lv_method_name)
          exporting
            element = <text>
          receiving
            markup  = lv_content.
      endif.
    else.
      if ls_element-lines is not initial.
        concatenate lines of ls_element-lines into lv_content separated by %_newline.
      else.
        assign component 'TEXT' of structure <text> to <text>.
        lv_content = <text>.
        lv_content = _escape( text = lv_content allow_quotes = abap_true ).
      endif.

    endif.
    markup = |{ markup }{ lv_content }</{ ls_element-name }>|.

  else.
    markup = |{ markup } />|.
  endif.
endmethod.                    "element


method elements.
    data: lt_markup type table of string.

    field-symbols: <element> type any,
                   <markup> type string.

    loop at elements assigning <element>.
      append initial line to lt_markup assigning <markup>.
      <markup> = element( <element> ).
    endloop.

    concatenate lines of lt_markup into markup separated by %_newline.
    concatenate %_newline markup %_newline into markup.
  endmethod.                    "elements


  method filter_unsafe_url_in_attribute.
    r_element = element.

    assign r_element-attributes[ name = attribute ] to field-symbol(<attribute>).
    check sy-subrc = 0.

    loop at safe_links_whitelist->data assigning field-symbol(<scheme>).
      if stri_at_start( haystack = <attribute>-value needle = <scheme> ).
        return.
      endif.
    endloop.

    replace all occurrences of ':' in <attribute>-value with '%3A'.
  endmethod.


method htmlspecialchars.
  output = input.
  replace all occurrences of '&' in output with '&amp;'.
  replace all occurrences of '<' in output with '&lt;'.
  replace all occurrences of '>' in output with '&gt;'.

  if ent_noquotes is initial.
    replace all occurrences of '"' in output with '&quot;'.
    if ent_quotes is not initial.
      if ent_html401 is not initial.
        replace all occurrences of '''' in output with '&#039;'.
      else.
        replace all occurrences of '''' in output with '&apos;'.
      endif.
    endif.
  endif.
endmethod.                    "htmlspecialchars


method inline_code.
    data: lv_marker type c,
          lv_marker_comb type string,
          lv_m0 type string,
          lv_m1 type string,
          lv_text type string.

    lv_marker = excerpt-text(1).

    "// Deal with the different repetitions (from 5 markers to 1)
    lv_marker_comb = '&&&&&'.
    replace all occurrences of '&' in lv_marker_comb with lv_marker.
    while lv_marker_comb is not initial.
      match_marked_string(
        exporting marker = lv_marker_comb  subject = excerpt-text
        importing m0 = lv_m0  m1 = lv_m1
        exceptions not_found = 4
      ).
      if sy-subrc = 0.
        lv_text = lv_m1. condense lv_text.
        lv_text = lv_text.
        replace all occurrences of regex '[ ]*\n' in lv_text with ' '.

        r_inline-extent = strlen( lv_m0 ).
        r_inline-element-name = 'code'.
        r_inline-element-text-text = lv_text.
        exit.
      endif.
      shift lv_marker_comb left.
    endwhile.
  endmethod.                    "inline_code


method inline_emailtag.
    check excerpt-text cs '>'.

    data(lv_hostname_label) = '[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'.
    data(lv_common_mark_email) = '[a-zA-Z0-9.!#$%&\''*+\/=?^_`{|}~-]+@'
      && lv_hostname_label && '(?:\.' && lv_hostname_label && ')*'.
    data(lv_regex) = '(^<((mailto:)?' && lv_common_mark_email && ')>)'.

    find regex lv_regex in excerpt-text ignoring case
      submatches data(lv_m0) data(lv_m1) data(lv_m2).
    if sy-subrc = 0.
      data(lv_url) = lv_m1.
      if lv_m2 is initial.
        concatenate 'mailto:' lv_url into lv_url.
      endif.

      r_inline-extent = strlen( lv_m0 ).
      r_inline-element-name = 'a'.
      r_inline-element-text-text = lv_m1.

      append initial line to r_inline-element-attributes assigning field-symbol(<attribute>).
      <attribute>-name = 'href'.
      <attribute>-value = lv_url.
    endif.
  endmethod.                    "inline_EmailTag


method inline_emphasis.
    data: lv_marker type c,
          lv_emphasis type string,
          lv_m0 type string,
          lv_m1 type string,
          lo_regex type ref to lcl_string,
          lv_regex_delim type string,
          lv_offset type i.

    check excerpt-text is not initial.

    lv_marker = excerpt-text(1).

    lo_regex ?= me->strong_regex->get( lv_marker ).
    if strlen( excerpt-text ) > 1 and excerpt-text+1(1) = lv_marker and
       lo_regex->data is not initial.
      find regex lo_regex->data in excerpt-text submatches lv_m0 lv_m1.
      if sy-subrc = 0.
        lv_emphasis = 'strong'.

        "// get the (ungreedy) end marker
        lv_regex_delim = '[^&][&]{2}(?![&])'.
        replace all occurrences of '&' in lv_regex_delim with lv_marker.
        find regex lv_regex_delim in lv_m1 match offset lv_offset.
        if sy-subrc = 0.
          add 1 to lv_offset.
          lv_m1 = lv_m1(lv_offset).
          lv_offset = strlen( lv_m1 ) + 4.
          lv_m0 = lv_m0(lv_offset).
        endif.
      endif.
    endif.

    lo_regex ?= me->em_regex->get( lv_marker ).
    if lv_emphasis is initial and lo_regex->data is not initial.
      find regex lo_regex->data in excerpt-text submatches lv_m0 lv_m1.
      if sy-subrc = 0.
        lv_emphasis = 'em'.
      endif.
    endif.

    check lv_emphasis is not initial.

    r_inline-extent = strlen( lv_m0 ).
    r_inline-element-name = lv_emphasis.
    r_inline-element-handler = 'line'.
    r_inline-element-text-text = lv_m1.
  endmethod.                    "inline_Emphasis


method inline_escapesequence.
    data: lv_ch type c.

    check strlen( excerpt-text ) > 1.
    lv_ch = excerpt-text+1(1).
    sy-tabix = me->special_characters->find( lv_ch ).
    if sy-tabix > 0.
      r_inline-markup = excerpt-text+1(1).
      r_inline-extent = 2.
    endif.
  endmethod.                    "inline_EscapeSequence


method inline_image.
    data: ls_link like r_inline.
    field-symbols: <attribute> like line of r_inline-element-attributes,
                   <attribute_from> like line of ls_link-element-attributes.

    check strlen( excerpt-text ) > 1 and
          excerpt-text+1(1) = '['.
    excerpt-text = excerpt-text+1.

    ls_link = inline_link( excerpt ).
    check ls_link is not initial.

    r_inline-extent = ls_link-extent + 1.
    r_inline-element-name = 'img'.

    append initial line to r_inline-element-attributes assigning <attribute>.
    <attribute>-name = 'src'.
    read table ls_link-element-attributes assigning <attribute_from>
      with key name = 'href'.
    if sy-subrc = 0.
      <attribute>-value = <attribute_from>-value.
      delete ls_link-element-attributes where name = 'href'.
    endif.

    append initial line to r_inline-element-attributes assigning <attribute>.
    <attribute>-name = 'alt'.
    <attribute>-value = ls_link-element-text-text.

    append lines of ls_link-element-attributes to r_inline-element-attributes.
  endmethod.                    "inline_Image


method inline_link.
    constants: lc_regex_template type string value '\[((?:[^\]\[]|(?R))*)\]'.

    data: lv_len type i,
          lv_m0 type string,
          lv_m1 type string,
          lv_m2 type string,
          lv_definition type string,
          lo_ref_map type ref to lcl_hashmap,
          lo_def_map type ref to lcl_hashmap,
          lo_def_val type ref to lcl_string,
          lv_exists type flag.

    field-symbols: <attribute> like line of r_inline-element-attributes.

    r_inline-element-name = 'a'.
    r_inline-element-handler = 'line'.

    data(lv_remainder) = excerpt-text.

    data(lv_regex) = |({ lc_regex_template })|.
    do 5 times. "// regex recursion
      replace '(?R)' in lv_regex with lc_regex_template.
    enddo.
    replace '(?R)' in lv_regex with '$'.

    find regex lv_regex in lv_remainder submatches lv_m0 lv_m1.
    if sy-subrc = 0.
      r_inline-element-text-text = lv_m1.
      r_inline-extent = strlen( lv_m0 ).
      lv_remainder = lv_remainder+r_inline-extent.
    else.
      clear r_inline. return.
    endif.

*^[(]\s*((?:[^ ()]+|[(][^ )]+[)])+)(?:[ ]+("[^"]*"|''[^'']*''))?\s*[)]
*^[(]\s*((?:[^ ()]|[(][^ )]+[)])+)(?:[ ]+("[^"]*"|''[^'']*''))?\s*[)]
*^[(]((?:[^ ()]|[(][^ )]+[)])+)(?:[ ]+("[^"]*"|''[^'']*''))?[)]

    find regex '(^[(]\s*((?:[^ ()]|[(][^ )]+[)])+)(?:[ ]+("[^"]*"|''[^\'']*''))?\s*[)])'
      in lv_remainder submatches lv_m0 lv_m1 lv_m2.
    if sy-subrc = 0.
      append initial line to r_inline-element-attributes assigning <attribute>.
      <attribute>-name = 'href'. <attribute>-value = lv_m1.
      if lv_m2 is not initial.
        append initial line to r_inline-element-attributes assigning <attribute>.
        <attribute>-name = 'title'.
        lv_len = strlen( lv_m2 ) - 2.
        <attribute>-value = lv_m2+1(lv_len).
      endif.

      lv_len = strlen( lv_m0 ).
      add lv_len to r_inline-extent.

    else.
      find regex '(^\s*\[([^\]]*)\])' in lv_remainder submatches lv_m0 lv_m1.
      if sy-subrc = 0.
        if lv_m1 is not initial.
          lv_definition = lv_m1.
        else.
          lv_definition = r_inline-element-text-text.
        endif.
        lv_len = strlen( lv_m0 ).
        add lv_len to r_inline-extent.
      else.
        lv_definition = r_inline-element-text-text.
      endif.

      translate lv_definition to lower case.
      lo_ref_map ?= me->definition_data->get( 'Reference' ).
      lv_exists = lo_ref_map->exists( lv_definition ).
      if lv_exists is initial.
        clear r_inline. return.
      endif.

      lo_def_map ?= lo_ref_map->get( lv_definition ).

      lo_def_val ?= lo_def_map->get( 'url' ).
      append initial line to r_inline-element-attributes assigning <attribute>.
      <attribute>-name = 'href'. <attribute>-value = lo_def_val->data.

      lv_exists = lo_def_map->exists( 'title' ).
      if lv_exists is not initial.
        lo_def_val ?= lo_def_map->get( 'title' ).
        append initial line to r_inline-element-attributes assigning <attribute>.
        <attribute>-name = 'title'. <attribute>-value = lo_def_val->data.
      endif.
    endif.

    read table r_inline-element-attributes assigning <attribute>
      with key name = 'href'.
  endmethod.                    "inline_Link


method inline_markup.
    check me->markup_escaped is initial and
          me->safe_mode is initial and
          excerpt-text cs '>' and
          strlen( excerpt-text ) > 1.

    find regex '(^<\/\w*[ ]*>)' in excerpt-text submatches data(lv_m0).
    if sy-subrc <> 0.
      find regex '(^<!---?[^>-](?:-?[^-])*-->)' in excerpt-text submatches lv_m0.
      if sy-subrc <> 0.
        data(lv_regex) = '(^<\w*(?:[ ]*' && me->regex_html_attribute && ')*[ ]*\/?>)'.
        find regex lv_regex in excerpt-text submatches lv_m0.
      endif.
    endif.

    if lv_m0 is not initial.
      r_inline-markup = lv_m0.
      r_inline-extent = strlen( lv_m0 ).
    endif.
  endmethod.                    "inline_Markup


method inline_specialcharacter.
    data: lv_special type string.

    check excerpt-text is not initial.

    if excerpt-text(1) = '&'.
      find regex '^&#?\w+;' in excerpt-text.
      if sy-subrc <> 0.
        r_inline-markup = '&amp;'.
        r_inline-extent = 1.
        return.
      endif.
    endif.

    case excerpt-text(1).
      when '>'. lv_special = 'gt'.
      when '<'. lv_special = 'lt'.
      when '"'. lv_special = 'quot'.
    endcase.
    if lv_special is not initial.
      concatenate '&' lv_special ';' into r_inline-markup.
      r_inline-extent = 1.
    endif.
  endmethod.                    "inline_SpecialCharacter


method inline_strikethrough.
    data: lv_m0 type string,
          lv_m1 type string.

    check strlen( excerpt-text ) > 1 and
          excerpt-text+1(1) = '~'.

    find regex '(^~~(?=\S)([^(?:~~)]+)(?=\S)~~)' in excerpt-text
      submatches lv_m0 lv_m1.
    if sy-subrc = 0.
      r_inline-extent = strlen( lv_m0 ).
      r_inline-element-name = 'del'.
      r_inline-element-text-text = lv_m1.
      r_inline-element-handler = 'line'.
    endif.
  endmethod.                    "inline_Strikethrough


method inline_url.
    check me->urls_linked is not initial and
          strlen( excerpt-text ) > 2 and
          excerpt-text+2(1) = '/'.

    find regex '(\bhttps?:[\/]{2}[^\s<]+\b\/*)' in excerpt-context
      ignoring case submatches data(lv_m0) match offset data(lv_offset).
    if sy-subrc = 0.
      r_inline-extent = strlen( lv_m0 ).
      r_inline-position = lv_offset + 1. "// set to +1 so 0 is not initial
      r_inline-element-name = 'a'.
      r_inline-element-text-text = lv_m0.

      append initial line to r_inline-element-attributes assigning field-symbol(<attribute>).
      <attribute>-name = 'href'.
      <attribute>-value = lv_m0.
    endif.
  endmethod.                    "inline_Url


method inline_urltag.
    check excerpt-text cs '>'.

    find regex '(^<(\w+:\/{2}[^ >]+)>)' in excerpt-text submatches data(lv_m0) data(lv_m1).
    if sy-subrc = 0.
      data(lv_url) = lv_m1.
      r_inline-extent = strlen( lv_m0 ).
      r_inline-element-name = 'a'.
      r_inline-element-text-text = lv_url.

      append initial line to r_inline-element-attributes assigning field-symbol(<attribute>).
      <attribute>-name = 'href'.
      <attribute>-value = lv_url.
    endif.
  endmethod.                    "inline_UrlTag


method li.
    markup = _lines( lines ).
    data(lv_trimmed_markup) = trim( markup ).

    read table lines transporting no fields with key table_line = ''.
    if sy-subrc <> 0 and strlen( lv_trimmed_markup ) >= 3 and lv_trimmed_markup(3) = '<p>'.
      markup = lv_trimmed_markup+3.
      find '</p>' in markup match offset sy-fdpos.
      data: lv_pos_to type i.
      lv_pos_to = sy-fdpos + 4.
      concatenate markup(sy-fdpos) markup+lv_pos_to into markup.
    endif.
  endmethod.                    "li


method line.
    data: lv_text type string,
          lv_unmarked_text type string,
          lv_marker_position type i,
          ls_excerpt type ty_excerpt,
          ls_inline type ty_inline,
          lv_marker type c,
          lo_inline_types_sa type ref to lcl_string_array,
          lv_method_name type string,
          lv_markup_part type string,
          lv_continue_loop type flag.

    field-symbols: <inline_type> like line of lo_inline_types_sa->data.

    "# lv_text contains the unexamined text
    "# ls_excerpt-text is based on the first occurrence of a marker
    lv_text = element-text.

    while lv_text is not initial.
      if not lv_text ca me->inline_marker_list.
        exit.
      endif.
      ls_excerpt-text = lv_text+sy-fdpos.
      lv_marker = ls_excerpt-text(1).

      find lv_marker in lv_text match offset lv_marker_position.

      ls_excerpt-context = lv_text.

      lo_inline_types_sa ?= me->inline_types->get( lv_marker ).
      clear lv_continue_loop.
      loop at lo_inline_types_sa->data assigning <inline_type>.
        concatenate 'inline_' <inline_type> into lv_method_name.
        translate lv_method_name to upper case.
        call method (lv_method_name)
          exporting
            excerpt  = ls_excerpt
          receiving
            r_inline = ls_inline.

        "# makes sure that the inline belongs to "our" marker
        check ls_inline is not initial.
        check not ls_inline-position > lv_marker_position.

        "# sets a default inline position
        if ls_inline-position is initial.
          ls_inline-position = lv_marker_position.
        else.
          subtract 1 from ls_inline-position.
        endif.

        "# the text that comes before the inline
        if ls_inline-position <= strlen( lv_text ).
          lv_unmarked_text = lv_text(ls_inline-position).
        else.
          lv_unmarked_text = lv_text.
        endif.

        "# compile the unmarked text
        lv_markup_part = unmarked_text( lv_unmarked_text ).
        concatenate markup lv_markup_part into markup.

        "# compile the inline
        if ls_inline-markup is not initial.
          concatenate markup ls_inline-markup into markup.
        else.
          lv_markup_part = element( ls_inline-element ).
          concatenate markup lv_markup_part into markup.
        endif.

        "# remove the examined text
        data: lv_pos type i.
        lv_pos = ls_inline-position + ls_inline-extent.
        if lv_pos <= strlen( lv_text ).
          lv_text = lv_text+lv_pos.
        else.
          clear lv_text.
        endif.

        lv_continue_loop = abap_true. exit.
      endloop. "me->inline_types->data
      check lv_continue_loop is initial.

      "# the marker does not belong to an inline
      add 1 to lv_marker_position.
      if lv_marker_position <= strlen( lv_text ).
        lv_unmarked_text = lv_text(lv_marker_position).
      else.
        lv_unmarked_text = lv_text.
      endif.
      lv_markup_part = unmarked_text( lv_unmarked_text ).
      concatenate markup lv_markup_part into markup.
      if lv_marker_position <= strlen( lv_text ).
        lv_text = lv_text+lv_marker_position.
      else.
        clear lv_text.
      endif.
    endwhile.

    lv_markup_part = unmarked_text( lv_text ).
    concatenate markup lv_markup_part into markup.
  endmethod.                    "line


method magic_move.
    "!
    "! Magic move-corresponding
    "! Recursively handles any kind of structures
    "!
    data: lo_td_from type ref to cl_abap_typedescr,
          lo_td_to type ref to cl_abap_typedescr,
          lo_sd_from type ref to cl_abap_structdescr,
          lo_sd_to type ref to cl_abap_structdescr.
    field-symbols: <tab_from> type table,
                   <tab_to> type table,
                   <any_from> type any,
                   <any_to> type any.
    field-symbols: <comp_from> like line of lo_sd_from->components,
                   <comp_to>   like line of lo_sd_to->components.

    lo_td_from = cl_abap_typedescr=>describe_by_data( from ).
    lo_td_to   = cl_abap_typedescr=>describe_by_data( to ).
    if lo_td_from->absolute_name = lo_td_to->absolute_name.
      to = from.
      return.
    endif.

    "// Scenario 1 => simple to simple
    if lo_td_from->kind = lo_td_to->kind and
       lo_td_from->kind = cl_abap_typedescr=>kind_elem.
      move from to to.

      "// Scenario 2 => struct to struct
    elseif lo_td_from->kind = lo_td_to->kind and
           lo_td_from->kind = cl_abap_typedescr=>kind_struct.
      lo_sd_from ?= lo_td_from.
      lo_sd_to ?= lo_td_to.
      loop at lo_sd_from->components assigning <comp_from>.
        read table lo_sd_to->components assigning <comp_to>
          with key name = <comp_from>-name.
        check sy-subrc = 0.
        if <comp_to>-type_kind = cl_abap_typedescr=>typekind_table.
          assign component <comp_to>-name of structure from to <tab_from>.
          assign component <comp_to>-name of structure to to <tab_to>.
          loop at <tab_from> assigning <any_from>.
            append initial line to <tab_to> assigning <any_to>.
            magic_move(
              exporting from = <any_from> name = <comp_to>-name
              changing to = <any_to>
            ).
          endloop.
        else.
          assign component <comp_to>-name of structure from to <any_from>.
          assign component <comp_to>-name of structure to to <any_to>.
          magic_move(
            exporting from = <any_from> name = <comp_to>-name
            changing to = <any_to>
          ).
        endif.
      endloop.

      "// Scenario 3 => simple to struct
    elseif lo_td_from->kind = cl_abap_typedescr=>kind_elem and
           lo_td_to->kind = cl_abap_typedescr=>kind_struct and
           name is not initial.
      lo_sd_to ?= lo_td_to.
      read table lo_sd_to->components assigning <comp_to>
        with key name = name.
      if sy-subrc = 0 and
         <comp_to>-type_kind <> cl_abap_typedescr=>typekind_table.
        assign component <comp_to>-name of structure to to <any_to>.
        magic_move(
          exporting from = from name = <comp_to>-name
          changing to = <any_to>
        ).
      endif.

      "// Scenario 4 => struct to simple
    elseif lo_td_from->kind = cl_abap_typedescr=>kind_struct and
           lo_td_to->kind = cl_abap_typedescr=>kind_elem and
           name is not initial.
      lo_sd_from ?= lo_td_from.
      read table lo_sd_from->components assigning <comp_from>
        with key name = name.
      if sy-subrc = 0 and
         <comp_from>-type_kind <> cl_abap_typedescr=>typekind_table.
        assign component <comp_from>-name of structure to to <any_from>.
        magic_move(
          exporting from = <any_from> name = <comp_from>-name
          changing to = to
        ).
      endif.
    endif.
  endmethod.                    "magic_move


method match_marked_string.
    "!
    "! Workaround for an ungreedy regex match
    "! Specific for regex matches with a delimiting marker
    "!
    constants: lc_regex type string value '(^{&X}[ ]*(.+)[ ]*{&X}(?!{&1}))',
               lc_regex_delim type string value '[^{&1}]{&X}(?!{&1})'.
    data: lv_marker_ptn type string,
          lv_submarker_ptn type string,
          lv_regex type string,
          lv_regex_delim type string,
          lv_offset type i.

    lv_marker_ptn = marker.
    replace all occurrences of regex '([*?!+])' in lv_marker_ptn with '[$1]'.
    lv_submarker_ptn = marker(1).
    replace all occurrences of regex '([*?!+])' in lv_submarker_ptn with '[$1]'.

    lv_regex = lc_regex.
    replace all occurrences of '{&1}' in lv_regex with lv_submarker_ptn.
    replace all occurrences of '{&X}' in lv_regex with lv_marker_ptn.

    lv_regex_delim = lc_regex_delim.
    replace all occurrences of '{&1}' in lv_regex_delim with lv_submarker_ptn.
    replace all occurrences of '{&X}' in lv_regex_delim with lv_marker_ptn.

    find regex lv_regex in subject submatches m0 m1.
    if sy-subrc = 0.
      find regex lv_regex_delim in m1 match offset lv_offset.
      if sy-subrc = 0.
        add 1 to lv_offset.
        m1 = m1(lv_offset).
        lv_offset = strlen( m1 ) + ( strlen( marker ) * 2 ).
        m0 = m0(lv_offset).
      endif.
    else.
      raise not_found.
    endif.
  endmethod.


method paragraph.
    r_block-element-name = 'p'.
    r_block-element-text-text = line-text.
    r_block-element-handler = 'line'.
  endmethod.                    "paragraph


  method SANITISE_ELEMENT.
    r_element = element.

    constants: lc_good_attribute type string value '^[a-zA-Z0-9][a-zA-Z0-9_-]*$'.

    case r_element-name.
      when 'a'.
        r_element = filter_unsafe_url_in_attribute( element = r_element attribute = 'href' ).
      when 'img'.
        r_element = filter_unsafe_url_in_attribute( element = r_element attribute = 'src' ).
    endcase.

    loop at r_element-attributes assigning field-symbol(<attribute>).
      "# filter out badly parsed attribute
      find regex lc_good_attribute in <attribute>-name.
      if sy-subrc <> 0.
        delete table r_element-attributes from <attribute>. continue.
      endif.
      "# dump onevent attribute
      if stri_at_start( haystack = <attribute>-name needle = 'on' ).
        delete table r_element-attributes from <attribute>. continue.
      endif.
    endloop.
  endmethod.


method set_breaks_enabled.
    me->breaks_enabled = breaks_enabled.
    this = me.
  endmethod.                    "set_breaks_enabled


method set_markup_escaped.
    me->markup_escaped = markup_escaped.
    this = me.
  endmethod.                    "set_markup_escaped


  method set_safe_mode.
    me->safe_mode = safe_mode.
    this = me.
  endmethod.


method set_urls_linked.
    me->urls_linked = urls_linked.
    this = me.
  endmethod.                    "set_urls_linked


  method stri_at_start.
    data(lv_len) = strlen( needle ).

    if lv_len > strlen( haystack ).
      result = abap_false.
    else.
      result = xsdbool( to_lower( haystack+0(lv_len) ) = needle ).
    endif.
  endmethod.


method text.
    "! Parses the markdown text and returns the markup

    data: lt_lines type table of string.

    "# make sure no definitions are set
    create object me->definition_data
      exporting
        value_type = 'lcl_hashmap:lcl_hashmap'.

    "# standardize line breaks
    replace all occurrences of regex '\r?\n' in text with %_newline.

    "# remove surrounding line breaks
    text = trim( str = text mask = '\n' ).

    "# split text into lines
    split text at %_newline into table lt_lines.

    "# iterate through lines to identify blocks
    markup = me->_lines( lt_lines ).

    "# trim line breaks
    markup = trim( str = markup mask = '\n' ).
  endmethod.                    "text


method trim.
    data: lv_regex type string.

    r_str = str.
    replace all occurrences of regex '([\.\?\*\+\|])' in mask with '\\$1'.
    concatenate '(\A[' mask ']*)|([' mask ']*\Z)' into lv_regex.
    replace all occurrences of regex lv_regex in r_str with ''.
  endmethod.                    "trim


method unmarked_text.
    data: lv_break type string.

    concatenate '<br />' %_newline into lv_break.
    r_text = text.

    if me->breaks_enabled is not initial.
      replace all occurrences of regex '[ ]*\n' in r_text with lv_break.
    else.
      replace all occurrences of regex '(?:[ ][ ]+|[ ]*\\)\n' in r_text with lv_break.
      replace all occurrences of regex ' \n' in r_text with %_newline.
    endif.
  endmethod.                    "unmarked_text


  method _escape.
    output = htmlspecialchars(
      input = text
      ent_html401 = abap_true
      ent_noquotes = allow_quotes
      ent_quotes = xsdbool( allow_quotes is initial ) ).
  endmethod.


method _LINES.
    data: ls_current_block type ty_block,
          lv_line type string,
          lv_chopped_line type string,
          lt_parts type table of string,
          lv_shortage type i,
          lv_spaces type string,
          lv_indent type i,
          lv_text type string,
          lv_continue_to_next_line type flag.

    field-symbols: <part> like line of lt_parts.

    loop at lines into lv_line.

      lv_chopped_line = lv_line.
      replace regex '\s+$' in lv_chopped_line with ''.
      if strlen( lv_chopped_line ) = 0.
        ls_current_block-interrupted = abap_true.
        continue.
      endif.

      if lv_line cs %_horizontal_tab.
        split lv_line at %_horizontal_tab into table lt_parts.
        loop at lt_parts assigning <part>.
          at first.
            lv_line = <part>.
            continue.
          endat.
          lv_shortage = 4 - ( strlen( lv_line ) mod 4 ).
          clear lv_spaces.
          do lv_shortage times.
            concatenate lv_spaces space into lv_spaces respecting blanks.
          enddo.
          concatenate lv_line lv_spaces <part> into lv_line respecting blanks.
        endloop. "lt_parts
      endif.

      clear lv_spaces.
      find regex '^(\s+)' in lv_line submatches lv_spaces.
      lv_indent = strlen( lv_spaces ).
      if lv_indent > 0.
        lv_text = lv_line+lv_indent.
      else.
        lv_text = lv_line.
      endif.

      "# ~

      data: ls_line type ty_line.
      clear ls_line.
      ls_line-body = lv_line.
      ls_line-indent = lv_indent.
      ls_line-text = lv_text.

      "# ~

      data: lv_method_name type string,
            ls_block type ty_block.
      if ls_current_block-continuable is not initial.
        clear ls_block.
        concatenate 'block_' ls_current_block-type '_continue' into lv_method_name.
        translate lv_method_name to upper case.
        call method (lv_method_name)
          exporting
            line    = ls_line
            block   = ls_current_block
          receiving
            r_block = ls_block.
        if ls_block is not initial.
          ls_current_block = ls_block.
          continue.
        else.
          concatenate 'block_' ls_current_block-type '_complete' into lv_method_name.
          translate lv_method_name to upper case.
          read table me->methods transporting no fields with key table_line = lv_method_name.
          if sy-subrc = 0.
            call method (lv_method_name)
              exporting
                block   = ls_current_block
              receiving
                r_block = ls_current_block.
          endif.
        endif. "ls_block is not initial.
        clear ls_current_block-continuable.
      endif. "ls_current_block-continuable is not initial.

      "# ~

      data: lv_marker type string,
            lo_block_types type ref to lcl_string_array,
            lo_sa type ref to lcl_string_array.

      field-symbols: <block_type> type lcl_hashmap=>ty_item.

      lv_marker = lv_text(1).

      "# ~

      create object lo_block_types.
      lo_block_types->copy( me->unmarked_block_types ).

      read table me->block_types->data assigning <block_type>
        with key key = lv_marker.
      if sy-subrc = 0.
        lo_sa ?= <block_type>-value.
        lo_block_types->append_array( lo_sa ).
      endif.

      "#
      "# ~

      data: lt_blocks type table of ty_block.

      field-symbols: <block_type_name> type string.

      loop at lo_block_types->data assigning <block_type_name>.
        clear ls_block.
        concatenate 'block_' <block_type_name> into lv_method_name.
        translate lv_method_name to upper case.
        call method (lv_method_name)
          exporting
            line    = ls_line
            block   = ls_current_block
          receiving
            r_block = ls_block.

        if ls_block is not initial.
          ls_block-type = <block_type_name>.

          if ls_block-identified is initial.
            append ls_current_block to lt_blocks.
            ls_block-identified = abap_true.
          endif.

          concatenate 'block_' <block_type_name> '_continue' into lv_method_name.
          translate lv_method_name to upper case.
          read table me->methods transporting no fields with key table_line = lv_method_name.
          if sy-subrc = 0.
            ls_block-continuable = abap_true.
          endif.

          ls_current_block = ls_block.
          lv_continue_to_next_line = abap_true.
          exit.
        endif.
      endloop. "lo_block_types->data

      if lv_continue_to_next_line is not initial.
        clear lv_continue_to_next_line.
        continue.
      endif.

      "# ~

      if ls_current_block is not initial and
         ls_current_block-type is initial and
         ls_current_block-interrupted is initial.
        concatenate ls_current_block-element-text-text %_newline lv_text
         into ls_current_block-element-text-text.
      else.
        append ls_current_block to lt_blocks.

        ls_current_block = me->paragraph( ls_line ).

        ls_current_block-identified = abap_true.
      endif.

    endloop. "lines

    "# ~

    if ls_current_block-continuable is not initial.
      concatenate 'block_' ls_current_block-type '_complete' into lv_method_name.
      translate lv_method_name to upper case.
      read table me->methods transporting no fields with key table_line = lv_method_name.
      if sy-subrc = 0.
        call method (lv_method_name)
          exporting
            block   = ls_current_block
          receiving
            r_block = ls_current_block.
      endif.
    endif.

    append ls_current_block to lt_blocks.
    delete lt_blocks index 1.

    "# ~

    data: lv_block_markup type string.

    field-symbols: <block> like line of lt_blocks.

    loop at lt_blocks assigning <block>.
      check <block>-hidden is initial.

      if <block>-markup is not initial.
        lv_block_markup = <block>-markup.
      else.
        lv_block_markup = element( <block>-element ).
      endif.
      concatenate markup %_newline lv_block_markup into markup respecting blanks.
    endloop.

    concatenate markup %_newline into markup respecting blanks.
  endmethod.                    "lines
ENDCLASS.
