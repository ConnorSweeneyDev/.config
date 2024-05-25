import os

file = open("C:\\scripts\\which\\path.txt", 'r')
path = file.readline()
file.close()
file = open("C:\\scripts\\which\\path.txt", 'r').close()

path = os.path.dirname(path)

file = open("C:\\scripts\\which\\path.txt", 'w')
if (path == ""):
    path = "C:\\"
file.writelines(path)
file.close()
