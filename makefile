all: debug

debug-neko:
	haxe -cp src -main Main -debug -neko gaufre.n

jslib:
	haxe -cp src Gaufre -dce full -D lib=true -js gaufre.js