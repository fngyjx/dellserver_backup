#!/usr/bin/python

import urllib

#urllibFunctions=dir(urllib)

#help('urllib.'+urllibFunctions[-2])
#help(urllib.urlopen)

import package.bar
from package import foo
from package import private

print "get bar module %s" %(package.bar.bar)
print "get foo module %s" %(foo.foo)
print "get private module %s" %(private.private)

