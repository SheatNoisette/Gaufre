package;

import Gaufre;
import FileParser as Fp;

//Remove main in library mode
#if !lib
class Main {
    public static function main() {

        //Create instance
        var gaufre = new Gaufre(32);

        //Get program arguments 
        var ProgramArgs = Sys.args();
        
        Fp.ParseString("#### #####\n###### #");
        //gaufre.LoadProgram(Fp.ParseString("#### #####\n###### #"));

        if (ProgramArgs.length == 2) {

        } else {
            Sys.println("- # Gaufre interpreter -");
            Sys.println("Usage : <File> <Number of memory cells>");
        }
        
    }
}

#end