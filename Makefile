default: all

pvlog = $(shell find sv -type f -name "*.p.v")
vlog  = $(pvlog:%.p.v=%.v)

header = "import imp; makeStruct = imp.load_source('MS', './py/vstruct.py').makeStruct; makeEnum = imp.load_source('MS', './py/venum.py').makeEnum; makeBitset = imp.load_source('MS', './py/vbitset.py').makeBitset"

%.v: %.p.v
	expander3 --eval=$(header) "$<" > "$@"

.PHONY: all
all: $(vlog)
