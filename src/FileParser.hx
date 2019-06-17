package;

import GaufreInstruction;

//Basic file parser
class FileParser {

    //Read a file and generate a array of GOpcodes - Disabled in JS
    #if !js
    public static function ParseFile(path:String) {
        
        //String containing opcodes
        var input:String = "";

        //Open file
        var file = sys.io.File.read(path, false);

        //Try reading the file line by line
        //TODO: Find a less hacky way to read the file

        try {
            
            while (true) {
                input += file.readLine() + "\n";
            }

        } catch (e:haxe.io.Eof) {}

        //Close the file
        file.close();

        //Parse string
        return ParseString(input);

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

            //Add elements if the array is too short (< 3)
            var elements = currentLine.length;

            while (elements < 4) {
                currentLine.push(null);
                elements++;
            }
            
            //Check line - DEBUG
            trace(currentLine);

            //Convert int -> opcode 
            var convertedOpcode = IntToOpcode(currentLine[0], currentLine[1], currentLine[2], currentLine[3]);

            //Check instruction - Debug
            trace("Opcode : " + convertedOpcode);

            //Push instruction to Array - Check if the opcode exists
            if (convertedOpcode != null) 
                GOpcodeArray.push(convertedOpcode);
        }

        //We have done parsing - Debug:
        trace("Done parsing - Fetched " + GOpcodeArray.length + " instruction(s)");

        return GOpcodeArray;
    }

    //Convert the id opcode to a GOpcode equivalent
    //TODO: Make it a lot better
    public static function IntToOpcode (opcodeId:Int, opCodeArg1:Int, opCodeArg2:Int, opCodeArg3:Int ) {
        
        var returnOpcode:GOpcodes = null;

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
            default: /* Ignore conversion */
        }

        return returnOpcode;
    }
}