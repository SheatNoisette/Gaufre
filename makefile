all: release

release: jslib python

debug: debug-neko

clean:
	rm -rf out/

jslib:
	haxe -cp src Gaufre -dce full --no-traces -D lib=true -js out/gaufre.js

python: 
	haxe -cp src Gaufre -dce full --no-traces -python out/gaufre.py

# -------------------------
# Debug version

debug-neko:
	haxe -cp src -main Main -debug -neko gaufre.n