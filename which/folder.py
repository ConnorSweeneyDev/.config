import os
import sys
import subprocess

file = open("C:\\which\\path.txt", 'r')
path = file.readline()
file.close()
file = open("C:\\which\\path.txt", 'r').close()

path = os.path.dirname(path)

file = open("C:\\which\\path.txt", 'w')
if (path == ""):
    path = "C:\\"
file.writelines(path)
file.close()
