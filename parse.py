#!/usr/bin/env python
# -*- coding: utf-8 -*-

lines = []
from sys import stdin
found = False
for i in stdin.readlines()[::-1]:
    if '+/-' in i.split():
        found = True
        #lines += ''.join( i.split()[:i.split().index('+/-')] )
        lines += i[:i.index('+')]+'\n'
    else:
        if found == True:
            break

out = ''.join(lines)
outr = out.split('\n')[::-1][1:]

for i in outr:
    print i

print

for i in outr:
    print i[i.index('=')+2:]
