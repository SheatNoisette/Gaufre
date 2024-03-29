# Gaufre programming language
Yet another simple esoteric language.

[![Build status](https://ci.appveyor.com/api/projects/status/3eqyc8y5q4f2sf8f?svg=true)](https://ci.appveyor.com/project/SheatNoisette/gaufre)

## Building the interpreter

The Gaufre interpreter is implemented using [Haxe Toolkit](https://haxe.org) v3.4.x, Haxe 4+ is currently not supported. 
You will need the [NekoVM](https://nekovm.org/) to launch the interpreter.
You can get Haxe on your computer by following this [link](https://haxe.org/download/linux/). NekoVM will automatically install itself using this method.

Then, you can build the interpreter by typing `make`.

A new folder named `out` will appear. Inside, you will find every supported version of the interpreter.

## Hacking the interpreter

Custom debug versions of the interpreter can be built. 

`make autotest` : Build Gaufre with built-in unit tests with traces disabled

`make debug-neko` : Build Gaufre in verbose mode. Warning: This build will be slower and outputs a lot of information in your terminal.

## How to do things with Gaufre

See `GaufreManual.md` for more details.

## Licence

This work is released under the GNU GENERAL PUBLIC LICENSE v3.0. 

A copy of this licence is provided in `LICENCE.md`.
