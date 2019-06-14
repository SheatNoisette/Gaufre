package tests;

import FileParser as Fp;
import Gaufre;
import GaufreInstruction;

class FileParserTests extends haxe.unit.TestCase {
    //Check the file parser and the string parser

    //----------------------
    //Simple tests

    //Simple test - Best case
    public function testBasicParsing ():Void {
        
        var input = "#\n## #\n### #######";

        //Parse the content
        assertEquals(Fp.ParseString(input).toString(), 
        [GOpcodes.OP_EXIT, GOpcodes.OP_INC(1), GOpcodes.OP_DEC(7)].toString());
    }
    //Simple test - Garbage char
    public function testBasicGarbageParsing ():Void {
        
        var input = "zef#    \nreg#greg#ze #\n### fkpoze#é&'$*ùù#fefz##z@@#é'd#regergergergerge#";

        //Parse the content
        assertEquals(Fp.ParseString(input).toString(), 
        [GOpcodes.OP_EXIT, GOpcodes.OP_INC(1), GOpcodes.OP_DEC(7)].toString());
    }

    //----------------------
    //Advanced tests

    //Advanced test - Comments
    public function testAdvancedGarbageParsing ():Void {
        
        var input = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel mollis arcu, non blandit sem. Morbi tellus nulla, bibendum id dapibus ac, eleifend sed enim\n#\nFusce nibh lectus, fringilla varius augue eget, sodales vehicula dui.\n### ##\n####### # ## ###\nEtiam et nibh posuere, porttitor nunc eget, scelerisque orci";

        //Parse the content
        assertEquals(Fp.ParseString(input).toString(), 
        [GOpcodes.OP_EXIT,GOpcodes.OP_DEC(2),GOpcodes.OP_GOTOEQ(1,2,3)].toString());
    }
}