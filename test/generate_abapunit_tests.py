#!/usr/bin/env python

# ABAP Markdown
# (C) 2015 - Guilherme Maeda
#
# This script generates the ABAPUnit test classes (for unit testing the ZMARKDOWN class).
# A testing class is created for each pair of fixture files in the data directory.
#
# Based on the Parsedown parser (parsedown.org).

from os import listdir
from os.path import isfile, join
from datetime import datetime
import re

#######################################################################
#  Functions
#######################################################################

# Creates ABAP code to assign content to a variable
def abap_set_variable_content( varname, content ):
  # Check if we can use a direct assignment
  if content.find("\n") < 0 and len(content) <= 90:
    return varname + " = '" + content.replace("'", "''") + "'."

  # Generate the concatenate command tokens
  tokens = [ "concatenate" ]
  content_lines = content.splitlines()
  for line in content_lines:
    # break long lines (>90)
    chunks = [ line[i:i+90] for i in range(0,len(line),90) ]
    tokens.extend([ "'{0}'".format(c.replace("'", "''")).replace("\t", "' %_HORIZONTAL_TAB '")
      for c in chunks ])
    tokens.append("%_NEWLINE")
  tokens.pop()
  tokens.extend([ "into", varname, "respecting", "blanks" ])

  # Put the tokens together
  code_lines = []
  line = ""
  for token in tokens:
    if line != "" and len(line + token) > 90:
      code_lines.append(line)
      line = ""
    line += token + " "
  line += "."
  code_lines.append(line)

  return "\n".join(code_lines)

#######################################################################
#  Main code
#######################################################################

# List all the markdown files
data_path = "data"
md_files = [ f for f in listdir(data_path) if f.endswith(".md") ]

# Read the code templates
class_template = open("template/markdown_tests.abap").read()
method_template = open("template/markdown_tests-method.abap").read()
templates_tests = open("templates_tests.abap").read()

# Generate the ABAP code
today = datetime.now().date()
method_names = []
class_code = class_template.replace("[GENERATED_ON]", today.isoformat())
class_code = class_code.replace("[INCLUDE templates_tests.abap]", templates_tests)

method_implementations = []
for f in md_files:
  method_name = re.sub(r"[-\s\.]", "_", f.replace(".md", ""))
  method_names.append(method_name)
  method_code = method_template.replace("[METHOD_NAME]", method_name)

  markdown = open("data/" + f).read()
  method_code = method_code.replace("[MARKDOWN_LINES]", \
    abap_set_variable_content("lv_markdown", markdown))

  html = open("data/" + f.replace(".md", ".html")).read()
  method_code = method_code.replace("[EXPECTED_MARKUP_LINES]", \
    abap_set_variable_content("lv_expected_markup", html))

  method_implementations.append(method_code)

class_code = class_code.replace("[METHOD_DEFINITIONS]", \
  " for testing,\n      ".join(method_names) + " for testing.")
class_code = class_code.replace("[METHOD_IMPLEMENTATIONS]", \
  "\n\n".join(method_implementations))

# Save the generated code
with open("zmarkdown.clas.testclasses.abap", "w") as f:
    f.write(class_code)
print("ABAP code successfuly generated.")
