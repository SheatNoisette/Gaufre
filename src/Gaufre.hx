package;

import haxe.Constraints.Constructible;

import GaufreInstruction;
import IO;

@:keepSub
class Gaufre {

    //Cell memory
    var memory:Array<Int>;

    //Pointer to memory
    var memoryPointer:Int = 0;

    //Max memory cell size
    var memorySize:Int;

    //Program counter
    var pc:Int = -1;

    //Length of the memory array
    var memoryLength:Int;

    //Instructions
    var program:Array<GOpcodes>;

    //Quit the interpreter
    var exitGaufre = false;

    //Create a Gaufre instance
    public function new(?cellMemory:Int = 32, ?maxCellSize:Int = 255) {

        //Create the memory cell needed
        memory = Utils.CreateEmptyIntArray(cellMemory, 0);

        //Create a empty array of Instructions
        program = [];

        //Maximum memorySize
        memorySize = maxCellSize;

        //Maximum length of the memory array
        memoryLength = cellMemory;

    }

    //Execute instructions one by one 
    public function Run() {

        //Check if we want to qui the interpreter or when the program counter exceed the program size 
        while (!exitGaufre && pc < program.length) {
            pc++;
            RunInstruction(program[pc]);
        }
    }

    //Execute an instruction
    public function RunInstruction(inst:GOpcodes) {

        switch (inst) {
            case OP_EXIT: exitGaufre = true;         
            case OP_INC (number): AddMemory(number);
            case OP_DEC (number): AddMemory(-number);
            case OP_MEM_LEFT (move): memoryPointer = (memoryPointer + move) % memoryLength;
            case OP_MEM_RIGHT (move): memoryPointer = Utils.IntAbs((memoryPointer - move) % memoryLength);
            case OP_GOTO(line): pc = line;            
            case OP_GOTOEQ(var1, var2, line): pc = var1 == var2 ? line : pc;            
            case OP_INPUT:            
            case OP_OUTPUT:            
            case OP_NONE: /* Do nothing */
            default:
                trace("Invalid opcode detected!");
        }


    }

    // Safely Increment / Decrement selected memory cell without overflow/underflow
    private function AddMemory(number:Int) {

        //Do the needed operation
        var operation = memory[memoryPointer] + number;

        if (operation < 0) 
            memory[memoryPointer] = memorySize + operation;
        else if (operation > memorySize)
            memory[memoryPointer] = operation % memorySize;
        else
            memory[memoryPointer] = operation;
    }

    //Add a instruction to the program array
    public function PushInstruction(inst:GOpcodes) {
        program.push(inst);
    }

    // Load a program translated to a GOpcodes equivalent
    public function LoadProgram(prog:Array<GOpcodes>) {
        for (instruction in prog){
            PushInstruction(instruction);
        }
    }

    //-----------------------
    // Debugging
    
    #if debug

    //Print every memory cell
    private function PrintMemory() {

        for (m in memory) {
            Sys.print(memory + " | ");
        }

    }

    //Print program
    private function PrintProgram() {

    }
    #end
}