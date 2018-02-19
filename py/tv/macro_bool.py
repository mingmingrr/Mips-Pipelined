from .macro_enum import makeEnum

def makeBool(typename):
	return makeEnum(typename, [('True', 1), ('False', 0)])

