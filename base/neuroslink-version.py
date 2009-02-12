#!/usr/bin/python
import sys
import os

try:
    a = open('/etc/link-version','r')
    readdata = a.readline()
    version = readdata.strip()
except IOError, e:
    version = "Unknown"
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

title = 'NeurosLink Version Information'

maintext = 'NeurosLink Firmware Version: ' + version + "\n\nBase System:\n\tUbuntu Intrepid 8.10"
os.spawnlp(os.P_WAIT,"/usr/bin/zenity","zenity","--info","--title=" + title,"--text=" + maintext)




