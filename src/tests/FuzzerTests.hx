package tests;

using Std;

import GaufreInstruction;
import Gaufre;

class FuzzerTests extends haxe.unit.TestCase {
    //This tests tries to crash the interpreter by a method named "Fuzzing"

    //Maximum opcodes generated
    public static var maximumInstruction = 200;

    //Maximum instructions executed
    public static var maximumIteration = 200;
    
    //Create a Gaufre instance
    var gaufre = new Gaufre();

    public function testFuzz():Void {

        //Create array
        var fuzzerArray:Array<GOpcodes> = [];
        var cursor = 0;

        while (cursor < maximumInstruction) {
            fuzzerArray.push(GenerateInstruction());
            cursor++;
        }

        //Run instruction step by step
        var pc = 0;

        while (pc < maximumIteration - 1) {
            gaufre.RunInstruction(fuzzerArray[pc % maximumIteration]);
            pc++;
        }

        //The interpreter has successfully 'survived' the fuzzing
        assertEquals(true, true);
    }

    //Brutal fuzzing
    public function testBrutalFuzz():Void {

        for (i in 0...1000) {
            testFuzz();
        }

        //The interpreter has successfully 'survived' the brutal fuzzing
        assertEquals(true, true);
    }

    //Generate a random instruction with arguments - OP_INPUT and OP_OUTPUT removed
    private function GenerateInstruction():GOpcodes {
        
        var opcodeOut:GOpcodes = GOpcodes.OP_NONE;
        var choosenOpcode = Std.random(7) + 1;

        switch (choosenOpcode) {
            case 1: opcodeOut = GOpcodes.OP_EXIT;
            case 2: opcodeOut = GOpcodes.OP_INC(Std.random(255) + 1);
            case 3: opcodeOut = GOpcodes.OP_DEC(Std.random(255) + 1);
            case 4: opcodeOut = GOpcodes.OP_MEM_LEFT (Std.random(255) + 1);
            case 5: opcodeOut = GOpcodes.OP_MEM_RIGHT (Std.random(255) + 1);
            case 6: opcodeOut = GOpcodes.OP_GOTO (Std.random(255) + 1);
            case 7: opcodeOut = GOpcodes.OP_GOTOEQ (Std.random(255) + 1, Std.random(255) + 1, Std.random(255) + 1);
            case 8: opcodeOut = GOpcodes.OP_NONE;
            default: /* Error */
        }

        return opcodeOut;
    }
}