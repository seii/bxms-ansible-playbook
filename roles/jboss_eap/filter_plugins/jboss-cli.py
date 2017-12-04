import json
import re
from ansible.errors import AnsibleError

def to_jbosscli_optionslist(value):
   return ','.join('("' + k + '"=>"' + str(value[k]) + '")' for k in value)

def parse_jbosscli_output(value):
   return json.loads(
      re.sub(r'\n', ' ',
         re.sub(r'\((.*)\)(,?)($|\n)', '{\\1}\\2',
            re.sub(r'=>', ':',
               re.sub(r'=> (\d+)L', ': \\1',
                  re.sub(r'=> expression', ':',
                     re.sub(r'=> undefined', ': null', value)
                  )
               )
            )
         )
      )
   )

class FilterModule(object):
   '''
   jinja2 filter for paring jboss-cli.sh output
   '''
   def filters(self):
      return {
         'to_jbosscli_optionslist': to_jbosscli_optionslist,
         'parse_jbosscli_output': parse_jbosscli_output
      }
