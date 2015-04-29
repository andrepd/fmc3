#!/usr/bin/env python
# -*- coding: utf-8 -*-

from math import *
from sys import argv,stdin

data = stdin.readlines()
dat=[]
for i in data:
    par = i.split()
    if float(argv[1]) < float(par[0]) < float(argv[2]):
        dat.append([float(par[0]),float(par[1])])

m = (dat[-1][1]-dat[0][1])/(dat[-1][0]-dat[0][0])
b_ = dat[-1][1]-m*dat[-1][0]

for i in range(len(dat)):
    dat[i][1]-=m*dat[i][0]+b_

print "min =",argv[1]
print "max =",argv[2]
#print "f(x)="+str(m)+"*x+"+str(b_)
print "m =",m
print "b =",b_

def f(x):
    return m*x+b_

r = 0.
for i in range(len(data[:-1])):
    b = float(data[i+1].split()[0])
    a = float(data[i].split()[0])
    if float(argv[1]) < a and b < float(argv[2]):
        fb = float(data[i+1].split()[1])
        fa = float(data[i].split()[1])
        r += (b-a)*(fa+fb-f(b)-f(a))/2

print "A =",r

