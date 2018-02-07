"""Unification algorithms for operands"""
# Python is now Prolog c:

import functools as F

def iterable(x):
	if type(x) is str:
		return False
	try:
		iter(x)
		return True
	except:
		return False

# [a] -> [a] -> {a:a}
def unify_structure(a, b):
	if iterable(a) != iterable(b):
		raise ValueError('mismatched iterables')
	if not iterable(a):
		return {a : b}
	if len(a) != len(b):
		raise ValueError('mismatched iterable lengths')
	return F.reduce(
		lambda s,x: [s.update(x), s][1],
		map(unify_structure, a, b), {}
	)

# str -> [str] -> Maybe {str:str}
def unify_binary(source, target):
	names = {}
	for spec in target:
		if '.' in spec:
			name, width = spec.split('.')
			width = int(width)
			curr, source = source[:width], source[width:]
			names[name] = (curr, width)
			continue
		curr, source = source[:len(spec)], source[len(spec):]
		if not all(b == '-' or a == b for a, b in zip(curr, spec)):
			return None
	return names


