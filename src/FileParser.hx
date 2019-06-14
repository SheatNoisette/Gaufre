package;

import GaufreInstruction;

//Basic file parser
class FileParser {

    //Read a file and generate a array of GOpcodes - Disabled in JS
    #if !js
    public static function ParseFile(){

    }
    #end

    //Read a string and generate a array of GOpcodes
    public static function ParseString(input:String):Array<GOpcodes> {
        
        // Split at every '\n' char
        var splitedString:Array<String> = input.split("\n");


        //Final GOpcodes array
        var GOpcodeArray:Array<GOpcodes> = [];

        //Generate opcode for every line
        for (line in splitedString) {
            
            //Split at space to count number of '#' char
            var currentLine:Array<Dynamic> = line.split(" ");

            //Check line - DEBUG
            trace(currentLine);

            //Count the number of '#' in each line
            currentLine = [for (e in currentLine) Utils.CountChar(e, "#")];
            
            //Check line - DEBUG
            trace(currentLine);

            //Add elements if the array is too short (<3)
            var elements = currentLine.length;

            while (elements < 4) {
                currentLine.push(null);
                elements++;
            }
            
            //Check line - DEBUG
            trace(currentLine);

            //Convert this array to GOpcode and push it to the GOpcode array
            GOpcodeArray.push(IntToOpcode(currentLine[0], currentLine[1], currentLine[2], currentLine[3]));
        }


        return GOpcodeArray;
    }

    //Convert the id opcode to a GOpcode equivalent
    //TODO: Make it a lot better
    public static function IntToOpcode (opcodeId:Int, opCodeArg1:Int, opCodeArg2:Int, opCodeArg3:Int ) {
        
        var returnOpcode:GOpcodes = GOpcodes.OP_NONE;

        switch (opcodeId) {
            case 1: returnOpcode = GOpcodes.OP_EXIT;
            case 2: returnOpcode = GOpcodes.OP_INC(opCodeArg1);
            case 3: returnOpcode = GOpcodes.OP_DEC(opCodeArg1);
            case 4: returnOpcode = GOpcodes.OP_MEM_LEFT (opCodeArg1);
            case 5: returnOpcode = GOpcodes.OP_MEM_RIGHT (opCodeArg1);
            case 6: returnOpcode = GOpcodes.OP_GOTO (opCodeArg1);
            case 7: returnOpcode = GOpcodes.OP_GOTOEQ (opCodeArg1, opCodeArg2, opCodeArg3);
            case 8: returnOpcode = GOpcodes.OP_INPUT;
            case 9: returnOpcode = GOpcodes.OP_OUTPUT;
            case 10: returnOpcode = GOpcodes.OP_NONE;
        }

        return returnOpcode;
    }
}