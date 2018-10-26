#!/usr/bin/env python

from __future__ import print_function
import liblo, sys

# send all messages to port 1234 on the local machine
try:
    target = liblo.Address(sys.argv[1])
except liblo.AddressError as err:
    print(err)
    sys.exit()

# send message "/foo/message1" with int, float and string arguments
liblo.send(target, sys.argv[2], sys.argv[3], str(sys.argv[4]))

