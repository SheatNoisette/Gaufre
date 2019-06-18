package tests;

import FileParser as Fp;
import Gaufre;
import GaufreInstruction;

//Verify if the interpreter handle correctly overflow / underflow pattern
class OverflowTests extends haxe.unit.TestCase {

    //Create instance
    var gaufre:Gaufre;

    // Test Inc overflow handler
    public function testIncOverflow() {
        gaufre = new Gaufre(10, 255);

        gaufre.PushInstruction(GOpcodes.OP_INC(987));
        gaufre.Run();

        //987 mod 256 = 219
        assertEquals(gaufre.memory[0], 219);
    }

    // Test Dec underflow handler
    public function testDecUnderflow() {
        gaufre = new Gaufre(10, 255);

        gaufre.PushInstruction(GOpcodes.OP_DEC(987));
        gaufre.Run();

        //-987 mod 256 = 37
        assertEquals(gaufre.memory[0], 37);
    }
}