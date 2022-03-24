#!/usr/bin/python

import fileinput
import re
import os
import sys

# VARS
script_path = os.path.dirname(sys.argv[0])
file_before = script_path + "/MAPS_Config_Before.yml"
file_after = script_path + "/MAPS_Config_After.yml"
exceptions = {
    'useIBMCipherMappings': 'use-IBM-cipher-mappings'
}


def camel_to_kebab(param):
    camelCasePattern = '^[a-z]{1,}([A-Z]{1,}[a-z]{1,}){1,}$'
    if param in exceptions:
        return exceptions[param]
    if re.match(camelCasePattern, param):
        return ''.join(['-'+i.lower() if i.isupper() else i for i in param]).lstrip('-')
    return param


def main():
    split_line_pattern = '(?P<Before_Key> *?)(?P<Key>[a-zA-Z0-9.-]+)(?P<After_Key>\: ?.*)'

    try:
        with open(file_after, 'w') as f_out:
            for line in fileinput.input(file_before):
                reg_exp = re.search(split_line_pattern, line)
                if reg_exp is not None:
                    line = re.sub(split_line_pattern, '{}{}{}'.format(reg_exp.group(
                        'Before_Key'), camel_to_kebab(reg_exp.group('Key')), reg_exp.group('After_Key')), line)

                f_out.write(line)

    except (IOError, OSError):
        print("Error")

    return 1


if __name__ == '__main__':
    main()
