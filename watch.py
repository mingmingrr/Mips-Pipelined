#! /usr/bin/env python3

import sys
import time
import subprocess

if __name__ != '__main__':
	print('no imports c:')
	sys.exit()

while True:
	line = sys.stdin.readline()
	if 'MODIFY' not in line: continue
	time.sleep(0.5)
	sys.stdin.flush()
	try:
		subprocess.run(['make', '--silent'], check=True)
	except subprocess.CalledProcessError:
		subprocess.run(['notify-send', '-a', 'make', '"make failed"'])
