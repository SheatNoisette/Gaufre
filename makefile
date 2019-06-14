all: release

release: jslib python neko

debug: debug-neko

clean:
	rm -rf out/
	rm -f gaufre_debug.n
	rm -f gaufre_tests.n

# -------------------------
# Self check - auto-tests
autotest:
	haxe -cp src -main MainSelfTest -debug --no-traces -neko gaufre_tests.n
	neko gaufre_tests.n

# -------------------------
# Targets

jslib: clean
	haxe -cp src -main Main -dce full --no-traces -D lib=true -js out/gaufre.js

python: clean
	haxe -cp src -main Main -dce full --no-traces -python out/gaufre.py

neko: clean
	haxe -cp src -main Main -dce full --no-traces -neko out/gaufre.n

# -------------------------
# Debug version

debug-neko:
	haxe -cp src -main Main -debug -neko gaufre_debug.n