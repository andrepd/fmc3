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

print ''.join(lines)
#for i in lines[::-1]:
    #print i
