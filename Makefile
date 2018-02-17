default: all

header = "py/tv.py"

tvlog = $(shell find tv -name "*.tv")
tvout = $(tvlog:tv/%.tv=sv/%.v)
$(tvout): sv/%.v: tv/%.tv
	mkdir -p $(shell dirname "$@")
	cat $(header) "$<" | expander3 > "$@"
out = $(tvout)

pvlog = $(shell find tv -name "*.pv")
pvout = $(pvlog:tv/%.pv=sv/%.v)
$(pvout): sv/%.v: tv/%.pv
	mkdir -p $(shell dirname "$@")
	cat $(header) "$<" | expander3 > "$@"
out += $(pvout)

vlog =$(shell find tv -name "*.v")
vout = $(vlog:tv/%.v=sv/%.v)
$(vout): sv/%.v: tv/%.v
	mkdir -p $(shell dirname "$@")
	cp "$<" "$@"
out += $(vout)

svlog =$(shell find tv -name "*.sv")
svout = $(svlog:tv/%.sv=sv/%.sv)
$(svout): sv/%.sv: tv/%.sv
	mkdir -p $(shell dirname "$@")
	cp "$<" "$@"
out += $(svout)

.PHONY: all
all: $(out)

.PHONY: clean
clean:
	rm -rvf sv
