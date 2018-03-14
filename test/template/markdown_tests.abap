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
*%  Generated on [GENERATED_ON] by generate_abapunit_tests.py
*%  Do not change this code manualy!
*%

[INCLUDE templates_tests.abap]

class markdown_tests definition create private for testing.
  "#AU Risk_Level Harmless
  "#AU Duration   Short

  private section.
    data: markdown type ref to zmarkdown.
    methods:
      constructor,
      [METHOD_DEFINITIONS]
endclass.                    "markdown_tests DEFINITION

*#
class markdown_tests implementation.
  method constructor.
    create object me->markdown.
  endmethod.

  [METHOD_IMPLEMENTATIONS]
endclass.                    "markdown_tests IMPLEMENTATION
