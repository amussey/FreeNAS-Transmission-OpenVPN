#!/usr/bin/python
#
# This script takes two parameters.
#     fix_ip.py <settings.json> <new ip address> 

import json
import sys

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print 'Usage:\n    fix_ip.py <settings.json> <new ip address>\n'
        sys.exit(-1)

    f = open(sys.argv[1], 'r')
    settings = json.loads(f.read())
    f.close()

    settings['bind-address-ipv4'] = sys.argv[2]
    if settings['rpc-whitelist'] == '127.0.0.1':
        settings['rpc-whitelist'] = '0.0.0.0'
        settings['rpc-whitelist-enabled'] = False

    f = open(sys.argv[1], 'w')
    f.write(json.dumps(settings))
    f.close()
