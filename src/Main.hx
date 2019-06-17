package;

import sys.FileSystem;

import Gaufre;
import FileParser as Fp;

//Remove main in library mode
#if !lib
class Main {
    public static function main() {



        //Get program arguments 
        var ProgramArgs = Sys.args();

        if (ProgramArgs.length == 3) {

            //Check if the file exists
            if (!FileSystem.exists(ProgramArgs[0])) {
                Sys.println("Error: The file doesn't exists");

                return;
            }

            //Check if the number of cells is valid
            var parsedCellNumber = Std.parseInt(ProgramArgs[1]);

            if (parsedCellNumber < 0 || parsedCellNumber == null) {
                Sys.println("Error: The number of memory cell is invalid or missing");

                return;
            }

            //Check if the memory cell size if valid
            var parsedMemorySize = Std.parseInt(ProgramArgs[2]);

            //Check parsed value - Debugs
            trace("Memory size: " + parsedMemorySize);
            
            
            if (parsedMemorySize <= 0 || parsedMemorySize == null) {
                Sys.println("Error: The memory size is invalid");

                return;
            }
            
            //If everything seems to be valid...
            //Create instance
            var gaufre = new Gaufre(parsedCellNumber, parsedMemorySize);

            //Read the specified file and generate an array of Gaufre opcodes
            var fileContent = Fp.ParseFile(ProgramArgs[0]);

            //Load the program into the Gaufre interpreer
            gaufre.LoadProgram(fileContent);

            //Run the program
            gaufre.Run();


        } else {
            Sys.println("- # Gaufre interpreter " + Gaufre.G_VERSION + " -");
            Sys.println("Usage : <File> <Number of memory cells> <Size of the cells>");
        }
        
    }
}

#end