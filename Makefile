default: all

define makePre
	@echo "[Make] $2 --> $1"
	mkdir -p $(shell dirname "$1")
endef

define makePost
	python3 py/tv/include.py --base sv --file "$1" | \
	python3 py/tv/guard.py --base sv --file "$1" --output "$1"
endef

define makePv
	$(call makePre,$1,$2)
	expander3 -a "py/tv/header.py" "$2" | \
	$(call makePost,$1,$2)
endef

define makeV
	$(call makePre,$1,$2)
	cat "$2" | \
	$(call makePost,$1,$2)
endef

tvlog = $(shell find tv -name "*.tv")
tvout = $(tvlog:tv/%.tv=sv/%.v)
$(tvout): sv/%.v: tv/%.tv
	$(call makePv,$@,$<)
out = $(tvout)

pvlog = $(shell find tv -name "*.pv")
pvout = $(pvlog:tv/%.pv=sv/%.v)
$(pvout): sv/%.v: tv/%.pv
	$(call makePv,$@,$<)
out += $(pvout)

vlog =$(shell find tv -name "*.v")
vout = $(vlog:tv/%.v=sv/%.v)
$(vout): sv/%.v: tv/%.v
	$(call makeV,$@,$<)
out += $(vout)

svlog =$(shell find tv -name "*.sv")
svout = $(svlog:tv/%.sv=sv/%.sv)
$(svout): sv/%.sv: tv/%.sv
	$(call makeV,$@,$<)
out += $(svout)

.PHONY: all
all: $(out)

.PHONY: clean
clean:
	rm -rfv sv

.PHONY: prune
prune:
	printf "%s\n" $(out) | sort > temp1
	find sv -type f -name "*.v" > temp2
	find sv -type f -name "*.sv" >> temp2
	cat temp2 | sort > temp3
	comm -13 temp1 temp3 | xargs rm
	rm temp1 temp2 temp3

.PHONY: watch
watch: all
	inotifywait -e modify -e delete -r -m tv | python3 watch.py
	# while true; do \
	# 	make --quiet || \
	# 		notify-send -a make "make failed" \
	# 	sleep 5; \
	# 	done

.PHONY: test
test: all
	for v in $(out) ; do \
		verilator -I`dirname "$$v"` --lint-only "$$v" ; \
	done
