default: all

header = "py/tv.py"

tvlog = $(shell find tv -name "*.tv")
tvout = $(tvlog:tv/%.tv=sv/%.v)
$(tvout): sv/%.v: tv/%.tv
	@echo "[Expand] $< --> $@"
	mkdir -p $(shell dirname "$@")
	cat $(header) "$<" | expander3 > "$@"
out = $(tvout)

pvlog = $(shell find tv -name "*.pv")
pvout = $(pvlog:tv/%.pv=sv/%.v)
$(pvout): sv/%.v: tv/%.pv
	@echo "[Expand] $< --> $@"
	mkdir -p $(shell dirname "$@")
	cat $(header) "$<" | expander3 > "$@"
out += $(pvout)

vlog =$(shell find tv -name "*.v")
vout = $(vlog:tv/%.v=sv/%.v)
$(vout): sv/%.v: tv/%.v
	@echo "[Copy] $< --> $@"
	mkdir -p $(shell dirname "$@")
	cp "$<" "$@"
out += $(vout)

svlog =$(shell find tv -name "*.sv")
svout = $(svlog:tv/%.sv=sv/%.sv)
$(svout): sv/%.sv: tv/%.sv
	@echo "[Copy] $< --> $@"
	mkdir -p $(shell dirname "$@")
	cp "$<" "$@"
out += $(svout)

.PHONY: all
all: $(out)

.PHONY: clean
clean:
	rm -rvf sv

.PHONY: watch
watch:
	inotifywait -e modify -r -m tv | python3 watch.py
	# while true; do \
	# 	make --quiet || \
	# 		notify-send -a make "make failed" \
	# 	sleep 5; \
	# 	done

.PHONY: test
test:
	for v in $(out) ; do \
		verilator -I`dirname "$$v"` --lint-only "$$v" ; \
	done
