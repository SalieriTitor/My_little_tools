#-*- coding: UTF-8 -*-
import sys
import re
listinfo = {}
with open(sys.argv[1],'r') as listdata:
	for transcript in listdata.readlines():
		transcript = transcript.rstrip('\n')
		listinfo[transcript] = transcript

seqinfo = {}
with open(sys.argv[2],'r') as seqdata:
	head = seqdata.readline().rstrip('\n')
	idname=re.match('>(.*)',head)
	idname=idname.group(1)
	seqinfo[idname] = ''
	for line in seqdata.readlines():
		line = line.rstrip('\n')
		seqname = re.match('>(.*)',line)
		if (seqname):
			idname = seqname.group(1)
			seqinfo[idname] = ''
		else:
			seqinfo[idname] = seqinfo[idname] + line
for i in seqinfo:
	if i in listinfo:
		print (">",i,'\n',seqinfo[i],sep='')
