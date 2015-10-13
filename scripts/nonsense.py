#!/usr/bin/env python3
#-*- coding:utf-8 -*-

from sys import argv
from random import SystemRandom

rng = SystemRandom()

width = int(argv[1])
height = int(argv[2])

for j in range(height):
    #ascii from 33 to 126
    print("".join([chr(rng.randint(0,93) + 33) for i in range(width)]))

