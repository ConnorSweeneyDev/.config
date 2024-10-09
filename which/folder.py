import os

which_path = os.path.dirname(__file__)

file = open(which_path + "\\path.txt", 'r')
path = file.readline()
file.close()
file = open(which_path + "\\path.txt", 'r').close()

path = os.path.dirname(path)

file = open(which_path + "\\path.txt", 'w')
file.writelines(path)
file.close()
