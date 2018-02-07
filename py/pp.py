"""PyParsing parsers to read assembly"""

import pyparsing as P
C = P.pyparsing_common
from reg import nums as R

make_number_base = lambda base, flag, chars: (
	P.Suppress('0' + flag) +
	P.Word(chars).leaveWhitespace()
).setParseAction(
	lambda s,l,t: int(t[0], base)
)

decimal = C.integer.setParseAction(C.convertToInteger)

number = (
	make_number_base(10, 'd', P.nums) |
	make_number_base(16, 'x', P.hexnums) |
	make_number_base(2, 'b', '01') |
	make_number_base(8, 'o', '01234567') |
	make_number_base(8, '', '01234567') |
	decimal
)

signed = (
	P.Optional(P.oneOf('+ -')) + number
).setParseAction(
	lambda s,l,t: int(''.join(map(str, t)))
	# t[0] if len(t) == 1 else (t[1] if t[0] == '+' else -t[1])
)

identifier = C.identifier

label = identifier('label')

register = (
	P.Suppress('$') +
	(identifier | decimal).leaveWhitespace()
		.setParseAction(lambda s,l,t: R.get(t[0], t))
).setResultsName('register')

parenthesized = lambda x: (
	P.Suppress('(') +
	x +
	P.Suppress(')')
)

offset = (
	(label | signed)('offset') +
	parenthesized(register | label)('pointer')
)

comment = P.Suppress(
	P.oneOf('; #') + P.restOfLine
)

opcode = identifier('opcode')

operand = (
	offset |
	register |
	label |
	number
)

operands = P.Group(
	P.Optional(
		P.delimitedList(
			P.Group(
				operand
)))).setResultsName('operands')

instruction = (
	opcode + operands
).setResultsName('instruction')

line = (
	P.Optional(label + P.Suppress(':')) +
	P.Optional(instruction) +
	P.Optional(comment)
)

if __name__ == '__main__':
	import sys
	line.runTests(sys.stdin.readlines())
