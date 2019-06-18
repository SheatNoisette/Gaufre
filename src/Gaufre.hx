package;

using haxe.Utf8;

import GaufreInstruction;
import IO;
import Utils;

@:keepSub
class Gaufre {

    //Version of the interpreter
    public static inline var G_VERSION = "0.0.5";

    //Cell memory
    public var memory:Array<Int>;

    //Pointer to memory
    var memoryPointer:Int = 0;

    //Max memory cell size
    var memorySize:Int;

    //Program counter
    public var pc:Int = -1;

    //Length of the memory array
    var memoryLength:Int;

    //Instructions
    public var program:Array<GOpcodes>;

    //Quit the interpreter
    var exitGaufre = false;

    //Supported characters
    static var charMap:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890\n";

    //Create a Gaufre instance
    public function new(?cellMemory:Int = 100, ?maxCellSize:Int = 255) {

        //Create the memory cell needed
        memory = Utils.CreateEmptyIntArray(cellMemory, 0);

        //Create a empty array of Instructions
        program = [];

        //Maximum memorySize
        memorySize = maxCellSize + 1;

        //Maximum length of the memory array
        memoryLength = cellMemory;

    }

    //Execute instructions one by one 
    public function Run() {
        //Check if we want to quit the interpreter or when the program counter exceed the program size 
        while (!exitGaufre && pc < program.length - 1) {
            RunInstruction(program[++pc]);

            //Print state of the interpreter - Debug
            trace("PC: " + pc + " Inst: " + program[pc]);
        }
    }

    //Execute an instruction
    public function RunInstruction(inst:GOpcodes) {

        switch (inst) {
            case OP_EXIT: exitGaufre = true;         
            case OP_INC (number): AddMemory(number);
            case OP_DEC (number): AddMemory(-number);
            case OP_MEM_LEFT (move): MoveMemLeft(move);
            case OP_MEM_RIGHT (move): MoveMemRight(move);
            case OP_GOTO(line): Goto(line);          
            case OP_GOTOEQ(var1, var2, line): GotoEquals(var1, var2, line);           
            case OP_INPUT: Sys.println("UNIMPLEMENTED");          
            case OP_OUTPUT (char): PrintChar(char);
            case OP_NONE: /* Do nothing */
            default:
                trace("Invalid opcode detected!");
        }


    }

    //Opcodes handlers

    // Move memory cursor on the left
    private function MoveMemLeft(move:Int):Void {

        move = NullReplace(move);
        memoryPointer = (memoryPointer + move) % memoryLength;
    }
    
    // Move memory cursor on the right
    private function MoveMemRight(move:Int):Void {

        move = NullReplace(move);
        memoryPointer = Utils.IntAbs((memoryPointer - move) % memoryLength);
    }

    // Goto without conditions
    private function Goto(line:Int):Void {
        GotoEquals(0, 0, line);
    }

    // Goto when var1 == var2
    private function GotoEquals(var1:Int, var2:Int, line:Int):Void {
        
        //Update values
        var1 = NullReplace(var1);
        var2 = NullReplace(var1);
        line = NullReplace(line);

        if (var1 == var2) {
            pc = line - 1;
        }
    }

    // Output a string/char to console
    private function PrintChar(charCode:Int):Void {
        charCode = NullReplace(charCode);

        //Check if we exceed the size of the string
        var finalCharcodeId = charCode <= charMap.length - 1 ? charCode : charMap.length - 1;

        IO.Print(charMap.charAt(finalCharcodeId));
    }

    // If a instruction has no argument, take the current selected memory cell value
    private function NullReplace(input:Int) {
        return input == null ? memory[memoryPointer] : input;
    }

    // Safely Increment / Decrement selected memory cell without overflow/underflow
    private function AddMemory(number:Int) {

        //Do the needed operation
        var operation = memory[memoryPointer] + number;

        if (operation < 0) {
            //Math modulo
            memory[memoryPointer] = operation - memorySize * Math.round(operation / memorySize);

        } else if (operation > memorySize) {
            memory[memoryPointer] = operation % memorySize;

        } else {
            memory[memoryPointer] = operation;

        }
    }

    //Add a instruction to the program array
    public function PushInstruction(inst:GOpcodes):Void {
        //Debug - What's really pushed
        trace("Pushed : " + inst);

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
    public function PrintMemory() {

        for (m in memory) {
            Sys.print(memory + " | ");
        }

    }

    //Print program
    public function PrintProgram() {
        var line:Int = 0;

        for (inst in program) {
            Sys.println((line++) +": " + inst);
        }
    }
    #end
}