package tests;

import FileParser as Fp;
import Gaufre;
import GaufreInstruction;

//Test the Gaufre interpreter
class GaufreTests extends haxe.unit.TestCase {
    //Create a Gaufre instance for testing
    var gaufre = new Gaufre(32, 64);

    //---------------------------
    //Basic tests

    //Test Increment (OP_INC) and Decrement (OP_DEC) with arguments
    public function testIncDecArgs():Void {
        //Reset Gaufre instance
        var gaufre = new Gaufre(32, 64);

        var program = [
            GOpcodes.OP_INC(5),
            GOpcodes.OP_INC(2),
            GOpcodes.OP_INC(5),
            GOpcodes.OP_DEC(8),
            GOpcodes.OP_INC(5),
            GOpcodes.OP_INC(1),
            GOpcodes.OP_INC(1),
            GOpcodes.OP_DEC(6)
        ];

        //Load the program and run
        gaufre.LoadProgram(program);
        gaufre.Run();

        //Cell 0 value should be 5
        assertEquals(gaufre.memory[0], 5);
    }

    //Test Memory cursors OP_MEM_LEFT and OP_MEM_RIGHT
    public function testMemArgs():Void {
        //Reset Gaufre instance
        var gaufre = new Gaufre(32, 64);

        var program = [
            GOpcodes.OP_MEM_RIGHT(3),
            GOpcodes.OP_MEM_RIGHT(2),
            GOpcodes.OP_MEM_RIGHT(1),
            GOpcodes.OP_INC(1),
            GOpcodes.OP_MEM_LEFT(1),
            GOpcodes.OP_MEM_LEFT(1),
            GOpcodes.OP_MEM_LEFT(1),
            GOpcodes.OP_MEM_LEFT(1),
            GOpcodes.OP_MEM_LEFT(2),
            GOpcodes.OP_INC(1)
        ];
        //[]

        //Load the program and run
        gaufre.LoadProgram(program);
        gaufre.Run();

        //Cell 0 value should be 5
        assertEquals(gaufre.memory[0] == gaufre.memory[6], true);
    }

    //Test OP_GOTO with arguments
    public function testGotoArgs():Void {
        //Reset Gaufre instance
        var gaufre = new Gaufre(32, 64);
        
        var program = [
            GOpcodes.OP_INC(5),
            GOpcodes.OP_GOTO(3), /* Bypass the OP_DEC */
            GOpcodes.OP_DEC(5),
            GOpcodes.OP_INC(1)
        ];

        //Load the program and run
        gaufre.LoadProgram(program);
        gaufre.Run();

        //Cell 0 value should be 6
        assertEquals(gaufre.memory[0], 6);
    }

    //Reset Gaufre interpreter
    public function ResetPartGaufre (inter:Gaufre) {
        inter.program = [];
        inter.memory = Utils.CreateEmptyIntArray(inter.memory.length, 0);
        inter.pc = -1;
    }

}