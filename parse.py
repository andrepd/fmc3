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

print

for i,j in zip(outr[0:4],outr[4:8]):
    print i[i.index('=')+2:],j[j.index('=')+2:]
for i in outr[8:10]:
    print i[i.index('=')+2:],i[i.index('=')+2:]
